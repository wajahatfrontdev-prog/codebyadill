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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: CustomBackButton(),
        title: CustomText(text: "Lab Details"),
      ),
      body: SingleChildScrollView(
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
              SizedBox(height: ScallingConfig.scale(15),),
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
                    CustomText(
                      text: "Home Sample Available",
                      fontFamily: "Gilroy-SemiBold",
                      fontSize: 14,
                      color: AppColors.tertiaryColor,
                    ),
                  ],
                ),
              ),
              SizedBox(height: ScallingConfig.scale(15),),
              SizedBox(
                width: Utils.windowWidth(context) * 0.9,
            child:  Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgWrapper(
                    assetPath: ImagePaths.marker2,
                    width: ScallingConfig.scale(15),
                    height: ScallingConfig.scale(15),
                  ),
                  SizedBox(width: ScallingConfig.scale(8)),
                  CustomText(
                    text: "4915 Muller Radial, 84904, USA",
                      fontFamily: "Gilroy-SemiBold",
                      fontSize: 14,
                      color: AppColors.tertiaryColor,
                  ),
                ],
              )),
              SizedBox(height: ScallingConfig.scale(15),),
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
                    CustomText(
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
             CustomCheckBox(text: "1. Complete Blood Count (CBC",width: Utils.windowWidth(context) * 0.9, ),
             CustomCheckBox(text: "2. Blood Sugar (Fasting / Random)",width: Utils.windowWidth(context) * 0.9, ),
             CustomCheckBox(text: "3. Liver Function Test (LFT)",width: Utils.windowWidth(context) * 0.9, ),
            SizedBox(height: ScallingConfig.scale(12)),
          
             CustomButton(
              width: Utils.windowWidth(context) * 0.9,
              borderRadius: 70,
              label:"Schedule Now",
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) =>FillLabForm() ));
              },
             )
            ]
          
          ),
        ),
      ),
    );
  }
}


