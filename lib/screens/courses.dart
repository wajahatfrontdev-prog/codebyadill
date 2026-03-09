import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:icare/providers/auth_provider.dart';
import 'package:icare/screens/filters.dart';
import 'package:icare/utils/imagePaths.dart';
import 'package:icare/utils/theme.dart';
import 'package:icare/utils/utils.dart';
import 'package:icare/widgets/back_button.dart';
import 'package:icare/widgets/certificates_list.dart';
import 'package:icare/widgets/course_card.dart';
import 'package:icare/widgets/courses_list.dart';
import 'package:icare/widgets/custom_text.dart';
import 'package:icare/widgets/custom_text_input.dart';
import 'package:icare/widgets/svg_wrapper.dart';

class Courses extends ConsumerStatefulWidget {
  const Courses({super.key});

  @override
  ConsumerState<Courses> createState() => _CoursesState();
}

class _CoursesState extends ConsumerState<Courses> with SingleTickerProviderStateMixin {
  
   late TabController controller;
int? _currentTabLength;

// @override
// void didChangeDependencies() {
//   super.didChangeDependencies();

//   final role = ref.read(authProvider).userRole;
//   final newLength = role == "instructor" ? 1 : 3;

//   if (_currentTabLength != newLength) {
//     controller?.dispose();
//     controller = TabController(length: newLength, vsync: this);
//     _currentTabLength = newLength;
//   }
// }
  @override
  void initState() {
    super.initState();
   final role = ref.read(authProvider).userRole;
    controller = TabController(length: role == "instructor" ? 1 : 3, vsync: this);
  }

  
  
  @override
  Widget build(BuildContext context) {
   final role = ref.read(authProvider).userRole;
    log(role);
    log(controller.length.toString()); 
    if (MediaQuery.of(context).size.width > 800) {
      return _WebCoursesScreen(controller: controller, role: role);
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: CustomBackButton(),
        title: CustomText(text: "Courses",
        fontFamily: "Gilroy-Bold",
            fontSize: 16.78,
            color: AppColors.primary500,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.31,
            lineHeight: 1.0,
        ),

      ),
      body: Center(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
                       CustomInputField(
              width: Utils.windowWidth(context) * 0.9,
              
             hintText: "Search", 
             trailingIcon: SvgWrapper(assetPath: ImagePaths.filters,onPress: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> FiltersScreen()));
             },),
             leadingIcon: SvgWrapper(assetPath: ImagePaths.search),
             ),

          SizedBox(
            width: Utils.windowWidth(context),

            // height: Utils.windowHeight(context) * 0.06,
            child: TabBar(
            controller: controller,
            indicatorWeight: 6,
            indicatorColor: AppColors.themeBlack,
            tabs: [
              CustomText(
                text: "All Courses",
                
                padding: EdgeInsets.only(bottom:5),
                width: Utils.windowWidth(context) * 0.33,
                textAlign: TextAlign.center,
              ),
           if(role == "instructor") ...[
             SizedBox(width: Utils.windowWidth(context) * 0.33,),
             SizedBox(width: Utils.windowWidth(context) * 0.33,),],
            if(role != "instructor") ...[CustomText(
                text: "My Purchase",
                padding: EdgeInsets.only(bottom:5),
                width: Utils.windowWidth(context) * 0.33,
                textAlign: TextAlign.center,
              ),
              CustomText(
                padding: EdgeInsets.only(bottom:5),
                width: Utils.windowWidth(context) * 0.33,
                textAlign: TextAlign.center,
                text: "Certificates",
              ),]
            ],
                    ),
          ),   
          Expanded(child: TabBarView(
        controller: controller,
        children: [
          CoursesList(),
          if(role != "instructor")...[

         CoursesList(mypurchased: true),
          CertificatesList(),
          ]
          
          
        ],
      ),),

            
          ],
        ),
      )
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// NEW STUNNING WEB VIEW
// ═══════════════════════════════════════════════════════════════════════════

class _WebCoursesScreen extends StatelessWidget {
  final TabController controller;
  final String role;

