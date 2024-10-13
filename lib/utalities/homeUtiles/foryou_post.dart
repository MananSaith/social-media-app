import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/utalities/PostUtiles/Text_post_display.dart';
import 'package:social_media_app/utalities/PostUtiles/image_post_display.dart';

class ForyouPost extends StatelessWidget {
  const ForyouPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _fireStore = FirebaseFirestore.instance;

    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection("post").orderBy("time",descending: true).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
       
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
       
          return Center(child: Text("No posts available"));
        }

 
        final List<Map<String, dynamic>> postsList = snapshot.data!.docs.map((doc) {
          return doc.data() as Map<String, dynamic>;
        }).toList();

        return ListView.builder(
          itemCount: postsList.length,
          itemBuilder: (context, index) {
            final post = postsList[index];

            if(post["type"]=="text"){
              return TextPostDisplay(post: post,delete: false,);
            }
            else{
             return ImagePostDisplay(post: post,delete: false,);
            }
           
          
          },
        );
      },
    );
  }
}
