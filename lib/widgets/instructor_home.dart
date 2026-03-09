import 'package:flutter/material.dart';
import 'package:flutter_size_matters/flutter_size_matters.dart';
import 'package:icare/screens/courses.dart';
import 'package:icare/screens/instructor_filters.dart';
import 'package:icare/screens/laboratories.dart';
import 'package:icare/screens/labb_details.dart';
import 'package:icare/screens/view_course.dart';
import 'package:icare/utils/imagePaths.dart';
import 'package:icare/utils/theme.dart';
import 'package:icare/utils/utils.dart';
import 'package:icare/widgets/courses_list.dart';
import 'package:icare/widgets/custom_text_input.dart';
import 'package:icare/widgets/laboratory.dart';
import 'package:icare/widgets/section_header.dart';
import 'package:icare/widgets/svg_wrapper.dart';

class InstructorHome extends StatelessWidget {
  const InstructorHome({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Utils.windowWidth(context) > 900;

    // ── MOBILE: original layout (untouched) ────────────────────────────────
    if (!isDesktop) {
      return Center(
        child: Column(
          children: [
            SizedBox(height: ScallingConfig.scale(20)),
            CustomInputField(
              width: Utils.windowWidth(context) * 0.9,
              hintText: "Search",
              trailingIcon: SvgWrapper(
                assetPath: ImagePaths.filters,
                onPress: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (ctx) => InstructorFiltersScreen()));
                },
              ),
              leadingIcon: SvgWrapper(assetPath: ImagePaths.search),
            ),
            SizedBox(height: ScallingConfig.scale(20)),
            SectionHeader(
              title: "My Courses",
              width: Utils.windowWidth(context) * 0.9,
              onActionTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => Courses()));
              },
            ),
            CoursesList(
              numOfCourses: 2,
              constraintHeight: Utils.windowHeight(context) * 0.3,
            ),
            SizedBox(height: ScallingConfig.scale(20)),
            SectionHeader(
              title: "Laboratories",
              width: Utils.windowWidth(context) * 0.9,
              onActionTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => LaboratoriesScreen()));
              },
            ),
            SizedBox(height: ScallingConfig.scale(20)),
            Laboratory(),
          ],
        ),
      );
    }

    // ── WEB: premium dashboard layout ──────────────────────────────────────
    return _InstructorWebDashboard();
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// WEB DASHBOARD
// ═══════════════════════════════════════════════════════════════════════════
class _InstructorWebDashboard extends StatelessWidget {
  const _InstructorWebDashboard();

  static const _courses = [
    {"name": "Behavioral Therapist", "instructor": "Kewshun", "students": 128, "rating": 4.8, "image": ImagePaths.course1},
    {"name": "Child Therapist", "instructor": "Kewshun", "students": 94, "rating": 4.6, "image": ImagePaths.course2},
    {"name": "Behavioral Therapist", "instructor": "James", "students": 210, "rating": 4.9, "image": ImagePaths.course1},
    {"name": "Cognitive Behavioural", "instructor": "Emma", "students": 76, "rating": 4.5, "image": ImagePaths.course2},
  ];

