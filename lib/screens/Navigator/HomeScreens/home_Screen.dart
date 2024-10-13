import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constant/colorclass.dart';
import 'package:social_media_app/constant/font_weight.dart';
import 'package:social_media_app/constant/string_constant.dart';
import 'package:social_media_app/controllers/utilsController/foryou_frient_change_controller.dart';
import 'package:social_media_app/screens/Navigator/HomeScreens/searchscreen.dart';
import 'package:social_media_app/utalities/homeUtiles/drawer_home.dart';
import 'package:social_media_app/utalities/homeUtiles/foryou_post.dart';
import 'package:social_media_app/utalities/homeUtiles/friend_post.dart';
import 'package:social_media_app/wedgits/custum_button.dart';
import 'package:social_media_app/wedgits/textwidget.dart';
class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

 
  @
  override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StateChangeController stateController = Get.put(StateChangeController());
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    //final Widget = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyColors.scaffoldBack,
      appBar: AppBar(
        backgroundColor: MyColors.primaryPallet,
        shadowColor: MyColors.black,
        elevation: 10,
        centerTitle: true,
        title: TextWidget(text: MyText.appName, fSize: 20, fWeight: MyFontWeight.medium,),
        actions: [
          IconButton(onPressed: (){ Get.to(()=>Searchscreen());}, icon: Icon(Icons.search,size: 30,color: MyColors.black,))
        ],
      ),
      
      body: Obx((){
          return Column(
        children: [
          SizedBox(height:height*0.025 ,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
             CustomElevatedButton(
              backgroundColor: stateController.change.value? MyColors.scaffoldBack: MyColors.primaryPallet,
              text: MyText.friend,
              textColor:  stateController.change.value? MyColors.black: MyColors.white,
              onPressed: ()=> stateController.ChangeFun(0),
              ),

              CustomElevatedButton(
                backgroundColor: stateController.change.value?MyColors.primaryPallet:MyColors.scaffoldBack,
              text: MyText.forYou,
              textColor:  stateController.change.value? MyColors.white: MyColors.black,
              onPressed: ()=> stateController.ChangeFun(1),
              )
            ],
          ),
          SizedBox(height: height*0.025,),
          Expanded(
            child: stateController.change.value? 
           ForyouPost(): 
            FriendPost(),
            )
      ],
      );
      }),


      drawer:DrawerHome(),
        
    );
  }
}