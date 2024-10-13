import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:social_media_app/constant/colorclass.dart';
import 'package:social_media_app/constant/font_weight.dart';
import 'package:social_media_app/wedgits/container_decoration.dart';
import 'package:social_media_app/wedgits/textwidget.dart';
// ignore: must_be_immutable
class ImagePostDisplay extends StatefulWidget {
   final Map<String, dynamic> post;
    bool delete=false;
   ImagePostDisplay({
    super.key,
    required this.post,
    required this.delete
  });

  @override
  State<ImagePostDisplay> createState() => _ImagePostDisplayState();
}

class _ImagePostDisplayState extends State<ImagePostDisplay> {
  @override
  Widget build(BuildContext context) {
     final height = MediaQuery.of(context).size.height;
    final Width = MediaQuery.of(context).size.width;


     // Convert Firestore Timestamp to DateTime
    Timestamp timestamp = widget.post['time'];
    DateTime dateTime = timestamp.toDate();

    // Format the DateTime to a readable string
    String formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);

    return Card(
      elevation: 12,
       color: Colors.transparent, 
        shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(20)
               ),
      child: Container(
        padding: EdgeInsets.only(top: 8,bottom: 8),
        decoration: containerDecorationWidget(color: MyColors.hintInput,bgColor: MyColors.secondaryPallet),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius:const  BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                        child: Image.network(widget.post["photoUrl"],width:Width*0.10,),
                      ),
                
                      SizedBox(width: Width*0.025,),
                      TextWidget(text: widget.post["username"], fSize: 20,fWeight: MyFontWeight.bold,)
                    ]
                            ),
              ),
            SizedBox(height: height*0.015),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: TextWidget(text: widget.post["content"], fSize: 15),
            ),
            SizedBox(height: height*0.015),

             AspectRatio(
                      aspectRatio: 1,
                     
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(widget.post["postPikUrl"],fit: BoxFit.cover),
                      ),
                    ),
             SizedBox(height: height*0.015),
             Padding(
               padding: const EdgeInsets.only(left: 8,right: 8),
               child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 TextWidget(text: formattedDate, fSize: 12),
                 Visibility(
                  visible: widget.delete,
                   child: IconButton(onPressed: ()async{
                    final querySnapshot =await FirebaseFirestore.instance.collection("post").where("delete",isEqualTo: widget.post["delete"]).get();
                    for (var doc in querySnapshot.docs) {
                      await FirebaseFirestore.instance.collection("post").doc(doc.id).delete();
                    }
                     Get.back();
                   }, 
                   icon: Icon(Icons.delete,color: Colors.red,)),
                 )
               ],
             ),
             )
          ],
        ),
      ),
    );
  }
}