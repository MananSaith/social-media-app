
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/controllers/utilsController/loader_controller.dart';

class TextPostController extends GetxController{
  final LoaderController loader= Get.put(LoaderController());
  TextEditingController   postText =TextEditingController();
  final _currentUser= FirebaseAuth.instance.currentUser;
  final fireStore = FirebaseFirestore.instance.collection("post");


  void  postTextFun()async{
    loader.loaderFunction();

    try{

      final  querySnapshot= await FirebaseFirestore.instance.collection("users").where("uid",isEqualTo: _currentUser!.uid.toString()).get();
      final DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
      final Map<String, dynamic> userData = documentSnapshot.data() as Map<String, dynamic>;

      // Print the user data
      print("User Data: $userData");

      await fireStore.add({
        "content":postText.text,
        "uid":_currentUser.uid,
        "photoUrl":_currentUser.photoURL,
        "type":"text",
        "time":DateTime.now(),
        "delete":DateTime.now().microsecondsSinceEpoch,
        "username":userData["username"],
      });
     
     
     Get.snackbar("Post", "Successfully uploading your post",snackPosition: SnackPosition.TOP);

    postText.clear();
  //    try{

  //     // Fetch all documents from the "posts" collection
  //     final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //     .collection("post")
  //     .get();
      
  //     final List<Map<String, dynamic>> postsList = querySnapshot.docs.map((doc) {
  //           return doc.data() as Map<String, dynamic>;
  //          }).toList();

  // print(postsList);
      
          
  //    }catch(e){

  //     print("error in post fetch $e");

  //    }
       
    }
    catch(e){
     Get.snackbar("Error", "unExpected error during uploading",snackPosition: SnackPosition.TOP);
    }
     loader.loaderFunction();
  }









}