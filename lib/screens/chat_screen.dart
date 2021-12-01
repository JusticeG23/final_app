import 'package:flutter/material.dart';

import '../widgets/AppDrawer.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = '/chats';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Direct Message'),
      ),
    );
  }
}
