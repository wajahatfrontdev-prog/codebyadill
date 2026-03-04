import 'package:flutter/material.dart';
import 'package:flutter_size_matters/flutter_size_matters.dart';
import 'package:icare/screens/receipt.dart';
import 'package:icare/utils/theme.dart';
import 'package:icare/utils/utils.dart';
import 'package:icare/widgets/back_button.dart';
import 'package:icare/widgets/custom_button.dart';
import 'package:icare/widgets/custom_check_box.dart';
import 'package:icare/widgets/custom_text.dart';
import 'package:icare/widgets/custom_text_input.dart';

class FillLabForm extends StatelessWidget {
  const FillLabForm({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = ResponsiveHelper.isDesktop(context);

    return Scaffold(
      appBar: isDesktop
          ? null
          : AppBar(
              leading: const CustomBackButton(),
              automaticallyImplyLeading: false,
              title: const CustomText(text: "Fill this form"),
            ),
      body: isDesktop ? _buildWebLayout(context) : _buildMobileLayout(context),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomText(
            text: "Test Names",
            width: Utils.windowWidth(context) * 0.9,
            color: AppColors.themeDarkGrey,
            fontSize: 14,
            fontFamily: "Gilroy-Bold",
          ),
          SizedBox(height: ScallingConfig.scale(10)),
          SizedBox(
            width: Utils.windowWidth(context) * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const ScheduledTest(),
                const CustomText(
                  text: "Rs. 3000",
                  fontSize: 12,
                  fontFamily: "vGilroy-SemiBold",
                  color: AppColors.primary500,
                ),
              ],
            ),
          ),
          SizedBox(height: ScallingConfig.scale(10)),
          SizedBox(
            width: Utils.windowWidth(context) * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const ScheduledTest(),
                const CustomText(
                  text: "Rs. 3000",
                  fontSize: 12,
                  fontFamily: "vGilroy-SemiBold",
                  color: AppColors.primary500,
                ),
              ],
            ),
          ),
          SizedBox(height: ScallingConfig.scale(15)),
          CustomText(
            text: "Add Details",
            width: Utils.windowWidth(context) * 0.9,
            color: AppColors.themeDarkGrey,
            fontSize: 14,
            fontFamily: "Gilroy-Bold",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomInputField(
                hintText: "Name",
                borderRadius: 0,
                hintStyle: TextStyle(
                  color: AppColors.grayColor.withAlpha(70),
                  fontFamily: "Gilroy-Medium",
                  fontSize: 14.78,
                ),
                width: Utils.windowWidth(context) * 0.4,
                borderType: const Border(
                  bottom: BorderSide(
                    color: AppColors.lightGrey10,
                    width: 1.5,
                  ),
                ),
              ),
              SizedBox(width: ScallingConfig.scale(20)),
              CustomInputField(
                hintText: "Patient Name",
                borderRadius: 0,
                hintStyle: TextStyle(
                  color: AppColors.grayColor.withAlpha(70),
                  fontFamily: "Gilroy-Medium",
                  fontSize: 14.78,
                ),
                width: Utils.windowWidth(context) * 0.4,
                borderType: const Border(
                  bottom: BorderSide(
                    color: AppColors.lightGrey10,
                    width: 1.5,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: ScallingConfig.scale(15)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomInputField(
                hintText: "Location",
                borderRadius: 0,
                hintStyle: TextStyle(
                  color: AppColors.grayColor.withAlpha(70),
                  fontFamily: "Gilroy-Medium",
                  fontSize: 14.78,
                ),
                width: Utils.windowWidth(context) * 0.4,
                borderType: const Border(
                  bottom: BorderSide(
                    color: AppColors.lightGrey10,
                    width: 1.5,
                  ),
                ),
              ),
              SizedBox(width: ScallingConfig.scale(20)),
              CustomInputField(
                hintText: "Age",
                borderRadius: 0,
                hintStyle: TextStyle(
                  color: AppColors.grayColor.withAlpha(70),
                  fontFamily: "Gilroy-Medium",
                  fontSize: 14.78,
                ),
                width: Utils.windowWidth(context) * 0.4,
                borderType: const Border(
                  bottom: BorderSide(
                    color: AppColors.lightGrey10,
                    width: 1.5,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: ScallingConfig.scale(15)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomInputField(
                hintText: "Date",
                borderRadius: 0,
                hintStyle: TextStyle(
                  color: AppColors.grayColor.withAlpha(70),
                  fontFamily: "Gilroy-Medium",
                  fontSize: 14.78,
                ),
                width: Utils.windowWidth(context) * 0.4,
                borderType: const Border(
                  bottom: BorderSide(
                    color: AppColors.lightGrey10,
                    width: 1.5,
                  ),
                ),
              ),
              SizedBox(width: ScallingConfig.scale(20)),
              CustomInputField(
                hintText: "Time",
                borderRadius: 0,
                hintStyle: TextStyle(
                  color: AppColors.grayColor.withAlpha(70),
                  fontFamily: "Gilroy-Medium",
                  fontSize: 14.78,
                ),
                width: Utils.windowWidth(context) * 0.4,
                borderType: const Border(
                  bottom: BorderSide(
                    color: AppColors.lightGrey10,
                    width: 1.5,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: ScallingConfig.scale(15)),
          CustomInputField(
            hintText: "Phone Number",
            borderRadius: 0,
            hintStyle: TextStyle(
              color: AppColors.grayColor.withAlpha(70),
              fontFamily: "Gilroy-Medium",
              fontSize: 14.78,
            ),
            width: Utils.windowWidth(context) * 0.9,
            borderType: const Border(
              bottom: BorderSide(
                color: AppColors.lightGrey10,
                width: 1.5,
              ),
            ),
          ),
          CustomCheckBox(
            text: "Home Sample Available",
            width: Utils.windowWidth(context) * 0.9,
          ),
          SizedBox(height: ScallingConfig.scale(20)),
          CustomButton(
            label: "Book Now",
            width: Utils.windowWidth(context) * 0.9,
            borderRadius: 35,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const REceiptScreen()));
            },
          )
        ],
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
                  text: "Schedule Laboratory Appointment",
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  fontFamily: "Gilroy-Bold",
                ),
                const Spacer(),
                const Row(
                  children: [
                    Icon(Icons.security_rounded, color: Colors.green, size: 18),
                    SizedBox(width: 8),
                    const CustomText(text: "Secure Checkout", fontSize: 13, color: Colors.grey),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(60),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 900),
                  padding: const EdgeInsets.all(48),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 50,
                        offset: const Offset(0, 20),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: "Test Names",
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Expanded(child: ScheduledTest()),
                          const SizedBox(width: 20),
                          CustomText(
                            text: "Rs. 3000",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Expanded(child: ScheduledTest()),
                          const SizedBox(width: 20),
                          CustomText(
                            text: "Rs. 3000",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ],
                      ),
                      const SizedBox(height: 48),
                      const Divider(height: 1, color: Color(0xFFF1F5F9)),
                      const SizedBox(height: 48),
                      
                      const CustomText(
                        text: "Add Details",
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                      const SizedBox(height: 8),
                      const CustomText(
                        text: "Please provide the information for the person who will be tested.",
                        fontSize: 15,
                        color: Color(0xFF64748B),
                      ),
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          Expanded(child: _buildWebInputField("Name", "Enter your name", Icons.person_outline_rounded)),
                          const SizedBox(width: 24),
                          Expanded(child: _buildWebInputField("Patient Name", "Enter patient name", Icons.people_outline_rounded)),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(child: _buildWebInputField("Location", "Enter sample location", Icons.location_on_outlined)),
                          const SizedBox(width: 24),
                          Expanded(child: _buildWebInputField("Age", "Enter patient age", Icons.calendar_today_rounded)),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(child: _buildWebInputField("Date", "Select Date", Icons.calendar_month_rounded)),
                          const SizedBox(width: 24),
                          Expanded(child: _buildWebInputField("Time", "Select Time", Icons.access_time_rounded)),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _buildWebInputField("Phone Number", "Enter phone number", Icons.phone_outlined),
                      const SizedBox(height: 40),
                      const CustomCheckBox(text: "Home Sample Available", width: double.infinity),
                      const SizedBox(height: 60),
                      
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          height: 60,
                          borderRadius: 16,
                          label: "Book Now",
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const REceiptScreen()));
                          },
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

  Widget _buildWebInputField(String label, String hint, IconData icon) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label,
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: const Color(0xFF334155),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: TextField(
            decoration: InputDecoration(
              icon: Icon(icon, size: 20, color: const Color(0xFF94A3B8)),
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}


class ScheduledTest extends StatelessWidget {
  const ScheduledTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScallingConfig.scale(8),
        vertical: ScallingConfig.verticalScale(4),
      ),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: CustomText(
        text: "Complete Blood Count (CBC)",
        color: AppColors.white,
        fontFamily: "Gilroy-SemiBold",
        fontSize: 12,
      ),
    );
  }
}
