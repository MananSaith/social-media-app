import 'dart:io';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerController extends GetxController{

// Declare a reactive variable of type File? (nullable File) using GetX's Rx type
Rx<File?> image = Rx<File?>(null);

// Alternatively, if you wanted to use a String for the image path (commented out version)
// RxString image = ''.obs;

// Create an instance of ImagePicker to access the device's camera or gallery
final picker = ImagePicker();

// Variable to hold the selected file (XFile) from the image picker
XFile? pickFile;

  // Function to capture an image from the camera
Future cameraImage() async {
  try {
    // Try to pick an image using the camera with image quality set to 90
    final pickFile = await picker.pickImage(source: ImageSource.camera, imageQuality: 90);
    
    // If an image is picked (not null), assign the selected file to the reactive image variable
    if (pickFile != null) {
      image.value = File(pickFile.path);  // Convert XFile to File and set it to image
    }
  } catch (e) {
    // If an error occurs, display a snackbar with the error message
    Get.snackbar('Error', 'Issue to take image from camera', snackPosition: SnackPosition.TOP);
  }
}

  Future galleryImage() async{
    try{
      pickFile = await picker.pickImage(source: ImageSource.gallery,imageQuality: 90);
      if(pickFile!=null){
        image.value=File(pickFile!.path);
      }
    }catch(e){
      Get.snackbar('Error', 'issue to take image from gallery', snackPosition: SnackPosition.TOP);
    }

  }



}