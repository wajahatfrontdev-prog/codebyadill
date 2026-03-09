import 'package:flutter/material.dart';
import 'package:flutter_size_matters/flutter_size_matters.dart';
import 'package:icare/screens/fill_lab_form.dart';
import 'package:icare/utils/imagePaths.dart';
import 'package:icare/utils/theme.dart';
import 'package:icare/utils/utils.dart';
import 'package:icare/widgets/back_button.dart';
import 'package:icare/widgets/custom_button.dart';
import 'package:icare/widgets/custom_text.dart';
import 'package:icare/widgets/svg_wrapper.dart';
import 'package:icare/widgets/custom_check_box.dart';

class LabDetails extends StatelessWidget {
  const LabDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = ResponsiveHelper.isDesktop(context);

    return Scaffold(
      appBar: isDesktop
          ? null // Custom premium header for web
          : AppBar(
              automaticallyImplyLeading: false,
              leading: const CustomBackButton(),
              title: const CustomText(text: "Lab Details"),
            ),
      body: isDesktop ? _buildWebLayout(context) : _buildMobileLayout(context),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                ImagePaths.lab3,
                fit: BoxFit.cover,
                width: Utils.windowWidth(context) * 0.9,
                height: Utils.windowWidth(context) * 0.5,
              ),
            ),
            SizedBox(height: ScallingConfig.scale(20)),
            CustomText(
              width: Utils.windowWidth(context) * 0.9,
              text: "Quantum Spar Lab",
              fontFamily: 'Gilroy-Bold',
              fontSize: 14.78,
              color: AppColors.themeDarkGrey,
            ),
            SizedBox(height: ScallingConfig.scale(10)),
            CustomText(
              width: Utils.windowWidth(context) * 0.9,
              text: "Our laboratory combines advanced diagnostic technology with the expertise of highly qualified professionals, ensuring every test is conducted with precision, accuracy, and reliability to support better healthcare outcomes.",
              fontFamily: 'Gilroy-SemiBold',
              maxLines: 10,
              fontSize: 10.88,
              color: AppColors.grayColor,
            ),
            SizedBox(height: ScallingConfig.scale(15)),
            SizedBox(
              width: Utils.windowWidth(context) * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgWrapper(
                    assetPath: ImagePaths.home_edit,
                    width: ScallingConfig.scale(15),
                    height: ScallingConfig.scale(15),
                  ),
                  SizedBox(width: ScallingConfig.scale(8)),
                  const CustomText(
                    text: "Home Sample Available",
                    fontFamily: "Gilroy-SemiBold",
                    fontSize: 14,
                    color: AppColors.tertiaryColor,
                  ),
                ],
              ),
            ),
            SizedBox(height: ScallingConfig.scale(15)),
            SizedBox(
              width: Utils.windowWidth(context) * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgWrapper(
                    assetPath: ImagePaths.marker2,
                    width: ScallingConfig.scale(15),
                    height: ScallingConfig.scale(15),
                  ),
                  SizedBox(width: ScallingConfig.scale(8)),
                  const CustomText(
                    text: "4915 Muller Radial, 84904, USA",
                    fontFamily: "Gilroy-SemiBold",
                    fontSize: 14,
                    color: AppColors.tertiaryColor,
                  ),
                ],
              ),
            ),
            SizedBox(height: ScallingConfig.scale(15)),
            SizedBox(
              width: Utils.windowWidth(context) * 0.9,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgWrapper(
                    assetPath: ImagePaths.clock,
                    width: ScallingConfig.scale(15),
                    height: ScallingConfig.scale(15),
                  ),
                  SizedBox(width: ScallingConfig.scale(8)),
                  const CustomText(
                    text: "Open at 9:00am",
                    fontFamily: "Gilroy-SemiBold",
                    fontSize: 14,
                    color: AppColors.tertiaryColor,
                  ),
                ],
              ),
            ),
            SizedBox(height: ScallingConfig.scale(15)),
            CustomText(
              width: Utils.windowWidth(context) * 0.9,
              text: "Test Available",
              fontFamily: "Gilroy-Bold",
              fontSize: 14,
              color: AppColors.themeDarkGrey,
            ),
            CustomCheckBox(text: "1. Complete Blood Count (CBC", width: Utils.windowWidth(context) * 0.9),
            CustomCheckBox(text: "2. Blood Sugar (Fasting / Random)", width: Utils.windowWidth(context) * 0.9),
            CustomCheckBox(text: "3. Liver Function Test (LFT)", width: Utils.windowWidth(context) * 0.9),
            SizedBox(height: ScallingConfig.scale(12)),
            CustomButton(
              width: Utils.windowWidth(context) * 0.9,
              borderRadius: 70,
              label: "Schedule Now",
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const FillLabForm()));
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildWebLayout(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAFC),
      child: Column(
        children: [
          // Web Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                ),
                const SizedBox(width: 10),
                const CustomText(
                  text: "Laboratory Profile",
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  fontFamily: "Gilroy-Bold",
                ),
                const Spacer(),
                _buildBreadcrumbs(),
              ],
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(40),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left Column: Hero & Info
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Gallery/Hero Section
                            Container(
                              height: 450,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                image: DecorationImage(
                                  image: AssetImage(ImagePaths.lab3),
                                  fit: BoxFit.cover,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 30,
                                    offset: const Offset(0, 15),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 20,
                                    right: 20,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Row(
                                        children: [
                                          Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                                          SizedBox(width: 4),
                                          CustomText(text: "4.9", fontWeight: FontWeight.bold),
                                          SizedBox(width: 4),
                                          CustomText(text: "(120+ Reviews)", color: Colors.grey, fontSize: 12),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 32),
                            
                            // Lab Info Task
                            const CustomText(
                              text: "Quantum Spar Lab",
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              fontFamily: "Gilroy-Bold",
                            ),
                            const SizedBox(height: 16),
                            const CustomText(
                              text: "Our laboratory combines advanced diagnostic technology with the expertise of highly qualified professionals, ensuring every test is conducted with precision, accuracy, and reliability to support better healthcare outcomes. We are committed to providing world-class diagnostic services using the latest medical equipment.",
                              fontSize: 16,
                              color: Color(0xFF64748B),
                              maxLines: 5,
                            ),
                            const SizedBox(height: 32),
                            
                            // Info Grid
                            Row(
                              children: [
                                _buildInfoCard(Icons.location_on_rounded, "Address", "4915 Muller Radial, USA", Colors.blue),
                                const SizedBox(width: 20),
                                _buildInfoCard(Icons.access_time_filled_rounded, "Working Hours", "09:00 AM - 08:00 PM", Colors.orange),
                                const SizedBox(width: 20),
                                _buildInfoCard(Icons.home_work_rounded, "Service", "Home Sample Available", Colors.green),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(width: 40),
                      
                      // Right Column: Booking Card
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(32),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 40,
                                offset: const Offset(0, 10),
                              ),
                            ],
                            border: Border.all(color: const Color(0xFFF1F5F9)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomText(
                                text: "Select Tests",
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                              const SizedBox(height: 8),
                              const CustomText(
                                text: "Select the tests you want to schedule",
                                fontSize: 13,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 24),
                              _buildWebCheckbox("Complete Blood Count (CBC)"),
                              _buildWebCheckbox("Blood Sugar (Fasting / Random)"),
                              _buildWebCheckbox("Liver Function Test (LFT)"),
                              _buildWebCheckbox("Kidney Profile (KFT)"),
                              _buildWebCheckbox("Lipid Profile"),
                              const SizedBox(height: 32),
                              
                              const Divider(height: 1, color: Color(0xFFF1F5F9)),
                              const SizedBox(height: 32),
                              
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(text: "Estimated Total", color: Color(0xFF64748B)),
                                  CustomText(
                                    text: "\$45.00",
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.primaryColor,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              
                              CustomButton(
                                height: 56,
                                borderRadius: 16,
                                label: "Schedule Appointment",
                                gradient: const LinearGradient(
                                  colors: [AppColors.primaryColor, Color(0xFF1E40AF)],
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const FillLabForm()));
                                },
                              ),
                              const SizedBox(height: 16),
                              const Center(
                                child: CustomText(
                                  text: "Secure 256-bit SSL encrypted booking",
                                  fontSize: 11,
                                  color: Colors.grey,
                                ),
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
          ),
        ],
      ),
    );
  }

  Widget _buildBreadcrumbs() {
    return Row(
      children: [
        Text("Home", style: TextStyle(color: Colors.grey[400], fontSize: 13)),
        const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
        Text("Laboratories", style: TextStyle(color: Colors.grey[400], fontSize: 13)),
        const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
        const Text("Details", style: TextStyle(color: AppColors.primaryColor, fontSize: 13, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFF1F5F9)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 16),
            CustomText(text: title, fontSize: 12, color: Colors.grey),
            const SizedBox(height: 4),
            CustomText(text: value, fontSize: 13, fontWeight: FontWeight.bold, maxLines: 1),
          ],
        ),
      ),
    );
  }

  Widget _buildWebCheckbox(String label) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFFCBD5E1), width: 2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: CustomText(text: label, fontSize: 14)),
          const CustomText(text: "\$15.00", fontSize: 13, color: Colors.grey),
        ],
      ),
    );
  }
}



