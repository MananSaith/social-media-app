import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import 'ChatScreenList.dart';
class Chatlogin extends StatefulWidget {
  Chatlogin({Key? key}) : super(key: key);

  @override
  _ChatloginState createState() => _ChatloginState();
}

class _ChatloginState extends State<Chatlogin> {
  final TextEditingController user =TextEditingController();
  final TextEditingController id =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: user,
      
          ),
          SizedBox(height: 20,),
          TextField(
            controller: id,
      
          ),
          ElevatedButton(
            onPressed: ()async{
          await  ZIMKit().connectUser(id: id.text, name: user.text);
          Get.to(()=>Chatscreenlist());
          }, child: Text("create"))
        ],
      ),
    );
  }
}