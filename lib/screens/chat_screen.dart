import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../services/chat_service.dart';
import '../utils/theme.dart';
import '../utils/shared_pref.dart';

class ChatScreen extends StatefulWidget {
  final String userId;
  final String userName;
  final String? userImage;

  const ChatScreen({
    super.key,
    required this.userId,
    required this.userName,
    this.userImage,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatService _chatService = ChatService();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _messageFocusNode = FocusNode();
  
  List<dynamic> _messages = [];
  bool _isLoading = true;
  bool _isSending = false;
  bool _isTyping = false;
  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _loadCurrentUser();
    await _loadChatHistory();
    _setupTypingListener();
  }

  Future<void> _loadCurrentUser() async {
    try {
      final userData = await SharedPref().getUserData();
      if (mounted) {
        setState(() {
          _currentUserId = userData?.id;
        });
      }
    } catch (e) {
      print('❌ Error loading current user: $e');
      if (mounted) {
        setState(() {
          _currentUserId = null;
        });
      }
    }
  }

  void _setupTypingListener() {
    _messageController.addListener(() {
      final isCurrentlyTyping = _messageController.text.isNotEmpty;
      if (isCurrentlyTyping != _isTyping) {
        setState(() => _isTyping = isCurrentlyTyping);
        _chatService.sendTypingIndicator(widget.userId, isCurrentlyTyping);
      }
    });
  }

  Future<void> _loadChatHistory() async {
    try {
      print('🔍 Loading chat history for user: ${widget.userId}');
      final messages = await _chatService.getChatHistory(widget.userId);
      print('✅ Received ${messages.length} messages');
      
      setState(() {
        _messages = messages;
        _isLoading = false;
      });
      _scrollToBottom();
      await _chatService.markAsRead(widget.userId);
    } catch (e) {
      print('❌ Error loading chat history: $e');
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load messages: $e')),
        );
      }
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isEmpty || _isSending) return;

    final messageText = _messageController.text.trim();
    _messageController.clear();
    setState(() => _isSending = true);

    try {
      final result = await _chatService.sendMessage(
        receiverId: widget.userId,
        message: messageText,
      );
      
      setState(() {
        _messages.add(result['data']);
        _isSending = false;
      });
      _scrollToBottom();
    } catch (e) {
      setState(() => _isSending = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send message: $e')),
        );
      }
      // Restore message text on failure
      _messageController.text = messageText;
    }
  }

  Future<void> _refreshMessages() async {
    await _loadChatHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundColor: AppColors.primaryColor.withOpacity(0.1),
              backgroundImage: widget.userImage != null
                  ? NetworkImage(widget.userImage!)
                  : null,
              child: widget.userImage == null
                  ? Text(
                      widget.userName[0].toUpperCase(),
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Online',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black),
            onPressed: _refreshMessages,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  )
                : _messages.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.chat_bubble_outline,
                              size: 80.sp,
                              color: Colors.grey[300],
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              'No messages yet',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Start the conversation!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _refreshMessages,
                        color: AppColors.primaryColor,
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.all(16.w),
                          itemCount: _messages.length,
                          itemBuilder: (context, index) {
                            final message = _messages[index];
                            final isMe = message['sender']['_id'] != widget.userId;
                            
                            // Show date separator if needed
                            bool showDateSeparator = false;
                            if (index == 0) {
                              showDateSeparator = true;
                            } else {
                              final prevMessage = _messages[index - 1];
                              final prevDate = DateTime.parse(prevMessage['createdAt']);
                              final currentDate = DateTime.parse(message['createdAt']);
                              showDateSeparator = !_isSameDay(prevDate, currentDate);
                            }

                            return Column(
                              children: [
                                if (showDateSeparator)
                                  _buildDateSeparator(
                                    DateTime.parse(message['createdAt']),
                                  ),
                                _buildMessageBubble(message, isMe),
                              ],
                            );
                          },
                        ),
                      ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Widget _buildDateSeparator(DateTime date) {
    final now = DateTime.now();
    String dateText;

    if (_isSameDay(date, now)) {
      dateText = 'Today';
    } else if (_isSameDay(date, now.subtract(const Duration(days: 1)))) {
      dateText = 'Yesterday';
    } else {
      dateText = DateFormat('MMM dd, yyyy').format(date);
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        children: [
          Expanded(child: Divider(color: Colors.grey[300])),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              dateText,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(child: Divider(color: Colors.grey[300])),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message, bool isMe) {
    final timestamp = DateTime.parse(message['createdAt']);
    final timeStr = DateFormat('HH:mm').format(timestamp);
    final isRead = message['read'] ?? false;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        constraints: BoxConstraints(maxWidth: 280.w),
        decoration: BoxDecoration(
          color: isMe ? AppColors.primaryColor : Colors.grey[200],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomLeft: isMe ? Radius.circular(16.r) : Radius.zero,
            bottomRight: isMe ? Radius.zero : Radius.circular(16.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message['message'],
              style: TextStyle(
                color: isMe ? Colors.white : Colors.black87,
                fontSize: 15.sp,
                height: 1.4,
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  timeStr,
                  style: TextStyle(
                    color: isMe ? Colors.white70 : Colors.grey,
                    fontSize: 11.sp,
                  ),
                ),
                if (isMe) ...[
                  SizedBox(width: 4.w),
                  Icon(
                    isRead ? Icons.done_all : Icons.done,
                    size: 14.sp,
                    color: isRead ? Colors.blue[200] : Colors.white70,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: TextField(
                  controller: _messageController,
                  focusNode: _messageFocusNode,
                  decoration: const InputDecoration(
                    hintText: 'Type a message...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  maxLines: null,
                  textCapitalization: TextCapitalization.sentences,
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: _isSending ? null : _sendMessage,
              child: Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: _isSending ? Colors.grey : AppColors.primaryColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: _isSending
                    ? Padding(
                        padding: EdgeInsets.all(12.w),
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Icon(Icons.send, color: Colors.white, size: 22.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _messageFocusNode.dispose();
    super.dispose();
  }
}
