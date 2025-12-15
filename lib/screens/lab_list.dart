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
    return Scaffold(
            appBar: AppBar(
        leading: CustomBackButton(),
        automaticallyImplyLeading: false,
        title: CustomText(
        text:"Book A Lab", 
        fontFamily: "Gilroy-Bold", 
        fontSize: 18,
        color: AppColors.darkGray500,
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
SizedBox(height: ScallingConfig.scale(20),),
          SizedBox(
            width: Utils.windowWidth(context),

            // height: Utils.windowHeight(context) * 0.06,
            child: TabBar(
            controller: controller,
            indicatorWeight: 6,
            indicatorColor: AppColors.themeBlack,
            tabs: [
              CustomText(
                text: "History",
                
                padding: EdgeInsets.only(bottom:5),
                width: Utils.windowWidth(context) * 0.33,
                textAlign: TextAlign.center,
              ),
              CustomText(
                text: "Pending Tests",
                padding: EdgeInsets.only(bottom:5),
                width: Utils.windowWidth(context) * 0.33,
                textAlign: TextAlign.center,
              ),
            ],
                    ),
          ),   
          Expanded(child: TabBarView(
        controller: controller,
        children: [
            LabsList(),
            LabsList(),
        ],
      ),),

            
          ],
        ),
      ) ,
    );
  }
}

class LabsList extends StatelessWidget {
  const LabsList({super.key});
   
  @override
  Widget build(BuildContext context) {
     final List<Lab> labs= [
      Lab(
        id: "1",
        title: "Green Lab",
        photo: ImagePaths.lab1, 
        delivery: "Home Delievery: 25min",
        address: "20 Cooper Square, USA",
        rating:"4.9",
        tests:[]
      ),
      Lab(
        id: "2",
        title: "Green Lab",
        photo: ImagePaths.lab2, 
        delivery: "Home Delievery: 25min",
        address: "20 Cooper Square, USA",
        rating:"4.9",
        tests:[]
      ),
      Lab(
        id: "3",
        title: "Green Lab",
        photo: ImagePaths.lab1, 
        delivery: "Home Delievery: 25min",
        address: "20 Cooper Square, USA",
        rating:"4.9",
        tests:[]
      ),
     ];
    
    return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: ScallingConfig.scale(14)),
        itemCount: labs.length,
        itemBuilder: (ctx,i) {
        return (
          LabWidget(lab: labs[i], actionText: "Book a Lab Test",)
        );
      });
  }
}


