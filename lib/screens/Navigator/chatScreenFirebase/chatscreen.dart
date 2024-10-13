// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:social_media_app/constant/string_constant.dart';
// import 'package:social_media_app/controllers/getDataController/get_all_data_controller.dart';
// import '../../../constant/colorclass.dart';
// import '../../../constant/font_weight.dart';
// import '../../../wedgits/container_decoration.dart';
// import '../../../wedgits/textwidget.dart';
// class Chatscreen extends StatefulWidget {
//   final DocumentSnapshot doc;
//   final DocumentSnapshot userData;

//   Chatscreen({
//     super.key,
//     required this.doc,
//     required this.userData,
//   });

//   @override
//   _ChatscreenState createState() => _ChatscreenState();
// }

// class _ChatscreenState extends State<Chatscreen> {
//   final TextEditingController controller = TextEditingController();
//   final GetAllDataController currentUserdataontroller = Get.put(GetAllDataController());
//   RxBool check = true.obs;
//   ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose(); // Dispose of the controller
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: MyColors.scaffoldBack,
//       appBar: AppBar(
//         titleSpacing: 0,
//         centerTitle: false,
//         backgroundColor: MyColors.primaryPallet,
//         title: Row(
//           children: [
//             CircleAvatar(
//               radius: 20, // Adjust the size of the avatar
//               backgroundImage: NetworkImage(widget.userData["profilePhoto"]),
//               backgroundColor: Colors.transparent,
//             ),
//             SizedBox(width: 10), // Adjust the space between avatar and title
//             Expanded(
//               child: TextWidget(
//                 text: widget.userData["username"],
//                 fSize: 20,
//                 fWeight: MyFontWeight.bold,
//                 maxLine: 1,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: StreamBuilder<QuerySnapshot>(
//                 stream: widget.doc.reference.collection("massages").orderBy("time").snapshots(),
//                 builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator()); // Show loading indicator while waiting
//                   } else if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}')); // Display error if any
//                   } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
//                     // Scroll to the bottom whenever the list updates
//                     WidgetsBinding.instance.addPostFrameCallback((_) {
//                       _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
//                     });

//                     return ListView.builder(
//                       controller: _scrollController,
//                       itemCount: snapshot.data!.docs.length,
//                       itemBuilder: (context, index) {
//                         DocumentSnapshot msg = snapshot.data!.docs[index];

//                         if (msg["uid"] == currentUserdataontroller.currentUserUid) {
//                           return _buildMyMessage(msg);
//                         } else {
//                           return _buildOtherMessage(msg);
//                         }
//                       },
//                     );
//                   } else {
//                     return Center(child: Text('No Message')); // Handle case when no data is found
//                   }
//                 },
//               ),
//             ),
//             _buildInputField(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMyMessage(DocumentSnapshot msg) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         Container(
//           padding: EdgeInsets.only(top: 12, left: 12, right: 12),
//           margin: EdgeInsets.all(6),
//           decoration: containerDecorationWidget(color: MyColors.black, bgColor: MyColors.bgPallet),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               TextWidget(text: msg["content"], fSize: 15),
//               TextWidget(
//                 text: _formatTime(msg["time"]), // For the time part
//                 fSize: 10,
//                 dir: true,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildOtherMessage(DocumentSnapshot msg) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           padding: EdgeInsets.only(top: 12, left: 12, right: 12),
//           margin: EdgeInsets.all(6),
//           decoration: containerDecorationWidget(color: MyColors.black, bgColor: MyColors.cream),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               TextWidget(text: msg["content"], fSize: 15),
//               TextWidget(
//                 text: _formatTime(msg["time"]), // For the time part
//                 fSize: 10,
//                 dir: true,
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Row _buildInputField() {
//     return Row(
//       children: [
//         Expanded(
//           child: TextField(
//             controller: controller,
//             autocorrect: true,
//             enableSuggestions: true,
//             maxLines: 4,
//             minLines: 1,
//             decoration: InputDecoration(
//               hintText: MyText.Messange,
//               hintStyle: TextStyle(color: Colors.black12),
//             ),
//             style: TextStyle(color: Colors.black, fontSize: 18),
//             onChanged: (v) {
//               check.value = v.isEmpty;
//             },
//           ),
//         ),
//         Obx(() {
//           return Visibility(
//             visible: check.value,
//             child: Row(
//               children: [
//                 IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt, color: MyColors.blackTransparent)),
//                 IconButton(onPressed: () {}, icon: Icon(Icons.photo, color: MyColors.blackTransparent)),
//               ],
//             ),
//           );
//         }),
//         IconButton(
//           onPressed: () async {
//             if (controller.text.isNotEmpty) {
//               await widget.doc.reference.collection("massages").add({
//                 "content": controller.text,
//                 "time": DateTime.now(),
//                 "type": "text",
//                 "uid": currentUserdataontroller.currentUserUid.toString(),
//               });

//               await widget.doc.reference.update({
//                 "recentmessage": controller.text,
//                 "time": DateTime.now(),
//               });

//               controller.clear();
//             }
//           },
//           icon: Icon(Icons.send, color: MyColors.camel, size: 30),
//         ),
//       ],
//     );
//   }

//   // Function to format the date from Firestore Timestamp
//   // String _formatDate(Timestamp timestamp) {
//   //   DateTime dateTime = timestamp.toDate();
//   //   return DateFormat('dd MMM yyyy').format(dateTime); // Example: 28 Sep 2024
//   // }

//   // Function to format the time from Firestore Timestamp
//   String _formatTime(Timestamp timestamp) {
//     DateTime dateTime = timestamp.toDate();
//     return DateFormat('hh:mm a').format(dateTime); // Example: 02:45 PM
//   }
// }
