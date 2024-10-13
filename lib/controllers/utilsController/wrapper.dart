
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/screens/Navigator/navigator_screen.dart';
import 'package:social_media_app/screens/registrationscreens/login_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot){
            
              if(snapshot.hasData){
               return  NavigatorPage();
             }
             else{
               return  LoginScreen();
             }
             
        },
      ),
    );
  }
}