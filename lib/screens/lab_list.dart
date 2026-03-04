import 'package:flutter/material.dart';
import 'package:flutter_size_matters/flutter_size_matters.dart';
import 'package:icare/models/lab.dart';
import 'package:icare/screens/filters.dart';
import 'package:icare/utils/imagePaths.dart';
import 'package:icare/utils/theme.dart';
import 'package:icare/utils/utils.dart';
import 'package:icare/widgets/back_button.dart';
import 'package:icare/widgets/custom_button.dart';
import 'package:icare/widgets/custom_text.dart';
import 'package:icare/widgets/custom_text_input.dart';
import 'package:icare/widgets/lab_widget.dart';
import 'package:icare/widgets/svg_wrapper.dart';

class LabsListScreen extends StatefulWidget {
  const LabsListScreen({super.key});

  @override
  State<LabsListScreen> createState() => _LabsListScreenState();
}

class _LabsListScreenState extends State<LabsListScreen> 
with SingleTickerProviderStateMixin {

  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

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
          text: "Lab Reports",
          fontFamily: "Gilroy-Bold", 
          fontSize: 18,
          fontWeight: FontWeight.w900,
          color: const Color(0xFF0F172A),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isDesktop ? 1200 : double.infinity),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Search Header
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 40 : 20,
                  vertical: 24,
                ),
                color: Colors.white,
                child: Center(
                  child: CustomInputField(
                    width: isDesktop ? 700 : double.infinity,
                    hintText: "Search lab reports, tests, or clinics...", 
                    trailingIcon: SvgWrapper(
                      assetPath: ImagePaths.filters,
                      onPress: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> const FiltersScreen()));
                      },
                    ),
                    leadingIcon: const Icon(Icons.search_rounded, color: Color(0xFF94A3B8), size: 22),
                  ),
                ),
              ),

              Container(
                margin: const EdgeInsets.only(top: 2),
                height: 54,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9), width: 1.5)),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: isDesktop ? 500 : double.infinity,
                    child: TabBar(
                      controller: controller,
                      indicatorColor: AppColors.primaryColor,
                      indicatorWeight: 3,
                      indicatorSize: TabBarIndicatorSize.tab, // Equal underline sizes
                      labelColor: AppColors.primaryColor,
                      unselectedLabelColor: const Color(0xFF64748B),
                      dividerColor: Colors.transparent,
                      labelStyle: const TextStyle(
                        fontFamily: "Gilroy-Bold",
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                      tabs: const [
                        Tab(text: "HISTORY"),
                        Tab(text: "PENDING TESTS"),
                      ],
                    ),
                  ),
                ),
              ),

              Expanded(
                child: TabBarView(
                  controller: controller,
                  children: const [
                    LabsList(),
                    LabsList(),
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

class LabsList extends StatelessWidget {
  const LabsList({super.key});
   
  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Utils.windowWidth(context) > 600;

    final List<Lab> labs = [
      Lab(
        id: "1",
        title: "Green Lab",
        photo: ImagePaths.lab1,
        delivery: "Home Delievery: 25min",
        address: "20 Cooper Square, USA",
        rating: "4.9",
        tests: [],
      ),
      Lab(
        id: "2",
        title: "Green Lab",
        photo: ImagePaths.lab2,
        delivery: "Home Delievery: 25min",
        address: "20 Cooper Square, USA",
        rating: "4.9",
        tests: [],
      ),
      Lab(
        id: "3",
        title: "Green Lab",
        photo: ImagePaths.lab1,
        delivery: "Home Delievery: 25min",
        address: "20 Cooper Square, USA",
        rating: "4.9",
        tests: [],
      ),
      Lab(
        id: "4",
        title: "City Diagnostics",
        photo: ImagePaths.lab2,
        delivery: "Home Delievery: 40min",
        address: "42 Broadway, USA",
        rating: "4.7",
        tests: [],
      ),
    ];

    if (isDesktop) {
      return GridView.builder(
        padding: const EdgeInsets.all(40),
        itemCount: labs.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 340,
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
        ),
        itemBuilder: (ctx, i) {
          return LabWidget(
            lab: labs[i],
            actionText: "View Reports",
          );
        },
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: ScallingConfig.scale(14),
        vertical: 20,
      ),
      itemCount: labs.length,
      itemBuilder: (ctx, i) {
        return LabWidget(
          lab: labs[i],
          actionText: "View Reports",
        );
      },
    );
  }
}


