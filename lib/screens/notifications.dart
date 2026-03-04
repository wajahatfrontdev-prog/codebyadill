import 'package:flutter/material.dart';
import 'package:flutter_size_matters/flutter_size_matters.dart';
import 'package:icare/utils/theme.dart';
import 'package:icare/utils/utils.dart';
import 'package:icare/widgets/back_button.dart';
import 'package:icare/widgets/custom_text.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Utils.windowWidth(context) > 600;

    final List<Map<String, dynamic>> notifications = [
      {
        "id": 1,
        "title": "Booking Confirmed",
        "description": "Your appointment with Dr. Adam Smith has been confirmed.",
        "time": "Just now",
        "unread": true,
        "type": "success",
      },
      {
        "id": 2,
        "title": "Payment Successful",
        "description": "Payment of \$50.00 for Lab Test was successful.",
        "time": "1 hour ago",
        "unread": true,
        "type": "payment",
      },
      {
        "id": 3,
        "title": "Upcoming Consultation",
        "description": "Reminder: Video consultation starts in 20 minutes.",
        "time": "2 hours ago",
        "unread": false,
        "type": "reminder",
      },
      {
        "id": 4,
        "title": "Lab Results Ready",
        "description": "Your recent blood test results are now available to view.",
        "time": "Yesterday",
        "unread": false,
        "type": "document",
      },
      {
        "id": 5,
        "title": "Prescription Updated",
        "description": "Dr. Emily Jordan has updated your active prescriptions.",
        "time": "Yesterday",
        "unread": false,
        "type": "medical",
      },
      {
        "id": 6,
        "title": "New Message",
        "description": "You have a new message from Support.",
        "time": "Oct 12, 10:30 AM",
        "unread": false,
        "type": "message",
      },
    ];

    if (!isDesktop) {
      // ─── MOBILE ORIGINAL / FIXED ────────────────────────────────────────────
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: CustomBackButton(),
          title: CustomText(
            text: "Notifications",
            fontSize: 18,
            fontFamily: "Gilroy-Bold",
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: ListView.separated(
          itemCount: notifications.length,
          separatorBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: ScallingConfig.scale(20)),
            child: Divider(color: AppColors.grayColor.withOpacity(0.3), height: 1),
          ),
          itemBuilder: (context, index) {
            final notif = notifications[index];
            final bool isUnread = notif["unread"];

            return Container(
              color: isUnread ? AppColors.primaryColor.withOpacity(0.05) : Colors.transparent,
              padding: EdgeInsets.symmetric(
                vertical: ScallingConfig.verticalScale(16),
                horizontal: ScallingConfig.scale(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: _getIconColor(notif["type"]).withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _getIcon(notif["type"]),
                      color: _getIconColor(notif["type"]),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 14),
                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: CustomText(
                                text: notif["title"],
                                color: isUnread ? const Color(0xFF0F172A) : AppColors.darkGreyColor,
                                fontWeight: isUnread ? FontWeight.w800 : FontWeight.w600,
                                fontSize: 15,
                                fontFamily: "Gilroy",
                              ),
                            ),
                            if (isUnread)
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: AppColors.primaryColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        CustomText(
                          text: notif["description"],
                          fontSize: 13,
                          color: const Color(0xFF64748B),
                          fontFamily: "Gilroy",
                          fontWeight: FontWeight.w500,
                          maxLines: 2,
                        ),
                        const SizedBox(height: 8),
                        CustomText(
                          text: notif["time"],
                          fontSize: 11,
                          color: const Color(0xFF94A3B8),
                          fontFamily: "Gilroy",
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    }

    // ─── DESKTOP PREMIUM DESIGN ─────────────────────────────────────────────
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          // Premium White Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 16,
              bottom: 24,
              left: 48,
              right: 48,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0F172A).withOpacity(0.04),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.arrow_back_rounded,
                            color: Color(0xFF0F172A), size: 22),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Notifications",
                            fontSize: 26,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF0F172A),
                            letterSpacing: -0.5,
                          ),
                          const SizedBox(height: 2),
                          CustomText(
                            text: "Stay updated with your latest activity",
                            fontSize: 14,
                            color: const Color(0xFF94A3B8),
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.mark_email_unread_rounded,
                              size: 16, color: AppColors.primaryColor),
                          const SizedBox(width: 8),
                          CustomText(
                            text: "2 Unread",
                            fontSize: 14,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Notifications List
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notif = notifications[index];
                    final bool isUnread = notif["unread"];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isUnread ? AppColors.primaryColor.withOpacity(0.3) : const Color(0xFFF1F5F9),
                          width: isUnread ? 1.5 : 1,
                        ),
                        boxShadow: [
                          if (isUnread)
                            BoxShadow(
                              color: AppColors.primaryColor.withOpacity(0.04),
                              blurRadius: 16,
                              offset: const Offset(0, 4),
                            )
                          else
                            BoxShadow(
                              color: const Color(0xFF0F172A).withOpacity(0.02),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              color: _getIconColor(notif["type"]).withOpacity(0.12),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              _getIcon(notif["type"]),
                              color: _getIconColor(notif["type"]),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: notif["title"],
                                      color: const Color(0xFF0F172A),
                                      fontWeight: isUnread ? FontWeight.w800 : FontWeight.w600,
                                      fontSize: 17,
                                    ),
                                    CustomText(
                                      text: notif["time"],
                                      fontSize: 13,
                                      color: const Color(0xFF94A3B8),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                CustomText(
                                  text: notif["description"],
                                  fontSize: 14,
                                  color: const Color(0xFF64748B),
                                  fontWeight: FontWeight.w500,
                                  lineHeight: 1.4,
                                ),
                              ],
                            ),
                          ),
                          if (isUnread) ...[
                            const SizedBox(width: 16),
                            Container(
                              margin: const EdgeInsets.only(top: 6),
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIcon(String type) {
    switch (type) {
      case "success": return Icons.check_circle_rounded;
      case "payment": return Icons.account_balance_wallet_rounded;
      case "reminder": return Icons.videocam_rounded;
      case "document": return Icons.description_rounded;
      case "medical": return Icons.medical_services_rounded;
      case "message": return Icons.forum_rounded;
      default: return Icons.notifications_rounded;
    }
  }

  Color _getIconColor(String type) {
    switch (type) {
      case "success": return const Color(0xFF22C55E); // Green
      case "payment": return const Color(0xFF3B82F6); // Blue
      case "reminder": return const Color(0xFFF59E0B); // Amber
      case "document": return const Color(0xFF8B5CF6); // Purple
      case "medical": return const Color(0xFFEF4444); // Red
      case "message": return const Color(0xFF14B1FF); // Cyan
      default: return AppColors.primaryColor;
    }
  }
}
