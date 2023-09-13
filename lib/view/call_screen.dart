import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/theme_povider.dart';
import '../widget/call_list.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context).Platform;
    if (provider) {
      return const CupertinoPageScaffold(child: CallList());
    } else {
      return const Scaffold(body: CallList());
    }
  }
}