  static const _stats = [
    {"label": "Total Courses", "value": "12", "icon": Icons.menu_book_rounded, "color": Color(0xFF6366F1)},
    {"label": "Active Students", "value": "508", "icon": Icons.group_rounded, "color": Color(0xFF10B981)},
    {"label": "Avg. Rating", "value": "4.7★", "icon": Icons.star_rounded, "color": Color(0xFFF59E0B)},
    {"label": "Revenue", "value": "Rs. 84K", "icon": Icons.account_balance_wallet_rounded, "color": Color(0xFF3B82F6)},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──────────────────────────────────────────────────────
          _buildHeader(context),
          const SizedBox(height: 36),

          // ── Stats Row ───────────────────────────────────────────────────
          _buildStatsRow(),
          const SizedBox(height: 40),

          // ── Courses Section ─────────────────────────────────────────────
          _buildSectionTitle(context, "My Courses", () {
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => Courses()));
          }),
          const SizedBox(height: 20),
          _buildCoursesGrid(context),
          const SizedBox(height: 40),

          // ── Laboratories Section ─────────────────────────────────────────
          _buildSectionTitle(context, "Nearby Laboratories", () {
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => LaboratoriesScreen()));
          }),
          const SizedBox(height: 20),
          _buildLaboratoriesRow(context),
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  // ── Header with search ──────────────────────────────────────────────────
  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Instructor Dashboard",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Manage your courses, students and laboratories",
                style: TextStyle(fontSize: 15, color: Colors.grey[500], fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        const SizedBox(width: 24),
        // Search bar
        Container(
          width: 320,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0, 4))],
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: "Search courses, labs...",
              prefixIcon: Icon(Icons.search_rounded, size: 20, color: Color(0xFF94A3B8)),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 15),
              hintStyle: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
            ),
          ),
        ),
        const SizedBox(width: 16),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add_rounded, size: 18),
          label: const Text("New Course", style: TextStyle(fontWeight: FontWeight.w700)),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            elevation: 8,
            shadowColor: AppColors.primaryColor.withOpacity(0.35),
          ),
        ),
      ],
    );
  }

  // ── Stats row ────────────────────────────────────────────────────────────
  Widget _buildStatsRow() {
    return Row(
      children: _stats.map((stat) {
        return Expanded(
          child: Container(
            margin: _stats.indexOf(stat) < _stats.length - 1 ? const EdgeInsets.only(right: 20) : EdgeInsets.zero,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: (stat['color'] as Color).withOpacity(0.07), blurRadius: 20, offset: const Offset(0, 8)),
                BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2)),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: (stat['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(stat['icon'] as IconData, color: stat['color'] as Color, size: 24),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stat['value'] as String,
                      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), letterSpacing: -0.5),
                    ),
                    Text(
                      stat['label'] as String,
                      style: const TextStyle(fontSize: 12, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // ── Section title ────────────────────────────────────────────────────────
  Widget _buildSectionTitle(BuildContext context, String title, VoidCallback onViewAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), letterSpacing: -0.3),
        ),
        GestureDetector(
          onTap: onViewAll,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.07),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              "View All",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Courses grid ─────────────────────────────────────────────────────────
  Widget _buildCoursesGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 380,
        mainAxisExtent: 300,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
      ),
      itemCount: _courses.length,
      itemBuilder: (ctx, i) {
        final course = _courses[i];
        return GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ViewCourse())),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 8))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Course image
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: Image.asset(
                    course['image'] as String,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course['name'] as String,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.person_outline_rounded, size: 14, color: Colors.grey[400]),
                          const SizedBox(width: 4),
                          Text(
                            course['instructor'] as String,
                            style: TextStyle(fontSize: 12, color: Colors.grey[500], fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Icon(Icons.star_rounded, size: 14, color: const Color(0xFFF59E0B)),
                          const SizedBox(width: 2),
                          Text(
                            "${course['rating']}",
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF0F172A)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.group_rounded, size: 14, color: Colors.grey[400]),
                          const SizedBox(width: 4),
                          Text(
                            "${course['students']} students",
                            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ── Laboratories row ─────────────────────────────────────────────────────
  Widget _buildLaboratoriesRow(BuildContext context) {
    final labs = [
      {"name": "Quantum Spar Lab", "location": "4915 Muller Radial, 84904, USA", "open": "Open at 9:00am", "image": ImagePaths.lab3},
      {"name": "MedTech Laboratory", "location": "221B Baker Street, London, UK", "open": "Open at 8:30am", "image": ImagePaths.lab3},
      {"name": "BioSci Research Lab", "location": "500 Innovation Drive, NY, USA", "open": "Open at 10:00am", "image": ImagePaths.lab3},
    ];

    return Row(
      children: labs.asMap().entries.map((entry) {
        final i = entry.key;
        final lab = entry.value;
        return Expanded(
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => LabDetails())),
            child: Container(
              margin: i < labs.length - 1 ? const EdgeInsets.only(right: 24) : EdgeInsets.zero,
              height: 260,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(image: AssetImage(lab['image']!), fit: BoxFit.cover),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.12), blurRadius: 20, offset: const Offset(0, 8))],
              ),
              child: Stack(
                children: [
                  // Dark gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black.withOpacity(0.72)],
                      ),
                    ),
                  ),
                  // Content
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lab['name']!,
                          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.location_on_rounded, color: Colors.white70, size: 13),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                lab['location']!,
                                style: const TextStyle(color: Colors.white70, fontSize: 11),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.access_time_rounded, color: Colors.white70, size: 13),
                            const SizedBox(width: 4),
                            Text(lab['open']!, style: const TextStyle(color: Colors.white70, fontSize: 11)),
                          ],
                        ),
                        const SizedBox(height: 14),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => LabDetails())),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.primaryColor,
                            elevation: 0,
                            minimumSize: const Size(0, 36),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text("Visit Lab", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}