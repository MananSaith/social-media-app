import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/controllers/utilsController/custom_loader_controller.dart';
import 'package:social_media_app/controllers/postController/gallary_camera_picker_controller.dart';

class UploadImagePostController extends GetxController{

  final CunstomLoaderController loader=Get.put(CunstomLoaderController());
  final ImagePickerController controllerImage = Get.put(ImagePickerController());
  final TextEditingController caption =TextEditingController();
  final _currentUser= FirebaseAuth.instance.currentUser;
  final _fireStore = FirebaseFirestore.instance.collection("post");

  FirebaseStorage storage = FirebaseStorage.instance;



  

  Future<void> UploadPostFireStorage()async{
   loader.showLoader();
  try{
    XFile? imageFile = controllerImage.pickFile;

    if (imageFile != null) {
      // Create a reference to the location you want to upload the file to
      final id = DateTime.now().millisecondsSinceEpoch;
      final ref = storage.ref().child('postImage/post/$id');

      // Upload the file
      await ref.putFile(File(imageFile.path));
      // Get the download URL
      String downloadURL = await ref.getDownloadURL();


      final  querySnapshot= await FirebaseFirestore.instance.collection("users").where("uid",isEqualTo: _currentUser!.uid.toString()).get();
      final DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
      final Map<String, dynamic> userData = documentSnapshot.data() as Map<String, dynamic>;


      await _fireStore.add({
        "content":caption.text,
        "uid":_currentUser.uid,
        "photoUrl":_currentUser.photoURL,
        "type":"image",
        "time":DateTime.now(),
        "delete":DateTime.now().microsecondsSinceEpoch,
        "username":userData["username"],
        "postPikUrl":downloadURL.toString(),
      });
      Get.snackbar('post upload', 'post is successfully uploaded', snackPosition: SnackPosition.TOP);
      
    }
    else{
      Get.snackbar('Error', 'enter complete information', snackPosition: SnackPosition.TOP);
    }

  }catch(e){
    Get.snackbar('Error', 'please stable your Internet', snackPosition: SnackPosition.TOP);
  }
        loader.hideLoader();
  }
}
