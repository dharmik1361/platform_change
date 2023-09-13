import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/theme_povider.dart';
import '../widget/chat_list.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context).Platform;
    if (provider) {
      return const CupertinoPageScaffold(child: ChatList());
    } else {
      return const Scaffold(body: ChatList());
    }
  }
}
