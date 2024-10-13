import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:social_media_app/constant/colorclass.dart';
import 'package:social_media_app/constant/font_weight.dart';
import 'package:social_media_app/constant/string_constant.dart';
import 'package:social_media_app/controllers/utilsController/loader_controller.dart';
import 'package:social_media_app/controllers/postController/text_post_controller.dart';
import 'package:social_media_app/screens/Navigator/postScreen/gallary_camera_post_screen.dart';
import 'package:social_media_app/wedgits/custum_button.dart';
import 'package:social_media_app/wedgits/inputdecorationwidget.dart';
import 'package:social_media_app/wedgits/textwidget.dart';
class TextPostScreen extends StatefulWidget {
  TextPostScreen({Key? key}) : super(key: key);

  @override
  _TextPostScreenState createState() => _TextPostScreenState();
}

class _TextPostScreenState extends State<TextPostScreen> {
  final LoaderController loader= Get.put(LoaderController());
  final TextPostController controller= Get.put(TextPostController());
  GlobalKey<FormState>  key=  GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height =MediaQuery.of(context).size.height;
   // final width =MediaQuery.of(context).size.width;
    return  SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.scaffoldBack,
        body: Padding(
          padding: EdgeInsets.all(8),
          child: Form(
            key: key,
            child: ListView(
              children: [
                  SizedBox(height: height*0.025),
                  TextWidget(
                    text: MyText.newPost, 
                    fSize: 30,
                    fWeight: MyFontWeight.extra,
                    textColor: MyColors.primaryPallet,),
                    SizedBox(height: height*0.035),
                    Lottie.network(MyText.lottieNewPost),
                     TextFormField(
                      controller: controller.postText, 
                      keyboardType: TextInputType.multiline,
                      autocorrect: true, // Enable autocorrect
                       enableSuggestions: true, // Allow suggestions
                       textInputAction: TextInputAction.next,
                      
                      decoration: inputDecorationWidget(text: MyText.mind),
                      maxLines: 4,
                      maxLength: 200,
                       validator: ValidationBuilder().minLength(20).maxLength(200).build(),
                    ),
                    SizedBox(height: height*0.025),
                    Obx((){
                      return CustomElevatedButton(
                        backgroundColor: MyColors.thirdPallet,
                        text: MyText.post,
                        fontSize: 27,
                        startIcon: Icon(Icons.post_add,size: 30,color: MyColors.black,),
                        textColor: MyColors.black,
                        fontWeight: MyFontWeight.bold,
                        isLoading: loader.loader.value,
                        onPressed: (){
                        if(key.currentState?.validate()??false){
                           controller.postTextFun();
                        }
                      }, 
                        );
                    }),

                     SizedBox(height: height*0.025),
                    CustomElevatedButton(
                      text: MyText.gallary,
                      backgroundColor: MyColors.thirdPallet,
                      startIcon: Icon(Icons.photo,color: MyColors.camel,),
                      onPressed: (){
                        Get.to(()=>GallaryCameraPostScreen());
                      },
                      )
                      
                    
              ],
            ) 
          ),
          )
        ,
      ) 
    
    );
  }
}