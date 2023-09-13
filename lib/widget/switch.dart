import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/theme_povider.dart';

class PlatformSwitch extends StatelessWidget {
  const PlatformSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, v, child) => v.Platform
          ? CupertinoSwitch(
          value: v.Platform,
          onChanged: (value) => v.ChangePlatform())
          : Switch(
          value: v.Platform,
          onChanged: (value) {
            v.ChangePlatform();
          }),
    );
  }
}
