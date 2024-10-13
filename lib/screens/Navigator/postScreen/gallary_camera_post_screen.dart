import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constant/colorclass.dart';
import 'package:social_media_app/constant/font_weight.dart';
import 'package:social_media_app/constant/string_constant.dart';
import 'package:social_media_app/controllers/postController/gallary_camera_picker_controller.dart';
import 'package:social_media_app/controllers/postController/image_post_controller.dart';
import 'package:social_media_app/screens/Navigator/postScreen/text_post_screen.dart';
import 'package:social_media_app/utalities/custom_loader.dart';
import 'package:social_media_app/wedgits/inputdecorationwidget.dart';
import 'package:social_media_app/wedgits/rich_text_widget.dart';
import 'package:social_media_app/wedgits/textwidget.dart';

class GallaryCameraPostScreen extends StatefulWidget {
  GallaryCameraPostScreen({super.key});

  @override
  _GallaryCameraPostScreenState createState() => _GallaryCameraPostScreenState();
}

class _GallaryCameraPostScreenState extends State<GallaryCameraPostScreen> {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final UploadImagePostController storagePostController = Get.put(UploadImagePostController());
  final ImagePickerController controllerPicker = Get.put(ImagePickerController());
  final RxBool isLoading = false.obs; // Observable to manage loading state

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: MyColors.scaffoldBack,
      appBar: AppBar(
        backgroundColor: MyColors.primaryPallet,
        title: TextWidget(
          text: MyText.post,
          fSize: 20,
          fWeight: MyFontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Obx(
        () => Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Form(
                key: key,
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            controllerPicker.cameraImage();
                          },
                          icon: Icon(Icons.camera_alt),
                          iconSize: 30,
                        ),
                        SizedBox(width: width * 0.02),
                        IconButton(
                          onPressed: () {
                            controllerPicker.galleryImage();
                          },
                          icon: Icon(Icons.photo),
                          iconSize: 30,
                        ),
                        SizedBox(width: width * 0.02),
                        IconButton(
                          onPressed: () async {
                            if (key.currentState?.validate() ?? false) {
                              if (controllerPicker.image.value != null) {
                                isLoading.value = true; // Show loader
                                await storagePostController.UploadPostFireStorage();
                                isLoading.value = false; // Hide loader
                                Get.off(()=>TextPostScreen());
                              } else {
                                Get.defaultDialog(
                                  confirm: TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: TextWidget(
                                      text: "Ok",
                                      fSize: 20,
                                      textColor: MyColors.blue,
                                    ),
                                  ),
                                  middleText: "Select image from gallery or capture the image",
                                );
                              }
                            }
                          },
                          icon: Icon(Icons.send_rounded),
                          iconSize: 30,
                          color: MyColors.camel,
                        ),
                      ],
                    ),
                    TextFormField(
                      controller: storagePostController.caption,
                      keyboardType: TextInputType.multiline,
                      autocorrect: true, // Enable autocorrect
                       enableSuggestions: true, // Allow suggestions
                       textInputAction: TextInputAction.next,
                      decoration: inputDecorationWidget(text: MyText.caption),
                      maxLines: 3,
                      maxLength: 70,
                      validator: ValidationBuilder().minLength(10).maxLength(70).build(),
                    ),
                    AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Obx(() {
                          return controllerPicker.image.value != null
                              ? Image.file(
                                  controllerPicker.image.value!,
                                  fit: BoxFit.cover,
                                )
                              : Icon(
                                  Icons.photo,
                                  size: 50,
                                  color: MyColors.divider,
                                );
                        }),
                      ),
                    ),
                    SizedBox(height: height * 0.025),
                    RichTextWidget(
                      fSize: 16.0,
                      textSpans: [
                        TextSpan(
                          text: "Note: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: MyColors.red,
                          ),
                        ),
                        TextSpan(
                          text: MyText.notePost,
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Color.fromARGB(255, 33, 150, 243),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Show the loader overlay when isLoading is true
            if (isLoading.value)
              LoaderOverlay(), // Semi-transparent loader overlay
          ],
        ),
      ),
    );
  }
}
