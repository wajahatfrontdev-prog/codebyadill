import 'package:flutter/material.dart';
import 'package:icare/utils/imagePaths.dart';
import 'package:icare/utils/theme.dart';
import 'package:icare/widgets/back_button.dart';
import 'package:icare/widgets/custom_text.dart';

class VideoCall extends StatelessWidget {
  const VideoCall({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 900;

    if (isDesktop) {
      return const _WebVideoCall();
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /// 👨‍⚕️ Main Doctor Image (Full Screen)
          Positioned.fill(
            child: Container(
              color: AppColors.tertiaryColor,
              child: Image.asset(
                ImagePaths.user1, // replace with your main image
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// 🔙 Back Button (Top Left)
          const Positioned(
            top: 40,
            child: CustomBackButton(color: Colors.white),
          ),

          /// 👤 Remote User Thumbnail (Top Right)
          Positioned(
            top: 60,
            right: 15,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    ImagePaths.user5, // replace with your second image
                    width: 120,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.mic_off, size: 14, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// 🎛 Bottom Control Panel
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildControlButton(Icons.volume_up_rounded, Colors.white, false),
                    _buildControlButton(Icons.mic_off_rounded, Colors.white, false),
                    _buildControlButton(Icons.call_end_rounded, Colors.white, true),
                    _buildControlButton(Icons.videocam_off_rounded, Colors.white, false),
                    _buildControlButton(Icons.grid_view_rounded, Colors.white, false),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton(IconData icon, Color color, bool isEnd) {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        color: isEnd ? const Color(0xFFEF4444) : Colors.white.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(icon, color: color, size: 26),
      ),
    );
  }
}

class _WebVideoCall extends StatelessWidget {
  const _WebVideoCall();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Stack(
        children: [
          // Main Video Area
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          ImagePaths.user1,
                          fit: BoxFit.cover,
                        ),
                        // Label
                        Positioned(
                          bottom: 24,
                          left: 24,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.mic_rounded, color: Colors.white, size: 16),
                                SizedBox(width: 8),
                                Text(
                                  "Dr. Adam Smith",
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Sidebar for self view and chat toggles
              Container(
                width: 380,
                margin: const EdgeInsets.fromLTRB(0, 20, 20, 20),
                child: Column(
                  children: [
                    // Self View
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E293B),
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(28),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.asset(
                                ImagePaths.user5,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                bottom: 16,
                                left: 16,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    "Aron Smith (You)",
                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Call Info / Transcription / Chat Area (Placeholder)
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E293B),
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(
                              text: "Session Details",
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              fontFamily: "Gilroy-Bold",
                            ),
                            const SizedBox(height: 24),
                            _buildInfoItem(Icons.access_time_filled_rounded, "Remaining Time", "42:15"),
                            const SizedBox(height: 20),
                            _buildInfoItem(Icons.security_rounded, "Encryption", "End-to-End Secure"),
                            const SizedBox(height: 20),
                            _buildInfoItem(Icons.favorite_rounded, "Health Topic", "Cardiology Review"),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Column(
                                children: [
                                  Text(
                                    "Waiting for Dr. Smith to share diagnostic results...",
                                    style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13, height: 1.5),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Top Header (Overlay)
          Positioned(
            top: 40,
            left: 50,
            right: 50,
            child: Row(
              children: [
                const CustomBackButton(margin: EdgeInsets.zero, color: Colors.white),
                const SizedBox(width: 24),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Medical Consultation",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800, fontFamily: "Gilroy-Bold"),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.circle, color: Color(0xFFEF4444), size: 8),
                        SizedBox(width: 8),
                        Text(
                          "REC 00:15:28",
                          style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                _buildHeaderIcon(Icons.person_add_rounded),
                const SizedBox(width: 12),
                _buildHeaderIcon(Icons.settings_rounded),
              ],
            ),
          ),

          // Floating Controls (Overlay Bottom)
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A).withOpacity(0.9),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 40,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildWebControlBtn(Icons.mic_rounded, "Mute", false),
                    const SizedBox(width: 24),
                    _buildWebControlBtn(Icons.videocam_rounded, "Camera", false),
                    const SizedBox(width: 24),
                    _buildWebControlBtn(Icons.monitor_rounded, "Share", false),
                    const SizedBox(width: 24),
                    _buildWebControlBtn(Icons.chat_bubble_outline_rounded, "Chat", false),
                    const SizedBox(width: 40),
                    _buildWebControlBtn(Icons.call_end_rounded, "End Call", true),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryColor, size: 20),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Color(0xFF64748B), fontSize: 11, fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w700)),
          ],
        ),
      ],
    );
  }

  Widget _buildHeaderIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }

  Widget _buildWebControlBtn(IconData icon, String label, bool isEnd) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: isEnd ? const Color(0xFFEF4444) : Colors.white.withOpacity(0.05),
            shape: BoxShape.circle,
            border: Border.all(color: isEnd ? Colors.transparent : Colors.white.withOpacity(0.1)),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: isEnd ? const Color(0xFFEF4444) : const Color(0xFF94A3B8),
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}