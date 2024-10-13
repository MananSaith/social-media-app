import 'package:flutter/material.dart';
import 'package:social_media_app/wedgits/textwidget.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
class Zegopopmenubutton extends StatefulWidget {
  Zegopopmenubutton({Key? key}) : super(key: key);

  @override
  _ZegopopmenubuttonState createState() => _ZegopopmenubuttonState();
}

class _ZegopopmenubuttonState extends State<Zegopopmenubutton> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15)
        )
      ),
      position: PopupMenuPosition.under,
      icon: Icon(Icons.add),
      itemBuilder: (BuildContext  context){

        return [
           PopupMenuItem(

            child: ListTile(
              onTap: () => ZIMKit().showDefaultNewPeerChatDialog(context),
              leading: Icon(Icons.person),
              title: TextWidget(text: "New Chat", fSize: 15,maxLine: 1,),
            )
            
            ),
            PopupMenuItem(

            child: ListTile(
              onTap: () => ZIMKit().showDefaultNewGroupChatDialog(context),
              leading: Icon(Icons.group_add_outlined),
              title: TextWidget(text: "New Group", fSize: 15,maxLine: 1,),
            )
            
            ),
            PopupMenuItem(

            child: ListTile(
              onTap: () => ZIMKit().showDefaultJoinGroupDialog(context),
              leading: Icon(Icons.group_add),
              title: TextWidget(text: "Join Group", fSize: 15,maxLine: 1,),
            )
            
            )
        ];
      }
      );
  }
}