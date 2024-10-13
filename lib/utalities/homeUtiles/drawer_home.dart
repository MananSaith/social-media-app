import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constant/colorclass.dart';
import 'package:social_media_app/constant/font_weight.dart';
import 'package:social_media_app/constant/string_constant.dart';
import 'package:social_media_app/screens/Navigator/ProfileScreen/profile_screen.dart';
import 'package:social_media_app/screens/registrationscreens/login_screen.dart';
import 'package:social_media_app/wedgits/container_decoration.dart';
import 'package:social_media_app/wedgits/textwidget.dart';
class DrawerHome extends StatelessWidget {
   DrawerHome({Key? key}) : super(key: key);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    //final Widget = MediaQuery.of(context).size.width;
    return  Drawer(
        backgroundColor: MyColors.bgPallet,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              SizedBox(height: height*0.05,),
              Image.asset(MyText.linzaSocialMediaLogo),
              SizedBox(height: height*0.045,),
              Container(
                decoration: containerDecorationWidget(color: MyColors.divider,bgColor: MyColors.secondaryPallet),
                child: ListTile(
                  onTap: ()async{
                    
                    Get.to(()=>ProfileScreen());
                  },
                  title: TextWidget(text:MyText.profile, fSize: 20,fWeight: MyFontWeight.bold,),
                  leading: Icon(Icons.person_2_rounded),
                ),
              ),
              SizedBox(height: height*0.025,),
              Container(
                decoration: containerDecorationWidget(color: MyColors.divider,bgColor: MyColors.secondaryPallet),
                child: ListTile(
                  onTap: ()async{
                    

                    Get.defaultDialog(
                                  confirm: TextButton(
                                    onPressed: () {
                                     _auth.signOut();
                                     Get.offAll(()=>LoginScreen());
                                    },
                                    child: TextWidget(
                                      text: "log out",
                                      fSize: 20,
                                      textColor: MyColors.blue,
                                    ),
                                  ),
                                  cancel: TextButton(
                                    onPressed: () {
                                     Get.back();
                                    },
                                    child: TextWidget(
                                      text: "Cancel",
                                      fSize: 20,
                                      textColor: MyColors.blue,
                                    ),
                                  ),
                                  middleText: "you want to log Out ",
                                );
                  },
                  title: TextWidget(text:MyText.logOut, fSize: 20,fWeight: MyFontWeight.bold,),
                  leading: Icon(Icons.logout),
                  
                ),
              ),
            ],
            ),
        ),
        );

  }
}