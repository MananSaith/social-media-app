import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_media_app/controllers/utilsController/custom_loader_controller.dart';
import 'package:social_media_app/controllers/utilsController/wrapper.dart';

class SignUpController extends GetxController {
  final CunstomLoaderController loader = Get.put(CunstomLoaderController());
  final TextEditingController userName = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Add required scopes for Google Sign-In (email, profile)
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

  RxBool isUsernameTaken = false.obs;
  User? currentUsers;
  final fireStoreUserInfo = FirebaseFirestore.instance.collection("users");

  Future<void> signInWithGoogle() async {
    loader.showLoader();

    try {
      // Opens the Google Sign-In screen where the user can choose their account
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        loader.hideLoader();
        // The user canceled the sign-in
        return;
      }

      // Fetch authentication tokens (access token and ID token) from the googleUser object.
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential using the Google authentication tokens
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credentials
      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      // Retrieve the signed-in user
      currentUsers = userCredential.user;

      if (currentUsers != null) {
        // Check if the UID already exists in Firestore
        bool check = await checkUIDExists(currentUsers!.uid);
        if (check) {
          // Show a snackbar if the user already exists
          Get.snackbar(
            'Welcome back',
            'You already have an account with this email.',
            snackPosition: SnackPosition.BOTTOM,
          );
        } else {
          // Add new user info to Firestore if they don't have an account
          await additionalUserInfo();
        }
      }

      // Navigate to the next page after successful sign-in
      loader.hideLoader();
      Get.off(Wrapper());
    } catch (error) {
      loader.hideLoader();
      Get.snackbar(
        'Sign In Error',
        'Failed to sign in with Google: $error',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Function to add additional user info into Firestore
  Future<void> additionalUserInfo() async {
    try {
      await fireStoreUserInfo.doc(currentUsers!.uid).set({
        "uid": currentUsers!.uid,
        "username": userName.text,
        "emaildisplayname": currentUsers!.displayName,
        "email": currentUsers!.email,
        "phonenumber": phone.text,
        "profilePhoto": currentUsers!.photoURL,
      });
    } catch (e) {
      print("Error storing user info: $e");
    }
  }

  // Function to check if the username already exists in Firestore
  Future<void> checkUsername() async {
    try {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: userName.text)
          .limit(1)
          .get();

      isUsernameTaken.value = result.docs.isNotEmpty;
    } catch (e) {
      print("Error checking username: $e");
    }
  }

  // Function to check if a UID already exists in Firestore
  Future<bool> checkUIDExists(String uid) async {
    try {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      return userDoc.exists;
    } catch (e) {
      print("Error checking UID: $e");
      return false;
    }
  }
}
