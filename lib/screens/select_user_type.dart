import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_size_matters/flutter_size_matters.dart';
import 'package:icare/providers/auth_provider.dart';
import 'package:icare/screens/login.dart';
import 'package:icare/utils/imagePaths.dart';
import 'package:icare/utils/theme.dart';
import 'package:icare/utils/utils.dart';
import 'package:icare/widgets/custom_button.dart';
import 'package:icare/widgets/custom_text.dart';
import 'package:icare/widgets/user_type_card.dart';
import 'package:path/path.dart';

class SelectUserType extends ConsumerStatefulWidget {
  const SelectUserType({super.key});

  @override
  ConsumerState<SelectUserType> createState() => _SelectUserTypeState();
}

class _SelectUserTypeState extends ConsumerState<SelectUserType> {
  final List<Map<String, dynamic>> userTypes = [
  {
    "id": 1,
    "title": "I am a Patient",
    "description": "The easy way to reach your Doctor face-to-face.",
    "role": "patient",
    "image":ImagePaths.userType1,
  },
  {
    "id": 2,
    "title": "I am a Doctor",
    "description": "The easy way to reach your Patients face-to-face.",
    "role": "doctor",
    "image": ImagePaths.userType2,
  },
  {
    "id": 4,
    "title": "I am a Lab Technician",
    "description": "The easy way to reach your Tests/Reports face-to-face.",
    "role": "lab_technician",
    "image":  ImagePaths.userType4,
  },
  {
    "id": 3,
    "title": "I am a Pharmacist",
    "description": "The easy way to reach your Medicine face-to-face.",
    "role": "pharmacist",
    "image": ImagePaths.userType3,
  },
    {
    "id": 5,
    "title": "I am an Instructor",
    "description": "The easy way to manage and guide your students.",
    "role": "instructor",
    "image": ImagePaths.userType5,
  },
  {
    "id": 6,
    "title": "I am a Student",
    "description": "The easy way to learn and connect with instructors.",
    "role": "student",
    "image": ImagePaths.userType6,
  },
];

int? selected_id;

void onSelect(int id) {

  setState(() {
    selected_id= id;
  });
}

@override
  void dispose() {
    setState(() {
      selected_id = null;
    });
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {


    
   return LayoutBuilder(builder: (ctx, constraints) {
      if(constraints.maxWidth < 600){
   return _buildMobileLayout(context);
      }
      else if(constraints.maxWidth <1200) {
        return _buildDesktopLayout(context, true);
      }
      else{
        return _buildDesktopLayout(context, false);
      }
    });

  
}


Widget _buildMobileLayout(BuildContext context){
  return Container(
        width: Utils.windowWidth(context),
        height: Utils.windowHeight(context),
        decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/bgImage.jpeg", ),
         fit: BoxFit.cover
        )
        ),
        child: Padding(
          padding:  EdgeInsets.only(top:ScallingConfig.verticalScale(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: ScallingConfig.scale(50),),
              CustomText(text: "Select Type Of Your Account",
              fontSize:25.27,
              maxLines: 2,
              padding: EdgeInsets.only(left: ScallingConfig.moderateScale(12)),
              color: AppColors.themeBlue,
              width: Utils.windowWidth(context) * 0.5 ,
              fontWeight: FontWeight.w700,
              isBold: true,
              ),
              CustomText(text: "Choose the type of your account, Note: Account type cannot be changed later",
              padding: EdgeInsets.only(top: ScallingConfig.verticalScale(10), left: ScallingConfig.moderateScale(12)),

              width: Utils.windowWidth(context) * 0.8 ,
              textAlign: TextAlign.start,
              fontSize: 12.60,
              maxLines: 2,
              isSemiBold: true,
                    ),
              SizedBox(height: ScallingConfig.scale(20),),
              Expanded(child: Stack(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                   width: Utils.windowWidth(context),
                   padding: EdgeInsets.symmetric(horizontal: ScallingConfig.scale(10)), 
                    decoration: BoxDecoration(

                        color: AppColors.bgColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        
                      ),
                      child: Center(
                        child: ListView.builder(
                          padding: EdgeInsets.only(bottom: ScallingConfig.verticalScale(60)),                          
                          itemCount: userTypes.length,
                          itemBuilder: (ctx,i) {
                          return UserTypeCard(
                            image:userTypes[i]["image"],
                            title: userTypes[i]["title"],
                            description: userTypes[i]["description"],
                            onPressed: () {
  ref.read(authProvider.notifier).setUserRole(userTypes[i]["role"]);                              
                              onSelect(userTypes[i]["id"]);
                            },
                            isSelected: selected_id == userTypes[i]["id"]  ,
                          ); 
                        }
                        ),
                      ),
                  ),
                  if(selected_id != null)
                  Positioned(
                    bottom: ScallingConfig.verticalScale(20),
                    left: ScallingConfig.scale(20),
                    child: CustomButton(
                      width: Utils.windowWidth(context) * 0.9 ,
                      label: "Continue", 
                    borderRadius: ScallingConfig.moderateScale(30),
                    onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => LoginScreen()));
                  },))
                ],
              ))         
            ],
          ),
        ) 
    );

}
Widget _buildDesktopLayout(BuildContext context, bool isTablet) {
  return Center(
    child: Container(
decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/bgImage.jpeg", ),
         fit: BoxFit.cover
        )
),
      // color: AppColors.secondaryColor,
      constraints:  BoxConstraints(maxWidth: Utils.windowWidth(context)),
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Select Type Of Your Account",
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: AppColors.themeBlue,
            ),

            const SizedBox(height: 10),

            CustomText(
              text:
                  "Choose the type of your account, Note: Account type cannot be changed later",
              fontSize: 14,
            ),

            const SizedBox(height: 40),

            Expanded(
              child: GridView.builder(
                itemCount: userTypes.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isTablet ? 2 : 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.4,
                ),
                itemBuilder: (ctx, i) {
                  return UserTypeCard(
                    image: userTypes[i]["image"],
                    title: userTypes[i]["title"],
                    description: userTypes[i]["description"],
                    isSelected: selected_id == userTypes[i]["id"],
                    onPressed: () {
                      ref
                          .read(authProvider.notifier)
                          .setUserRole(userTypes[i]["role"]);
                      onSelect(userTypes[i]["id"]);
                    },
                  );
                },
              ),
            ),

            Align(
              // alignment: Alignment.centerRight,
              child: CustomButton(
                labelSize: isTablet ? 10 : 16,
                width: ScallingConfig.scale(200) ,
                label: "Continue",
                onPressed: selected_id == null
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LoginScreen(),
                          ),
                        );
                      },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

}
