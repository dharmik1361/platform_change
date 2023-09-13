import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_change/widget/switch.dart';
import 'package:provider/provider.dart';

import '../Provider/theme_povider.dart';

class TopBar extends StatelessWidget implements PreferredSize {
  const TopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context).Platform;
    print(provider);
    return provider
        ? const CupertinoNavigationBar(
      middle: Text('Platform Converter'),
      trailing: PlatformSwitch(),
    )
        : AppBar(
      title: const Text('Platform Converter'),
      actions: const [PlatformSwitch()],
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();
}
