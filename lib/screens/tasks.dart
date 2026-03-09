import 'package:flutter/material.dart';
import 'package:flutter_size_matters/flutter_size_matters.dart';
import 'package:icare/utils/theme.dart';
import 'package:icare/utils/utils.dart';
import 'package:icare/widgets/back_button.dart';
import 'package:icare/widgets/custom_text.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final bool isWeb = MediaQuery.of(context).size.width > 600;

    if (isWeb) {
      return Scaffold(
        backgroundColor: const Color(0xFFF4F6FB), // Soft background color
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          leading: CustomBackButton(),
          automaticallyImplyLeading: false,
          title: CustomText(
            text: "My Tasks",
            fontWeight: FontWeight.bold,
            letterSpacing: -0.31,
            lineHeight: 1.0,
            fontSize: 20,
            fontFamily: "Gilroy-Bold",
            color: AppColors.primaryColor,
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Container(
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFFE5E9F2))),
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: TabBar(
                    controller: controller,
                    indicatorWeight: 4,
                    indicatorPadding: const EdgeInsets.symmetric(horizontal: 24),
                    indicatorColor: AppColors.primaryColor,
                    labelColor: AppColors.primaryColor,
                    unselectedLabelColor: const Color(0xFF8B98B4),
                    labelStyle: const TextStyle(
                      fontFamily: "Gilroy-Bold",
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontFamily: "Gilroy-Medium",
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    tabs: const [
                      Tab(text: "Assigned"),
                      Tab(text: "Completed"),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: TabBarView(
              controller: controller,
              children: const [WebTasksList(isCompleted: false), WebTasksList(isCompleted: true)],
            ),
          ),
        ),
      );
    } // end web layout

    // Original Mobile Layout
    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        automaticallyImplyLeading: false,
        title: CustomText(
          text: "My Tasks",
          fontWeight: FontWeight.bold,
          letterSpacing: -0.31,
          lineHeight: 1.0,
          fontSize: 16.78,
          fontFamily: "Gilroy-Bold",
          color: AppColors.primary500,
        ),
        bottom: TabBar(
          controller: controller,
          indicatorWeight: 6,

          indicatorColor: AppColors.themeBlack,
          tabs: [
            CustomText(
              text: "Assigned",

              padding: EdgeInsets.only(bottom: 5),
              width: Utils.windowWidth(context) * 0.45,
              textAlign: TextAlign.center,
              fontFamily: "Gilroy-Bold",
              fontSize: 13,
            ),
            CustomText(
              text: "Completed",
              fontFamily: "Gilroy-Bold",
              fontSize: 13,
              padding: EdgeInsets.only(bottom: 5),
              width: Utils.windowWidth(context) * 0.45,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [TasksList(), TasksList()],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// ORIGINAL MOBILE COMPONENTS (Unchanged)
// ═══════════════════════════════════════════════════════════════════════════

class TasksList extends StatelessWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: ScallingConfig.scale(14)),
      itemCount: 5,
      itemBuilder: (ctx, i) {
        return (Task());
      },
    );
  }
}

class Task extends StatelessWidget {
  const Task({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: ScallingConfig.verticalScale(10)),
      padding: EdgeInsets.symmetric(
        vertical: ScallingConfig.verticalScale(10),
        horizontal: ScallingConfig.scale(15),
      ),
      width: Utils.windowWidth(context) * 0.9,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.lightGrey100,
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "12/12/2023",
                color: AppColors.tertiaryColor,
                fontSize: 10,
                fontWeight: FontWeight.w400,
                fontFamily: "Gilroy-Regular",
              ),
              Icon(Icons.more_horiz, color: AppColors.tertiaryColor),
            ],
          ),
          SizedBox(height: ScallingConfig.scale(8)),

          CustomText(
            text:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever...",
            color: AppColors.primary500,
            fontSize: 12,
            maxLines: 8,
            fontWeight: FontWeight.w400,
            fontFamily: "Gilroy-Regular",
          ),
        ],
      ),
    );
  }
}


// ═══════════════════════════════════════════════════════════════════════════
// NEW WEB COMPONENTS
// ═══════════════════════════════════════════════════════════════════════════


class WebTasksList extends StatelessWidget {
  final bool isCompleted;
  const WebTasksList({super.key, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: ScallingConfig.scale(20),
        vertical: ScallingConfig.verticalScale(20),
      ),
      itemCount: 5,
      itemBuilder: (ctx, i) {
        return WebTaskItem(
          isCompleted: isCompleted,
          title: "Follow up with Patient",
          description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s...",
          date: "12 Dec, 2023",
          index: i,
        );
      },
    );
  }
}

class WebTaskItem extends StatelessWidget {
  final bool isCompleted;
  final String title;
  final String description;
  final String date;
  final int index;

  const WebTaskItem({
    super.key,
    required this.isCompleted,
    required this.title,
    required this.description,
    required this.date,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = isCompleted ? const Color(0xFF10B981) : const Color(0xFFF59E0B);
    final statusBg = isCompleted ? const Color(0xFFECFDF5) : const Color(0xFFFEF3C7);
    final statusIcon = isCompleted ? Icons.check_circle_rounded : Icons.pending_actions_rounded;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            offset: Offset(0, 4),
            blurRadius: 12,
          ),
        ],
        border: Border.all(color: const Color(0xFFF1F4F9), width: 1.5),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header (Status + Actions) ──
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: statusBg,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(statusIcon, color: statusColor, size: 14),
                          const SizedBox(width: 6),
                          Text(
                            isCompleted ? "Completed" : "In Progress",
                            style: TextStyle(
                              color: statusColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.access_time_filled_rounded, 
                            color: Colors.grey.shade400, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          date,
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(Icons.more_vert_rounded, color: Colors.grey.shade400, size: 20),
                      ],
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // ── Title ──
                Text(
                  "$title #${index + 1}",
                  style: const TextStyle(
                    color: Color(0xFF1E293B),
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Gilroy-Bold",
                  ),
                ),
                
                const SizedBox(height: 8),

                // ── Description ──
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF64748B),
                    fontSize: 14,
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Gilroy-Regular",
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                
                const SizedBox(height: 16),
                
                // ── Footer (Avatar + Priority) ──
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 14,
                          backgroundImage: AssetImage('assets/images/user1.png'), // Fallback 
                          backgroundColor: Color(0xFFE2E8F0),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Assigned by Dr. Aron",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    if (!isCompleted)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: const Color(0xFFDBEAFE)),
                        ),
                        child: const Text(
                          "High Priority",
                          style: TextStyle(
                            color: Color(0xFF2563EB),
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

