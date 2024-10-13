import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constant/colorclass.dart';
import 'package:social_media_app/controllers/getDataController/get_all_data_controller.dart';
import 'package:social_media_app/wedgits/container_decoration.dart';
import 'package:social_media_app/wedgits/textwidget.dart';

// ignore: must_be_immutable
class ShowFollowingFollowersScreen extends StatefulWidget {
  List<Map<String, dynamic>> post;
  String title;

  ShowFollowingFollowersScreen({
    super.key,
    required this.post,
    required this.title,
  });

  @override
  _ShowFollowingFollowersScreenState createState() =>
      _ShowFollowingFollowersScreenState();
}

class _ShowFollowingFollowersScreenState
    extends State<ShowFollowingFollowersScreen> {
  final GetAllDataController getAllDataController = Get.put(GetAllDataController());
  
  // Method to refresh the following list
  Future<void> refreshFollowingList() async {
    // Fetch updated following data
    var updatedList = await FirebaseFirestore.instance
        .collection("users")
        .doc(getAllDataController.currentUserUid)
        .collection("following")
        .get();

    // Update the following list and rebuild the UI
    setState(() {
      widget.post = updatedList.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.scaffoldBack,
      appBar: AppBar(
        backgroundColor: MyColors.primaryPallet,
        title: TextWidget(text: widget.title, fSize: 20),
      ),
      body: widget.post.isEmpty
          ? Center(
              child: TextWidget(
                text: "No ${widget.title}",
                fSize: 18,
                fWeight: FontWeight.bold,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: widget.post.length,
                itemBuilder: (context, index) {
                  final user = widget.post[index];
                  return Container(
                    padding: EdgeInsets.all(6),
                    margin: EdgeInsets.only(bottom: 6),
                    decoration: containerDecorationWidget(
                      color: MyColors.red,
                      bgColor: MyColors.bgPallet,
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(user["profilePhoto"], fit: BoxFit.cover),
                      ),
                      title: TextWidget(
                        text: user["username"],
                        fSize: 15,
                        maxLine: 1,
                      ),
                      trailing: FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection("users")
                            .doc(user["uid"])
                            .collection("followers")
                            .doc(getAllDataController.currentUserUid)
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.exists) {
                              return ElevatedButton(
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(user["uid"])
                                      .collection("followers")
                                      .doc(getAllDataController.currentUserUid)
                                      .delete();
                                  await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(getAllDataController.currentUserUid)
                                      .collection("following")
                                      .doc(user["uid"])
                                      .delete();

                                  // Re-fetch the data after the unfollow operation
                                  await refreshFollowingList();
                                },
                                child: TextWidget(text: "unFollow", fSize: 15),
                              );
                            } else {
                              return ElevatedButton(
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(user["uid"])
                                      .collection("followers")
                                      .doc(getAllDataController.currentUserUid)
                                      .set({
                                    "uid": getAllDataController.currentUserUid,
                                    "time": DateTime.now(),
                                    "username": getAllDataController
                                        .currentUserData["username"],
                                    "profilePhoto": getAllDataController
                                        .currentUserData["profilePhoto"]
                                  });

                                  await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(getAllDataController.currentUserUid)
                                      .collection("following")
                                      .doc(user["uid"])
                                      .set({
                                    "uid": user["uid"],
                                    "username": user["username"],
                                    "profilePhoto": user["profilePhoto"],
                                    "time": DateTime.now(),
                                  });

                                  // Re-fetch the data after the follow operation
                                  await refreshFollowingList();
                                },
                                child: TextWidget(text: "Follow", fSize: 15),
                              );
                            }
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
