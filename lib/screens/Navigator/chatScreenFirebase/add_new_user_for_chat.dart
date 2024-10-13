// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:social_media_app/constant/colorclass.dart';
// import 'package:social_media_app/constant/font_weight.dart';
// import 'package:social_media_app/constant/string_constant.dart';
// import 'package:social_media_app/wedgits/container_decoration.dart';
// import 'package:social_media_app/wedgits/inputdecorationwidget.dart';
// import 'package:social_media_app/wedgits/textwidget.dart';
// class SearchUserScreen extends StatefulWidget {
//   SearchUserScreen({Key? key}) : super(key: key);

//   @override
//   _SearchUserScreen createState() => _SearchUserScreen();
// }

// class _SearchUserScreen extends State<SearchUserScreen> {
//   final _fireStoreUser= FirebaseFirestore.instance.collection("users");
//   final _fireStoreChat= FirebaseFirestore.instance.collection("chats");
//   final _currentUser = FirebaseAuth.instance.currentUser!.uid;
//   Map<String, dynamic> CurrentUserData={};
//   String? searchName;

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     //final Widget = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: MyColors.scaffoldBack,
//       appBar: AppBar(
//         title: TextWidget(text: MyText.Messanger, fSize: 23,textColor: MyColors.black,fWeight: MyFontWeight.medium,),
//         centerTitle: true,
//         backgroundColor: MyColors.primaryPallet,
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
//         child: Column(
//           children: [
            
//              SizedBox(height: height*0.015),
//             TextField(
//               decoration: inputDecorationWidget(text: MyText.searchUser),
//               autocorrect: false, // Enable autocorrect
//                        enableSuggestions: true, // Allow suggestions
//                        textInputAction: TextInputAction.next,
//               onChanged: (val){
//                searchName=val;
//                setState(() {
                 
//                });
//               },
//             ),
            
//             SizedBox(height: height*0.025,),

//             if(searchName!=null)
//               if(searchName!.length>3) FutureBuilder(
//                 future: _fireStoreUser.where("username",isEqualTo: searchName).get(),
//                  builder: (context,snapshot){
//                   if(snapshot.hasData){
//                      if(snapshot.data!.docs.isEmpty){
//                       return Center(child: TextWidget(text:MyText.notFound, fSize: 15));
//                      }
//                      else{
//                       return Expanded(
//                         child: ListView.builder(
//                           itemCount: snapshot.data!.docs.length,
//                           itemBuilder: (context,index){

//                             DocumentSnapshot doc = snapshot.data!.docs[index];
//                             return Container(
//                               padding: EdgeInsets.all(6),
//                               decoration: containerDecorationWidget(color: MyColors.red,bgColor: MyColors.thirdPallet),
//                               child: ListTile(
//                                 leading:  CircleAvatar(
//                                               radius: 25, // You can adjust the size
//                                               backgroundImage: NetworkImage(doc["profilePhoto"]), // Fallback URL if no profile picture
//                                               backgroundColor: Colors.transparent, // Set to transparent if the image has transparency
//                                             ),
//                                 title: TextWidget(text: doc["username"], fSize: 15,maxLine: 1,),

//                                 trailing: FutureBuilder<QuerySnapshot>(
//                                 future:  _fireStoreUser.doc(_currentUser).collection("friendchat").where("uid",isEqualTo: doc["uid"]).get(), 
//                                 builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
//                                   if(snapshot.hasError){
//                                    return  Icon(Icons.warning_rounded);
                                        
//                                   }
//                                   if(snapshot.hasData){
//                                     if(snapshot.data!.docs.isEmpty){
//                                        return IconButton(
//                                         onPressed: ()async{

//                                           // ya dono line ya kara gi ka har ek ka user ma friendchat collection
//                                           //ka ander us banda ka uid dal da ga jis sath hum chat kar raha hai asa
//                                           //huma find karna ma easy ho ga ka kon kon humara sath chat kar raha hai
//                                           //ya dono ki friendchat collection ma ek dosara ka uid add kara  ga ta ka 
//                                           //dosara ka be add ho ja ka ya mera sath add ha 
//                                           //ya dono lines busssssssssss search ka kam ai gi bus
//                                           await _fireStoreUser.doc(_currentUser).collection("friendchat").add({"uid":doc["uid"]});
//                                           await _fireStoreUser.doc(doc["uid"]).collection("friendchat").add({"uid":_currentUser});

//                                           //ya to chat collection ma hum dono ka data add kar da ga ka abi chat 
//                                           //jis ki base pa sari chat ho gi 
                                          
//                                             await _fireStoreChat.add({
//                                               "users":[_currentUser,doc["uid"]],
//                                               "recentmessage":"",
//                                               "time":DateTime.now()
//                                             }
//                                             );
//                                             setState(() {   });  
//                                         }, 
//                                         icon: Icon(Icons.add)
//                                         );
//                                     }
//                                     else{
//                                       return IconButton(
//                                         onPressed: ()async{
                                           
//                                         }, 
//                                         icon: Icon(Icons.chat)
//                                         );
//                                     }

//                                   }
//                                   else{
//                                     return CircularProgressIndicator();
//                                   }
//                                 }
//                                 ),
//                               ),
//                             );

//                           }
//                           )
//                           );
//                      }
//                   }
//                   else{
//                    return CircularProgressIndicator();
//                   }
//                  }
//                  ),
//                  SizedBox(
//                   height: height*0.15,
//                   child: Lottie.asset(MyText.searchLottie)),
                 
                 
//           ],
//         ),
//         ),
//     );
//   }

 
// }

