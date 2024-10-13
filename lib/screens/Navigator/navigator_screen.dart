import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:social_media_app/constant/colorclass.dart';
import 'package:social_media_app/screens/Navigator/HomeScreens/home_Screen.dart';
import 'package:social_media_app/screens/Navigator/postScreen/text_post_screen.dart';
import 'chatScreenZegoCloud/chatlogin.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  List<Widget> listOfPages = [HomeScreen(), TextPostScreen(), Chatlogin()];
  int currentPage = 0;

 @override
Widget build(BuildContext context) {
  return Scaffold(
    resizeToAvoidBottomInset: true, // Allow resizing when keyboard appears

    body: IndexedStack(
      index: currentPage,
      children: listOfPages,
    ),

    bottomNavigationBar: CurvedNavigationBar(
      onTap: (v) {
        setState(() {
          currentPage = v;
        });
      },
      backgroundColor: MyColors.thirdPallet,
      color: MyColors.bgPallet,
      animationCurve: Curves.easeIn,
      height: 55,
      items: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home, size: 30),
            Text('Home', style: TextStyle(fontSize: 10)),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.post_add, size: 30),
            Text('Post', style: TextStyle(fontSize: 10)),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat, size: 30),
            Text('Chat', style: TextStyle(fontSize: 10)),
          ],
        ),
      ],
    ),
  );
}

}
