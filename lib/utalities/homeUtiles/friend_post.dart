import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/utalities/PostUtiles/Text_post_display.dart';
import 'package:social_media_app/utalities/PostUtiles/image_post_display.dart';

class FriendPost extends StatelessWidget {
  const FriendPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _fireStore = FirebaseFirestore.instance;
    final currentUserUid = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore
          .collection("users")
          .doc(currentUserUid)
          .collection("following")
          .orderBy("time", descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot1) {
        if (snapshot1.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot1.hasError) {
          return Center(child: Text("Error: ${snapshot1.error}"));
        }

        final List<String> followingList = snapshot1.data!.docs.map((doc) {
          return doc['uid'] as String;
        }).toList();

        if (followingList.isEmpty) {
          return Center(child: Text("No following users found."));
        }

        return StreamBuilder<QuerySnapshot>(
          stream: _fireStore 
              .collection("post")
              .where("uid", whereIn: followingList)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot2) {
            if (snapshot2.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot2.hasError) {
              return Center(child: Text("Error: ${snapshot2.error}"));
            } else if (!snapshot2.hasData || snapshot2.data!.docs.isEmpty) {
              return Center(child: Text("No posts available from followed users."));
            }

            // Extract posts from the query
            final List<Map<String, dynamic>> postsList = snapshot2.data!.docs.map((doc) {
              return doc.data() as Map<String, dynamic>;
            }).toList();

            return ListView.builder(
              itemCount: postsList.length,
              itemBuilder: (context, index) {
                final post = postsList[index];

                // Handle the post display based on type (text or image)
                if (post["type"] == "text") {
                  return TextPostDisplay(post: post, delete: false);
                } else if (post["type"] == "image") {
                  return ImagePostDisplay(post: post, delete: false);
                } else {
                  return SizedBox.shrink(); // If type is not supported, show nothing
                }
              },
            );
          },
        );
      },
    );
  }
}
