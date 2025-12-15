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
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        automaticallyImplyLeading: false,
        title: CustomText(text: "Fill this form"),
      ),
      body: SingleChildScrollView(
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
                  ScheduledTest(),
                  CustomText(
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
                  ScheduledTest(),
                  CustomText(
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
          SizedBox(height: ScallingConfig.scale(15),),
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
          SizedBox(height: ScallingConfig.scale(15),),
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
          SizedBox(height: ScallingConfig.scale(15),),
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

            CustomCheckBox(text: "Home Sample Available", width: Utils.windowWidth(context) * 0.9,),
                     SizedBox(height: ScallingConfig.scale(20),),
            CustomButton(label:"Book Now",
            width: Utils.windowWidth(context) * 0.9,
            borderRadius: 35,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => REceiptScreen())
              );
            },
            )
          ],
        ),
      ),
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
