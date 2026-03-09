import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_size_matters/flutter_size_matters.dart';
import 'package:icare/screens/add_card.dart';
import 'package:icare/utils/imagePaths.dart';
import 'package:icare/utils/theme.dart';
import 'package:icare/widgets/custom_text.dart';
import 'package:icare/widgets/payment_method_card.dart';
import 'package:icare/widgets/back_button.dart';
import 'package:icare/utils/utils.dart';
import 'package:icare/widgets/svg_wrapper.dart';

class SelectPaymentMethod extends StatefulWidget {
  const SelectPaymentMethod({super.key});

  @override
  State<SelectPaymentMethod> createState() => _SelectPaymentMethodState();
}

class _SelectPaymentMethodState extends State<SelectPaymentMethod> {
  final List<Map<String, String>> paymentMethods = [
    {
      'type': 'VISA',
      'logo': ImagePaths.apple,
      'number': '**** **** **** 1313',
      'expiry': '08/26',
    },
    {
      'type': 'MasterCard',
      'logo': ImagePaths.mc,
      'number': '**** **** **** 1313',
      'expiry': '08/26',
    },
    {
      'type': 'Amex',
      'logo': ImagePaths.gpay,
      'number': '**** **** **** 1313',
      'expiry': '08/26',
    },
    {
      'type': 'VISA',
      'logo': ImagePaths.visa,
      'number': '**** **** **** 1313',
      'expiry': '08/26',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Utils.windowWidth(context) > 900;

    if (isDesktop) {
      return _buildWebLayout(context);
    }

    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        automaticallyImplyLeading: false,
        title: CustomText(
          text: "Select Payment Method",
          fontWeight: FontWeight.bold,
          fontSize: 16.78,
          fontFamily: "Gilroy-Bold",
          letterSpacing: -0.31,
          lineHeight: 1.0,
          color: AppColors.primary500,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScallingConfig.scale(15),
          vertical: ScallingConfig.verticalScale(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Choose Platform ",
              fontFamily: "Gilroy-Bold",
              fontSize: 14,
              color: AppColors.primary500,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: paymentMethods.length,
                itemBuilder: (ctx, i) {
                  final item = paymentMethods[i];
                  return (PaymentMethodCard(
                    onTap: () {
                      Navigator.of(
                        context,
                      ).push(MaterialPageRoute(builder: (ctx) => AddCard()));
                    },
                    expiry: item['expiry'],
                    number: item['number'],
                    type: item['type'],
                    logo: item['logo'],
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWebLayout(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const CustomBackButton(),
        title: CustomText(
          text: "Checkout & Payment",
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: "Gilroy-Bold",
          color: AppColors.primaryColor,
        ),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1100),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Payment Content
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Select Payment Method",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0F172A),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Choose how you'd like to pay for your course.",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // Payment Method List
                    ...paymentMethods.asMap().entries.map((entry) {
                      final i = entry.key;
                      final item = entry.value;
                      return _buildWebPaymentCard(context, item);
                    }).toList(),

                    const SizedBox(height: 24),
                    
                    // Add new payment method
                    InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => const AddCard()),
                      ),
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColor.withOpacity(0.3), style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.primaryColor.withOpacity(0.04),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_circle_outline_rounded, color: AppColors.primaryColor, size: 20),
                            const SizedBox(width: 12),
                            Text(
                              "Add New Payment Method",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 48),

              // Sidebar Summary
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Order Summary",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildSummaryItem("Course Price", "\$99.00"),
                      _buildSummaryItem("Processing Fee", "\$5.00"),
                      const Divider(height: 32, color: Color(0xFFF1F5F9)),
                      _buildSummaryItem("Total", "\$104.00", isTotal: true),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Proceed to confirm
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            elevation: 8,
                            shadowColor: AppColors.primaryColor.withOpacity(0.4),
                          ),
                          child: const Text(
                            "Confirm & Pay",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.lock_outline_rounded, size: 14, color: Color(0xFF94A3B8)),
                            SizedBox(width: 6),
                            Text(
                              "Secure 256-bit SSL encrypted",
                              style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
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
      ),
    );
  }

  Widget _buildWebPaymentCard(BuildContext context, Map<String, String> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: SvgWrapper(
              assetPath: item['logo'] ?? ImagePaths.visa,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['type'] ?? "Card",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['number'] ?? "",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF64748B),
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                "Exp ${item['expiry']}",
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF94A3B8),
                ),
              ),
              const SizedBox(width: 24),
              Radio(
                value: item['type'],
                groupValue: "VISA", // Simulated selection
                onChanged: (val) {},
                activeColor: AppColors.primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.w900 : FontWeight.w500,
              color: isTotal ? const Color(0xFF0F172A) : const Color(0xFF64748B),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 22 : 14,
              fontWeight: isTotal ? FontWeight.w900 : FontWeight.w700,
              color: isTotal ? AppColors.primaryColor : const Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }
}
