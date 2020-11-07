library messages_screen;

import 'package:flutter/material.dart' hide Router;

import '../../packages/dash_chat/dash_chat.dart';
import '../../widgets/index.dart';

class MessagesScreen extends StatefulWidget {
  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    return PrimaryScaffold(
      body: DashChat(
        user: ChatUser(
          name: "Hien",
          uid: "001",
          avatar:
              "https://www.wrappixel.com/ampleadmin/assets/images/users/4.jpg",
        ),
        messages: [
          ChatMessage(
              text: 'Welcome', user: ChatUser(uid: '002', name: 'Cupid')),
          ChatMessage(
              text: 'Welcome', user: ChatUser(uid: '002', name: 'Cupid')),
          ChatMessage(
              text: 'Welcome', user: ChatUser(uid: '003', name: '2Cupid')),
          ChatMessage(
              text: 'Welcome', user: ChatUser(uid: '001', name: 'Cupid')),
          ChatMessage(
              text: 'Welcome2', user: ChatUser(uid: '001', name: 'Cupid')),
        ],
        onSend: (ChatMessage message) {},
      ),
    );
  }
}
