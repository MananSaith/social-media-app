// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:social_media_app/constant/colorclass.dart';
// import 'package:social_media_app/constant/font_weight.dart';
// import 'package:social_media_app/screens/Navigator/chatScreen/add_new_user_for_chat.dart';
// import 'package:social_media_app/screens/Navigator/chatScreen/chatscreen.dart';
// import 'package:social_media_app/wedgits/container_decoration.dart';
// import 'package:social_media_app/wedgits/textwidget.dart';
// class ChatListScreen extends StatefulWidget {
//   ChatListScreen({Key? key}) : super(key: key);

//   @override
//   __ChatScreeState createState() => __ChatScreeState();
// }

// class __ChatScreeState extends State<ChatListScreen> {
//   final TextEditingController inputController=TextEditingController();
//   final _fireStoreChat = FirebaseFirestore.instance.collection("chats");
//   final _currentUser = FirebaseAuth.instance.currentUser!.uid;


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: MyColors.scaffoldBack,

//       appBar: AppBar(
//           backgroundColor: MyColors.primaryPallet,
//           title: TextField(
//             controller: inputController,
//             decoration: InputDecoration(
//               hintText: 'Search...',
//               border: InputBorder.none,
//               hintStyle: TextStyle(color: Colors.white54),
//             ),
//             style: TextStyle(color: Colors.white, fontSize: 18),
//             onChanged: (v){setState(() { });},
//           ),
//    ),

//           body: StreamBuilder<QuerySnapshot>(
//             stream: _fireStoreChat.where("users",arrayContains: _currentUser).snapshots(), 
//             builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
//                 if (snapshot.connectionState == ConnectionState.waiting) {
          
//           return Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
                 
//           return Center(child: Text("Error: ${snapshot.error}"));
//                   } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                 
//           return Center(child: Text("No Chat available"));
//                   }
//               return ListView.builder(
//                 itemCount: snapshot.data!.docs.length,
//                 itemBuilder: (context,index){
//                 DocumentSnapshot doc=snapshot.data!.docs[index];
          
//                 final msgUser=  _currentUser==doc["users"][0] ? doc["users"][1]:doc["users"][0];
                 
//                 return FutureBuilder<QuerySnapshot>(
//                         future: FirebaseFirestore.instance
//                             .collection("users")
//                             .where("uid", isEqualTo: msgUser)
//                             .get(),
//                         builder: (context, AsyncSnapshot<QuerySnapshot> userDataSnapshot) {
//                           if (userDataSnapshot.connectionState == ConnectionState.waiting) {
//                             return Center(child: CircularProgressIndicator()); // Show loading indicator while waiting
//                           } else if (userDataSnapshot.hasError) {
//                             return Center(child: Text('Error: ${userDataSnapshot.error}')); // Display error if any
//                           } else if (userDataSnapshot.hasData && userDataSnapshot.data!.docs.isNotEmpty) {
//                             DocumentSnapshot userData = userDataSnapshot.data!.docs.first;
//                             if(inputController.text.isEmpty){
//                             return  chatListItem(context: context,
//                             doc: doc,
//                             currentUser: _currentUser,
//                             inputController: inputController,
//                             userData: userData);
//                           }
//                           else if(userData["username"].toLowerCase().contains(inputController.text.toLowerCase().toLowerCase())){
//                             return  chatListItem(context: context,
//                             doc: doc,
//                             currentUser: _currentUser,
//                             inputController: inputController,
//                             userData: userData);
//                           }
//                           else{
//                             return Container();
//                           }
//                           } else {
//                             return Center(child: Text('No user data found')); // Handle case when no data is found
//                           }
//                         },
//                       );
          
          
//                 } 
//               );
//             }
//             ),

//      floatingActionButton: FloatingActionButton( 
//       onPressed: (){
//         Get.to(()=>SearchUserScreen());
//       },
//       child: Icon(Icons.add),
//       ),
//     );
//   }

 
// // Function to format the date from Firestore Timestamp
// String _formatDate(Timestamp timestamp) {
//   DateTime dateTime = timestamp.toDate();
//   return DateFormat('dd MMM yyyy').format(dateTime); // Example: 28 Sep 2024
// }

// // Function to format the time from Firestore Timestamp
// String _formatTime(Timestamp timestamp) {
//   DateTime dateTime = timestamp.toDate();
//   return DateFormat('hh:mm a').format(dateTime); // Example: 02:45 PM
// }


// Widget chatListItem({
//   required DocumentSnapshot doc,
//   required DocumentSnapshot userData,
//   required String currentUser,
//   required TextEditingController inputController,
//   required BuildContext context,
// }) {
//   return Container(
//     padding: EdgeInsets.all(6),
//     margin: EdgeInsets.all(5),
//     decoration: containerDecorationWidget(
//         color: MyColors.divider, bgColor: MyColors.bgPallet),
//     child: ListTile(
//       onTap: () {
//         inputController.text = "";
//         Get.to(() => Chatscreen(doc: doc, userData: userData));
//       },
//       leading: CircleAvatar(
//         radius: 25, // You can adjust the size
//         backgroundImage: NetworkImage(userData["profilePhoto"]),
//         backgroundColor: Colors.transparent,
//       ),
//       title: TextWidget(
//         text: userData["username"],
//         fSize: 20,
//         fWeight: MyFontWeight.bold,
//         maxLine: 1,
//       ),
//       subtitle: TextWidget(
//         text: doc["recentmessage"],
//         fSize: 12,
//         maxLine: 1,
//         overFlow: true,
//       ),
//       trailing: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TextWidget(
//             text: _formatDate(doc["time"]),
//             fSize: 12,
//           ),
//           TextWidget(
//             text: _formatTime(doc["time"]),
//             fSize: 12,
//           ),
//         ],
//       ),
//     ),
//   );
// }

// }