  const _WebCoursesScreen({required this.controller, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: CustomBackButton(),
        title: CustomText(
          text: "Courses",
          fontFamily: "Gilroy-Bold",
          fontSize: 20,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.31,
          lineHeight: 1.0,
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              // Search & Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Find Your Next Course", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, fontFamily: "Gilroy-Bold", color: Color(0xFF1E293B))),
                        SizedBox(height: 8),
                        Text("Discover amazing topics to enhance your skills and career.", style: TextStyle(fontSize: 15, color: Color(0xFF64748B))),
                      ],
                    ),
                    SizedBox(
                      width: 350,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          boxShadow: const [BoxShadow(color: Color(0x05000000), blurRadius: 10, offset: Offset(0, 4))],
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search courses...",
                            hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
                            prefixIcon: Padding(padding: const EdgeInsets.all(12), child: SvgWrapper(assetPath: ImagePaths.search)),
                            suffixIcon: IconButton(
                              icon: SvgWrapper(assetPath: ImagePaths.filters),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => FiltersScreen()));
                              },
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              
              // Tabs
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  height: 48,
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0), width: 2)),
                  ),
                  child: TabBar(
                    controller: controller,
                    indicatorWeight: 3,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: AppColors.primaryColor,
                    labelColor: AppColors.primaryColor,
                    unselectedLabelColor: const Color(0xFF64748B),
                    labelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, fontFamily: "Gilroy-SemiBold"),
                    unselectedLabelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, fontFamily: "Gilroy-Medium"),
                    tabs: [
                      const Tab(text: "All Courses"),
                      if (role != "instructor") const Tab(text: "My Purchase"),
                      if (role != "instructor") const Tab(text: "Certificates"),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Content
              Expanded(
                child: TabBarView(
                  controller: controller,
                  children: [
                    const _WebCoursesList(),
                    if (role != "instructor") ...[
                      const _WebCoursesList(myPurchased: true),
                      const _WebCertificatesList(),
                    ]
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WebCoursesList extends StatelessWidget {
  final bool myPurchased;
  const _WebCoursesList({this.myPurchased = false});

  @override
  Widget build(BuildContext context) {
    final courses = [
      {"id": 1, "name": "Behavioral Therapist", "instructor": "Dr. Kewshun", "desc": "Master the fundamentals of behavioral therapy in this comprehensive course.", "image": ImagePaths.course1},
      {"id": 2, "name": "Child Psychology", "instructor": "Dr. Smith", "desc": "Understand the developmental stages of children and effective therapy methods.", "image": ImagePaths.course2},
      {"id": 3, "name": "Cognitive Therapy", "instructor": "Dr. James", "desc": "Learn cognitive restructuring techniques for adult patients.", "image": ImagePaths.course1},
      {"id": 4, "name": "Family Counseling", "instructor": "Dr. Kewshun", "desc": "Strategies for resolving complex family dynamics and improving communication.", "image": ImagePaths.course2},
      {"id": 5, "name": "Trauma Therapy", "instructor": "Dr. James", "desc": "Advanced methods in dealing with trauma and PTSD.", "image": ImagePaths.course1},
      {"id": 6, "name": "Addiction Recovery", "instructor": "Dr. Kewshun", "desc": "Guiding patients through the difficult journey of addiction recovery.", "image": ImagePaths.course2},
    ];

    final displayCourses = myPurchased ? [courses[0], courses[1]] : courses;

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      itemCount: displayCourses.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (ctx, i) {
        final course = displayCourses[i];
        return InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            // Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ViewCourse()));
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFF1F4F9), width: 1.5),
              boxShadow: const [BoxShadow(color: Color(0x08000000), offset: Offset(0, 4), blurRadius: 16)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                  child: Image.asset(
                    course["image"] as String,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(8)),
                              child: const Text("Health", style: TextStyle(color: AppColors.primaryColor, fontSize: 12, fontWeight: FontWeight.w700)),
                            ),
                            const Spacer(),
                            const Icon(Icons.star_rounded, color: Color(0xFFF59E0B), size: 18),
                            const SizedBox(width: 4),
                            const Text("4.8", style: TextStyle(color: Color(0xFF475569), fontSize: 13, fontWeight: FontWeight.w600)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          course["name"] as String,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF1E293B), fontFamily: "Gilroy-Bold", height: 1.2),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          course["desc"] as String,
                          style: const TextStyle(fontSize: 14, color: Color(0xFF64748B), height: 1.4),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        const Divider(color: Color(0xFFF1F5F9)),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            SvgWrapper(assetPath: ImagePaths.instructor, color: const Color(0xFF64748B)),
                            const SizedBox(width: 8),
                            Text(
                              course["instructor"] as String,
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF475569), fontFamily: "Gilroy-SemiBold"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _WebCertificatesList extends StatelessWidget {
  const _WebCertificatesList();

  @override
  Widget build(BuildContext context) {
    final certificates = [
      {'title': 'Child Therapist Advanced Training', 'completed': 7, 'total': 7, 'percent': 100},
      {'title': 'Behavioral Therapist Fundamentals', 'completed': 7, 'total': 7, 'percent': 100},
      {'title': 'Cognitive Therapy Mastery', 'completed': 10, 'total': 10, 'percent': 100},
    ];

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      itemCount: certificates.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 500,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 2.5,
      ),
      itemBuilder: (ctx, i) {
        final item = certificates[i];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFF1F4F9), width: 1.5),
            boxShadow: const [BoxShadow(color: Color(0x05000000), offset: Offset(0, 4), blurRadius: 16)],
          ),
          padding: const EdgeInsets.all(24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(color: const Color(0xFFECFDF5), borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: SvgWrapper(assetPath: ImagePaths.success, color: const Color(0xFF10B981)),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item['title'].toString(),
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF1E293B), fontFamily: "Gilroy-Bold"),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(6)),
                      child: Text(
                        '${item["percent"]}% Completed (${item["completed"]}/${item["total"]})',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        TextButton.icon(
                          onPressed: () {}, // Navigator.of(context).push...
                          icon: const Icon(Icons.workspace_premium_rounded, size: 16),
                          label: const Text("View"),
                          style: TextButton.styleFrom(foregroundColor: AppColors.primaryColor, padding: EdgeInsets.zero, minimumSize: const Size(0, 0)),
                        ),
                        const SizedBox(width: 16),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.download_rounded, size: 16),
                          label: const Text("Download"),
                          style: TextButton.styleFrom(foregroundColor: const Color(0xFF64748B), padding: EdgeInsets.zero, minimumSize: const Size(0, 0)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}