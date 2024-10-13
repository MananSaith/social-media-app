import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:social_media_app/constant/colorclass.dart';
import 'package:social_media_app/constant/font_weight.dart';
import 'package:social_media_app/constant/string_constant.dart';
import 'package:social_media_app/wedgits/container_decoration.dart';
import 'package:social_media_app/wedgits/inputdecorationwidget.dart';
import 'package:social_media_app/wedgits/snackbar_custom.dart';
import 'package:social_media_app/wedgits/textwidget.dart';
class Searchscreen extends StatefulWidget {
  Searchscreen({Key? key}) : super(key: key);

  @override
  _SearchscreenState createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  final _fireStore= FirebaseFirestore.instance.collection("users");
  final _currentUser = FirebaseAuth.instance.currentUser!.uid;
  Map<String, dynamic> CurrentUserData={};
  String? searchName;

  @override
  void initState() { 
    super.initState();
    getUserData();
  }
   void getUserData()async{
    try{
      final  querySnapshot= await FirebaseFirestore.instance.collection("users").where("uid",isEqualTo: _currentUser).get();
      final DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
       CurrentUserData = documentSnapshot.data() as Map<String, dynamic>;
       setState(() {});
    }catch(e){
      showCustomSnackBar(
        title: "error",
        message: "$e"
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    //final Widget = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyColors.scaffoldBack,
      appBar: AppBar(
        title: TextWidget(text: "Find New User", fSize: 23,textColor: MyColors.black,fWeight: MyFontWeight.medium,),
        centerTitle: true,
        backgroundColor: MyColors.primaryPallet,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
        child: Column(
          children: [
            
             SizedBox(height: height*0.015),
             TextWidget(text: CurrentUserData["username"]??"current user not found", fSize: 20),
             
            TextField(
              decoration: inputDecorationWidget(text: "search User"),
              autocorrect: false, // Enable autocorrect
                       enableSuggestions: true, // Allow suggestions
                       textInputAction: TextInputAction.next,
              onChanged: (val){
               searchName=val;
               setState(() {
                 
               });
              },
            ),
            
            SizedBox(height: height*0.025,),

            if(searchName!=null)
              if(searchName!.length>3) FutureBuilder(
                future: _fireStore.where("username",isEqualTo: searchName).get(),
                 builder: (context,snapshot){
                  if(snapshot.hasData){
                     if(snapshot.data!.docs.isEmpty){
                      return Center(child: TextWidget(text: "no user found !!", fSize: 15));
                     }
                     else{
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context,index){

                            DocumentSnapshot doc = snapshot.data!.docs[index];
                            return Container(
                              padding: EdgeInsets.all(6),
                              decoration: containerDecorationWidget(color: MyColors.red,bgColor: MyColors.thirdPallet),
                              child: ListTile(
                                leading:  CircleAvatar(
                                              radius: 25, // You can adjust the size
                                              backgroundImage: NetworkImage(doc["profilePhoto"]), // Fallback URL if no profile picture
                                              backgroundColor: Colors.transparent, // Set to transparent if the image has transparency
                                            ),
                                title: TextWidget(text: doc["username"], fSize: 15,maxLine: 1,),

                                trailing: FutureBuilder(
                                future: doc.reference.collection("followers").doc(_currentUser).get(), 
                                builder: (context,snapshot){
                                  if(snapshot.hasData){
                                    if(snapshot.data!.exists){
                                       return ElevatedButton(
                                        onPressed: ()async{
                                           await doc.reference.collection("followers").doc(_currentUser).delete();
                                           await _fireStore.doc(_currentUser.toString()).collection("following").doc(doc["uid"]).delete();
                                           setState(() {
                                             
                                           });
                                        }, 
                                        child: TextWidget(text: "unFollow", fSize: 15));
                                    }
                                    else{
                                      return ElevatedButton(
                                        onPressed: ()async{
                                          //jise hum follow kar rahe hai us ka followers collections ma humara data
                                          //add kara ga
                                           await doc.reference.collection("followers").doc(_currentUser).set({
                                            "uid":_currentUser,
                                             "time":DateTime.now(),
                                             "username":CurrentUserData["username"],
                                             "profilePhoto":CurrentUserData["profilePhoto"]
                                             
                                        });
                                        //jise hum follow kar raha hai humara following collection 
                                        //ma humara data add kara ga
                                        await _fireStore.doc(_currentUser.toString()).collection("following").doc(doc["uid"]).set({
                                          "uid":doc["uid"],
                                          "username":doc["username"],
                                          "profilePhoto":doc["profilePhoto"],
                                          "time":DateTime.now(),

                                        });
                                        setState(() {
                                          
                                        });
                                        }, 
                                        child: TextWidget(text: "Follow", fSize: 15));
                                    }

                                  }
                                  else{
                                    return CircularProgressIndicator();
                                  }
                                }
                                ),
                              ),
                            );

                          }
                          )
                          );
                     }
                  }
                  else{
                   return CircularProgressIndicator();
                  }
                 }
                 ),
                 SizedBox(
                  height: height*0.15,
                  child: Lottie.asset(MyText.searchLottie)),
                 
                 
          ],
        ),
        ),
    );
  }

 
}

