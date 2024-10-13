import 'package:flutter/material.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

import 'zegopopmenubutton.dart';
class Chatscreenlist extends StatelessWidget {
  const Chatscreenlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Conversations'),
          actions: [Zegopopmenubutton()],
        ),
        body: ZIMKitConversationListView(
          onPressed: (context, conversation, defaultAction) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return ZIMKitMessageListPage(
                  conversationID: conversation.id,
                  conversationType: conversation.type,
                );
              },
            ));
          },
        ),
      ),
    );
  }
}