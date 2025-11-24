import 'package:flutter/material.dart';
import 'package:icare/utils/theme.dart';
import 'package:icare/utils/utils.dart';
import 'package:icare/widgets/back_button.dart';
import 'package:icare/widgets/custom_text.dart';
import 'package:icare/widgets/custom_text_input.dart';

class AddCard extends StatelessWidget {
  const AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        automaticallyImplyLeading: false,
        title: CustomText(text: "Certificate"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomInputField(
              title: "Card Type",
              hintText: "Card Type",
              hintStyle: TextStyle(
                color: AppColors.grayColor,
                fontFamily: "Gilroy-SemiBold",
                fontSize: 14,
              ),
              borderRadius: 30,
              borderColor: AppColors.grayColor.withAlpha(70),
              width: Utils.windowWidth(context) * 0.9,
            ),
          ],
        ),
      ),
    );
  }
}
