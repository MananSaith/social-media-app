import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constant/colorclass.dart';
import 'package:social_media_app/constant/font_weight.dart';
import 'package:social_media_app/controllers/getDataController/get_all_data_controller.dart';
import 'package:social_media_app/utalities/My%20profile%20utils/my_profile_dailog_display.dart';
import 'package:social_media_app/wedgits/container_decoration.dart';
import 'package:social_media_app/wedgits/textwidget.dart';
class PostWidget extends StatefulWidget {
  PostWidget({Key? key}) : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  final GetAllDataController getDataController = Get.put(GetAllDataController());
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                                  .collection("post")
                                  .where("uid", isEqualTo: getDataController.currentUserUid)
                                  
                                  .snapshots(),
                           builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  
                                  return Center(child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                               
                                  return Center(child: Text("Error: ${snapshot.error}"));
                                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                               
                                  return Center(child:  TextWidget(
                                text: "No Post Right Now",
                                fSize: 20,
                                fWeight: MyFontWeight.bold,
                              ),);
                                }
                        
                         
                                List<Map<String, dynamic>> postList = snapshot.data!.docs.map((doc) {
                                  return doc.data() as Map<String, dynamic>;
                                }).toList();
                        
                                return  GridView.builder(
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3, // Number of columns
                                            crossAxisSpacing: 2.0,
                                            mainAxisSpacing: 2.0,
                                          ),
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: postList.length, // Total number of items
                                          itemBuilder: (BuildContext context, int index) {
                                            return InkWell(
                                              onTap: ()async{
                                               await  MyProfileDailogDisplay(List: postList[index]);
                                                setState(() { });
                                              },
                                              child: Container(
                                                decoration: containerDecorationWidget(color: Colors.black,bgColor: MyColors.bgPallet),
                                                child:ClipRRect(
                                                  borderRadius: const BorderRadius.all(
                                                    Radius.circular(20.0),
                                                  ),
                                                  child: postList[index]["type"]=="image"
                                                  ?Image.network(postList[index]["postPikUrl"],fit: BoxFit.cover,)
                                                  : Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: TextWidget(text: postList[index]["content"], fSize: 12),
                                                  ),
                                                  )
                                              ),
                                            );
                                          },
                                        );
                                    
                              },
                           );
                          
  }
}