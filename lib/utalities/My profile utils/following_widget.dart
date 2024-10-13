import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constant/font_weight.dart';
import 'package:social_media_app/constant/string_constant.dart';
import 'package:social_media_app/controllers/getDataController/get_all_data_controller.dart';
import 'package:social_media_app/screens/Navigator/ProfileScreen/show_following_followers_screen.dart';
import 'package:social_media_app/wedgits/textwidget.dart';

class FollowingWidget extends StatefulWidget {
  FollowingWidget({Key? key}) : super(key: key);

  @override
  State<FollowingWidget> createState() => _FollowingWidgetState();
}

class _FollowingWidgetState extends State<FollowingWidget> {
  final GetAllDataController getDataController = Get.put(GetAllDataController());
  List<Map<String, dynamic>> followingList = [];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => ShowFollowingFollowersScreen(post: followingList, title: MyText.following)),
      child: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(getDataController.currentUserUid)
                .collection("following")
                .snapshots(),  // Stream to listen for changes in Firestore
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

              // Map the Firestore data to a list
              followingList = snapshot.data!.docs.map((doc) {
                return doc.data() as Map<String, dynamic>;
              }).toList();

              return TextWidget(
                text: followingList.length.toString(),
                fSize: 20,
                fWeight: MyFontWeight.bold,
              );
            },
          ),
          TextWidget(
            text: MyText.following,
            fSize: 12,
            fWeight: MyFontWeight.medium,
          ),
        ],
      ),
    );
  }
}
