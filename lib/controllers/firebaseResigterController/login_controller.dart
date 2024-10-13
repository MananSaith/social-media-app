import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_app/controllers/utilsController/loader_controller.dart';
import 'package:social_media_app/screens/Navigator/HomeScreens/home_Screen.dart';
class LoginController extends GetxController{
  final LoaderController loader= Get.put(LoaderController());
    final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final FirebaseAuth  auth=FirebaseAuth.instance;

   Future firebaseLoginWithEmailPassword() async{
    loader.loaderFunction();
    try{
      await auth.signInWithEmailAndPassword(email: email.text, password: password.text).then((c){
       loader.loaderFunction();
       Get.snackbar("WelCome Bake", "you are successfully login");
       Get.off(HomeScreen());
      });
    }
    catch(e){
    Get.snackbar("Error", "$e");
    loader.loaderFunction();
    }
  }
}