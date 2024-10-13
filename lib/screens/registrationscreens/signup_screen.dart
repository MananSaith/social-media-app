import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constant/colorclass.dart';
import 'package:social_media_app/constant/font_weight.dart';
import 'package:social_media_app/constant/string_constant.dart';
import 'package:social_media_app/controllers/firebaseResigterController/Sign_up_controller.dart';
import 'package:social_media_app/controllers/utilsController/custom_loader_controller.dart';
import 'package:social_media_app/utalities/custom_loader.dart';
import 'package:social_media_app/wedgits/custum_button.dart';
import 'package:social_media_app/wedgits/inputdecorationwidget.dart';
import 'package:social_media_app/wedgits/textwidget.dart';
class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final SignUpController controller= Get.put(SignUpController());
    final CunstomLoaderController loadingController = Get.put(CunstomLoaderController());
   GlobalKey<FormState>  key=  GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
      final height =MediaQuery.of(context).size.height;
      final width =MediaQuery.of(context).size.width;
    return Scaffold(
      body: Obx((){
        return Stack(
        children:[ Form(
          key: key,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: ListView(
              children: [
                    Center(child: Image.asset(MyText.linzaSocialMediaLogo)),
        
                    TextFormField(
                      controller: controller.userName,
                      keyboardType: TextInputType.name,
                      autocorrect: true, // Enable autocorrect
                       enableSuggestions: true, // Allow suggestions
                       textInputAction: TextInputAction.next,
                      decoration: inputDecorationWidget(text: MyText.userName,bdcolor: MyColors.white,prefixIcon: Icon(Icons.person)),
                       validator: ValidationBuilder().minLength(6).maxLength(20).build(),
                      onChanged: (value){
                        controller.userName.text =value;
                        controller.checkUsername();
                      },
                    ),
        
                    SizedBox(height: height*0.010),
        
                    Obx((){
                         return  controller.isUsernameTaken.value ? 
                         TextWidget(text: MyText.alreadyUser, fSize: 15,fWeight: MyFontWeight.small,textColor: MyColors.red,):
                          TextWidget(text: MyText.avalibleyUser, fSize: 15,fWeight: MyFontWeight.small,textColor: MyColors.green,);
                    }),
        
                    SizedBox(height: height*0.025),
        
                     TextFormField(
                      controller: controller.phone,
                      keyboardType: TextInputType.phone, 
                      decoration: inputDecorationWidget(text: MyText.phone,bdcolor: MyColors.white,prefixIcon: Icon(Icons.phone)),
                       validator: ValidationBuilder().minLength(1).maxLength(13).build(),
                    ),
                   SizedBox(height: height*0.025),
                   
        
                      CustomElevatedButton(
                      width: width,
                      backgroundColor: MyColors.secondaryPallet,
                      textColor: MyColors.black,
                      startIcon: Icon(Icons.flash_on,color: MyColors.camel,size: 30,),
                      text: MyText.signUp,
                      fontSize: 20,
                     onPressed:(){
                         if(!controller.isUsernameTaken.value){
                         
                          if(key.currentState?.validate()??false ){
                         
                           controller.signInWithGoogle();
                        }
                        }
                        
                      },
                    ),
                  
                  SizedBox(height: height*0.01,),
                  TextWidget(text: MyText.note, fSize: 12)
          
                    
                    
        
              ],
        
            ),
            )
            ),
            if (loadingController.isLoading.value)
              LoaderOverlay(), 
  ]
      )
   ;
      }) 
       );
 
  }
}