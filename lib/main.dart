import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:social_media_app/constant/colorclass.dart';
import 'package:social_media_app/constant/string_constant.dart';
import 'package:social_media_app/controllers/utilsController/wrapper.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

void main() async{

 await ZIMKit().init(
    appID:1355478878, // your appid
    appSign: "4d86cb1cd158bf3698fdd676410db785cb530e1821a248bc12aab00cfae73e5d", // your appSign
  );
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
       options:const FirebaseOptions(
            apiKey:"AIzaSyAjUtt74eABuKq8pn1qmeiUQwzby9wBL1s",
            appId: "1:317827878730:android:ac7ec15fa68670fd2fbbb3",
            messagingSenderId:"317827878730",
            projectId:"linza-social-app",
         storageBucket: "linza-social-app.appspot.com"
        )
     );

  } catch (e) {
    // ignore: avoid_print
    print("Error initializing Firebase: $e");
  }
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      
      title: MyText.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: MyColors.bgPallet,
        colorScheme: ColorScheme.fromSeed(seedColor: MyColors.primaryPallet),
        useMaterial3: true,
      ),
      home:  Wrapper(),
    );
  }
}
