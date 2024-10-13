import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:social_media_app/wedgits/snackbar_custom.dart';

class GetAllDataController extends GetxController {
  final currentUserUid = FirebaseAuth.instance.currentUser!.uid;
  
  // Use RxMap to store the current user data
  RxMap<String, dynamic> currentUserData = <String, dynamic>{}.obs;
  RxInt totalFollowers = 0.obs;
  RxInt totalFollowing = 0.obs;
   RxInt totalPost = 0.obs;

  // Create an RxList to store the following data
  RxList<Map<String, dynamic>> followingList = <Map<String, dynamic>>[].obs;
  // Create an RxList to store the followers data
  RxList<Map<String, dynamic>> followersList = <Map<String, dynamic>>[].obs;
   // Create an RxList to store the post data
  RxList<Map<String, dynamic>> postList = <Map<String, dynamic>>[].obs;

  void getData()  {
      currentUserDataFunction();
      currentUserPostFunction();
  }


  void currentUserDataFunction() async {
    try {
      // Fetch current user data
      final querySnapshotCurrent = await FirebaseFirestore.instance
          .collection("users")
          .where("uid", isEqualTo: currentUserUid)
          .get();
          
      final DocumentSnapshot documentSnapshotCurrent = querySnapshotCurrent.docs.first;
       // Clear the currentUserData RxMap first
      currentUserData.clear();

      // Assign the fetched data to the observable RxMap
      currentUserData.value = documentSnapshotCurrent.data() as Map<String, dynamic>;
    } catch (e) {
      showCustomSnackBar(
        title: "Error",
        message: "$e",
      );
    }
  }

  void currentUserPostFunction() async {
    try {
      // Query to fetch posts where the UID matches the current user's UID
      final querySnapshotPost = await FirebaseFirestore.instance
          .collection("post")
          .where("uid", isEqualTo: currentUserUid)
          .get();
      totalPost.value = querySnapshotPost.docs.length;
    } catch (e) {
      // Show error message in case of failure
      showCustomSnackBar(
        title: "Error",
        message: "$e",
      );
    }
  }

}
