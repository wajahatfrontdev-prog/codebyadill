import 'package:flutter/material.dart';
import 'package:flutter_size_matters/flutter_size_matters.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:icare/screens/select_test.dart';
import 'package:icare/utils/imagePaths.dart';
import 'package:icare/utils/theme.dart';
import 'package:icare/utils/utils.dart';
import 'package:icare/widgets/back_button.dart';
import 'package:icare/widgets/custom_button.dart';
import 'package:icare/widgets/custom_text.dart';
import 'package:icare/widgets/custom_text_input.dart';
import 'package:icare/widgets/svg_wrapper.dart';
import 'package:intl/intl.dart';

class BookLabScreen extends StatefulWidget {
  const BookLabScreen({super.key});

  @override
  State<BookLabScreen> createState() => _BookLabScreenState();
}

class _BookLabScreenState extends State<BookLabScreen> {
  var _selectedDate = '';
  var _selectedTime = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        automaticallyImplyLeading: false,
        title: CustomText(
          text: "Book A Lab",
          fontFamily: "Gilroy-Bold",
          fontSize: 18,
          color: AppColors.darkGray500,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: ScallingConfig.verticalScale(15)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  boxShadow: BoxShadow(offset: Offset(0, 0)),
                  borderRadius: 35,
                  labelWidth: Utils.windowWidth(context) * 0.35,

                  // outlined: true,
                  borderColor: AppColors.veryLightGrey,
                  height: Utils.windowHeight(context) * 0.045,
                  width: Utils.windowWidth(context) * 0.4,
                  bgColor: AppColors.veryLightGrey,

                  label: _selectedDate.isNotEmpty
                      ? _selectedDate
                      : "Select Date",
                  labelColor: AppColors.primaryColor,
                  labelSize: 11,
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                    );
                    if (date != null) {
                      setState(() {
                        _selectedDate = DateFormat("yyyy/MM/dd").format(date);
                      });
                    }
                  },
                  trailingIcon: Align(
                    // alignment: AlignmentGeometry.xy(5, 0),
                    child: SvgWrapper(assetPath: ImagePaths.calendar),
                  ),
                ),
                SizedBox(width: ScallingConfig.scale(10)),
               CustomButton(
                  boxShadow: BoxShadow(offset: Offset(0, 0)),
                  borderRadius: 35,
                  labelWidth: Utils.windowWidth(context) * 0.35,

                  // outlined: true,
                  borderColor: AppColors.veryLightGrey,
                  height: Utils.windowHeight(context) * 0.045,
                  width: Utils.windowWidth(context) * 0.4,
                  bgColor: AppColors.veryLightGrey,

                  label: _selectedDate.isNotEmpty
                      ? _selectedDate
                      : "Select Date",
                  labelColor: AppColors.primaryColor,
                  labelSize: 11,
                  onPressed: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      setState(() {
                        _selectedTime = time.format(context);
                      });
                    }
                  },
                  trailingIcon: Align(
                    // alignment: AlignmentGeometry.xy(5, 0),
                    child: SvgWrapper(assetPath: ImagePaths.clock),
                  ),
                ),

              ],
            ),

            CustomInputField(
              width: Utils.windowWidth(context) * 0.9,
              hintText: "City",
              hintStyle: TextStyle(
                color: AppColors.grayColor.withAlpha(60),
                fontFamily: "Gilroy-SemiBold",
                fontSize: 12,
              ),
              margin: EdgeInsets.only(top:ScallingConfig.verticalScale(15)),
              borderRadius: 28,
              borderColor: AppColors.grayColor.withAlpha(70),
            ),

            CustomInputField(
              width: Utils.windowWidth(context) * 0.9,
              hintText: "Address",
              hintStyle: TextStyle(
                color: AppColors.grayColor.withAlpha(60),
                fontFamily: "Gilroy-SemiBold",
                fontSize: 12,
              ),
              margin: EdgeInsets.only(top:ScallingConfig.verticalScale(15)),
              // padding: EdgeInsets.only(left: ScallingConfig.scale(25), top: ScallingConfig.scale(10)),
              // height: Utils.windowHeight(context) * 0.15,
              // maxLines: 50,
              borderRadius: 30,
              borderColor: AppColors.grayColor.withAlpha(70),
            ),
            CustomText(
              text:"Home Sample",
              padding: EdgeInsets.only(top: ScallingConfig.verticalScale(15)),
              fontFamily: "Gilroy-SemiBold",
              fontSize: ScallingConfig.moderateScale(14.76),
              color: AppColors.primary500,
              width: Utils.windowWidth(context) * 0.9,
              ),

              Container(
                width: Utils.windowWidth(context) * 0.9,
                height: ScallingConfig.scale(50),
               padding: EdgeInsets.symmetric(horizontal: ScallingConfig.scale(12), vertical: ScallingConfig.verticalScale(10) ),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: AppColors.grayColor.withAlpha(70)
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: "Off",
                    color: AppColors.lightGrey500,
                    ),
                    FlutterSwitch(
                                width: 50.0,
                                height: 20.0,

                                toggleSize: 15.0,
                                value: true,
                                borderRadius: 30.0,
                                padding: 2.0,
                                toggleColor: Color.fromRGBO(225, 225, 225, 1),
                                activeColor: AppColors.themeBlack,
                                inactiveColor: AppColors.darkGreyColor,
                                onToggle: (val) {
                                },
                              ),

                  ],
                ),
              ),
              SizedBox(height: ScallingConfig.scale(15),  ),
              CustomButton(label: "Select Test", 
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => SelectTest()));
              },
              borderRadius: 30, width: Utils.windowWidth(context) * 0.9,)

          ],
        ),
      ),
    );
  }
}
