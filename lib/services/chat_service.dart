import 'package:dio/dio.dart';
import 'api_config.dart';
import '../utils/shared_pref.dart';

class ChatService {
  final Dio _dio = Dio();
  final SharedPref _sharedPref = SharedPref();
  
  Future<String?> _getToken() async {
    return await _sharedPref.getToken();
  }

  Future<Map<String, dynamic>> sendMessage({
    required String receiverId,
    required String message,
    List<Map<String, dynamic>>? attachments,
  }) async {
    try {
      final token = await _getToken();
      final response = await _dio.post(
        '${ApiConfig.baseUrl}/chat/send',
        data: {
          'receiverId': receiverId,
          'message': message,
          if (attachments != null) 'attachments': attachments,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  Future<List<dynamic>> getChatHistory(String userId) async {
    try {
      print('🔍 Fetching chat history with user: $userId');
      final token = await _getToken();
      print('🔑 Token: ${token?.substring(0, 20)}...');
      
      final response = await _dio.get(
        '${ApiConfig.baseUrl}/chat/history/$userId',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      
      print('✅ Chat history response: ${response.statusCode}');
      print('📦 Response data: ${response.data}');
      
      if (response.data != null && response.data['data'] != null) {
        return response.data['data'] ?? [];
      }
      return [];
    } catch (e) {
      print('❌ Error getting chat history: $e');
      throw Exception('Failed to get chat history: $e');
    }
  }

  Future<void> markAsRead(String senderId) async {
    try {
      final token = await _getToken();
      await _dio.put(
        '${ApiConfig.baseUrl}/chat/read',
        data: {'senderId': senderId},
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
    } catch (e) {
      throw Exception('Failed to mark as read: $e');
    }
  }

  Future<void> sendTypingIndicator(String receiverId, bool isTyping) async {
    try {
      final token = await _getToken();
      await _dio.post(
        '${ApiConfig.baseUrl}/chat/typing',
        data: {
          'receiverId': receiverId,
          'isTyping': isTyping,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
    } catch (e) {
      // Silently fail for typing indicators
    }
  }

  Future<Map<String, dynamic>> getPusherAuth(String socketId, String channelName) async {
    try {
      final token = await _getToken();
      final response = await _dio.post(
        '${ApiConfig.baseUrl}/chat/pusher/auth',
        data: {
          'socket_id': socketId,
          'channel_name': channelName,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to authenticate with Pusher: $e');
    }
  }

  Future<List<dynamic>> getConversations() async {
    try {
      final token = await _getToken();
      final response = await _dio.get(
        '${ApiConfig.baseUrl}/chat/conversations',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      return response.data['data'] ?? [];
    } catch (e) {
      throw Exception('Failed to get conversations: $e');
    }
  }
}
