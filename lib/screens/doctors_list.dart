import 'package:flutter/material.dart';
import 'package:flutter_size_matters/flutter_size_matters.dart';
import 'package:icare/utils/imagePaths.dart';
import 'package:icare/utils/theme.dart';
import 'package:icare/utils/utils.dart';
import 'package:icare/widgets/back_button.dart';
import 'package:icare/widgets/custom_text.dart';

class DoctorsList extends StatelessWidget {
  const DoctorsList({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Utils.windowWidth(context) > 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        leading: CustomBackButton(),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          text: "Find Doctors",
          fontFamily: "Gilroy-Bold",
          fontSize: 18,
          fontWeight: FontWeight.w900,
          color: const Color(0xFF0F172A),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = 2;
          if (constraints.maxWidth > 1200) {
            crossAxisCount = 4;
          } else if (constraints.maxWidth > 800) {
            crossAxisCount = 3;
          }

          return GridView.builder(
            itemCount: 12,
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 40 : 20,
              vertical: 24,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisExtent: isDesktop ? 340 : 280,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
            ),
            itemBuilder: (ctx, i) {
              return const DoctorProfileCard();
            },
          );
        },
      ),
    );
  }
}

class DoctorProfileCard extends StatelessWidget {
  const DoctorProfileCard({super.key, this.width, this.padding});
  final double? width;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          children: [
            // Background decoration
            Positioned(
              top: -20,
              right: -20,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor.withOpacity(0.03),
                ),
              ),
            ),
            
            // Interaction overlay
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: const SizedBox.expand(),
                ),
              ),
            ),

            Padding(
              padding: padding ?? const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   // Avatar Ring
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 42,
                      backgroundColor: const Color(0xFFF1F5F9),
                      backgroundImage: AssetImage(ImagePaths.walkthrough1),
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Text Info
                  CustomText(
                    text: "Dr. Aaron Smith",
                    color: const Color(0xFF0F172A),
                    fontFamily: "Gilroy-Bold",
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                  const SizedBox(height: 6),
                  CustomText(
                    text: "Therapist Specialist",
                    color: const Color(0xFF64748B),
                    fontFamily: "Gilroy-Medium",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(height: 16),
                  
                  // Rating Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF7ED),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star_rounded, size: 16, color: Color(0xFFF59E0B)),
                        const SizedBox(width: 4),
                        CustomText(
                          text: "4.8",
                          color: const Color(0xFF92400E),
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                        const SizedBox(width: 4),
                        CustomText(
                          text: "(120)",
                          color: const Color(0xFFD97706).withOpacity(0.6),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Favorite Button
            Positioned(
              top: 14,
              right: 14,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.favorite_border_rounded, color: Color(0xFFEF4444), size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
