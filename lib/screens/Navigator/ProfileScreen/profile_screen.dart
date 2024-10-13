import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constant/colorclass.dart';
import 'package:social_media_app/constant/font_weight.dart';
import 'package:social_media_app/constant/string_constant.dart';
import 'package:social_media_app/controllers/getDataController/get_all_data_controller.dart';
import 'package:social_media_app/utalities/My%20profile%20utils/followers_widget.dart';
import 'package:social_media_app/utalities/My%20profile%20utils/following_widget.dart';
import 'package:social_media_app/utalities/My%20profile%20utils/post_widget.dart';
import 'package:social_media_app/utalities/custom_loader.dart'; 
import 'package:social_media_app/wedgits/textwidget.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GetAllDataController getDataController = Get.put(GetAllDataController());

  @override
  void initState() {
    super.initState();
    // Call data fetching in initState
    getDataController.getData();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
   // final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: MyColors.scaffoldBack,
      appBar: AppBar(
        backgroundColor: MyColors.primaryPallet,
        shadowColor: MyColors.black,
        elevation: 10,
        title: Obx(() {
          // Check if data is available before rendering the username
          return getDataController.currentUserData.isNotEmpty
              ? TextWidget(
                  text: getDataController.currentUserData["username"],
                  fSize: 20,
                  fWeight: MyFontWeight.medium,
                )
              : TextWidget(text: 'Loading...', fSize: 20);
        }),
        centerTitle: true,
      ),

      // Body will also be built conditionally based on data availability
      body: Obx(() {
        // Show loading indicator if data is still being fetched
        if (getDataController.currentUserData.isEmpty) {
          return Center(child: LoaderOverlay());
        }

        // If data is available, build the UI
        return ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(200.0),
                    ),
                    child: getDataController.currentUserData["profilePhoto"] != null &&
                            getDataController.currentUserData["profilePhoto"] is String &&
                            getDataController.currentUserData["profilePhoto"].isNotEmpty
                        ? Image.network(
                            getDataController.currentUserData["profilePhoto"],
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.person,
                            size: 80,
                            color: Colors.grey,
                          ),
                  ),

                  FollowingWidget(), 
                 
                  FollowersWidget(),
                  Column(
                    children: [
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                                .collection("post")
                                .where("uid", isEqualTo: getDataController.currentUserUid)
                                .snapshots(),
                       builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                                          if (snapshot.connectionState == ConnectionState.waiting) {

                                  return Center(child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(child: Text("Error: ${snapshot.error}"));
                                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                                  return Center(
                                    child: TextWidget(
                                      text: "0",
                                      fSize: 20,
                                      fWeight: MyFontWeight.bold,
                                    ),
                                  );
                                }

                    
                                return TextWidget(
                                  text: snapshot.data!.docs.length.toString(),
                                  fSize: 20,
                                  fWeight: MyFontWeight.bold,
                                );
                       }
                       
                       ),          
                      TextWidget(
                        text: MyText.posts,
                        fSize: 12,
                        fWeight: MyFontWeight.medium,
                      ),
                    ],
                  ),
                
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 10, top: 5),
              child: TextWidget(
                text: MyText.captionAboutProfile,
                fSize: 12,
              ),
            ),
            
            SizedBox(height: height * 0.03),

           PostWidget(),
           ],
        );
      }),
    );
  }
}
