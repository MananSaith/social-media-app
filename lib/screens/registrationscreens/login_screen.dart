import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:social_media_app/constant/colorclass.dart';
import 'package:social_media_app/constant/string_constant.dart';
import 'package:social_media_app/controllers/firebaseResigterController/login_controller.dart';
import 'package:social_media_app/controllers/utilsController/loader_controller.dart';
import 'package:social_media_app/screens/registrationscreens/signup_screen.dart';
import 'package:social_media_app/wedgits/custum_button.dart';
import 'package:social_media_app/wedgits/inputdecorationwidget.dart';
class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
final LoginController controller= Get.put(LoginController());
final LoaderController loader= Get.put(LoaderController());
  GlobalKey<FormState>  key=  GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height =MediaQuery.of(context).size.height;
      final width =MediaQuery.of(context).size.width;
    return Scaffold(
      body: Form(
        key: key,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
                
              children: [
                    SizedBox(height: height*0.035),
          
                    Center(child: Image.asset(MyText.linzaSocialMediaLogo)),
          
                    TextFormField(
                      controller: controller.email,
                      keyboardType: TextInputType.emailAddress,
                       autocorrect: true, // Enable autocorrect
                       enableSuggestions: true, // Allow suggestions
                       textInputAction: TextInputAction.next,
                      decoration: inputDecorationWidget(text: MyText.email,bdcolor: MyColors.white,prefixIcon: Icon(Icons.email)),
                       validator: ValidationBuilder().email().maxLength(25).build(),
                    ),
          
                    SizedBox(height: height*0.025),
          
                     TextFormField(
                      controller: controller.password, 
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: inputDecorationWidget(text: MyText.password,bdcolor: MyColors.white,prefixIcon: Icon(Icons.password)),
                       validator: ValidationBuilder().minLength(6).maxLength(25).build(),
                    ),
          
                    SizedBox(height: height*0.025),
          
                    Obx((){
                        return CustomElevatedButton(
                      width: width,
                      backgroundColor: MyColors.secondaryPallet,
                      textColor: MyColors.black,
                      startIcon: Icon(Icons.login,color: MyColors.black,),
                      text: MyText.login,
                      isLoading:loader.loader.value,
                     onPressed:(){
                        if(key.currentState?.validate()??false){
                           controller.firebaseLoginWithEmailPassword();
                        }
                      }, 
                    );
                    }
                    ),
          
                    SizedBox(height: height*0.055),
          
                    CustomElevatedButton(
                      width: width,
                      backgroundColor: MyColors.secondaryPallet,
                      textColor: MyColors.black,
                      startIcon: Image.asset("assets/icons/googleIcon.png",height: height*0.045,),
                      text: MyText.continoueWithGoogle,
                      fontSize: 20,
                      isLoading:loader.loader.value,
                     onPressed:(){
                        Get.to(SignupScreen());
                      },
                    ),
                
              ],
                
            ),
            ),
        )
          ),
    );
  }
}