import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/theme_povider.dart';
import '../widget/profile.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, v, child) {
        if (v.Platform) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20, horizontal: 10),
                child: Column(children: [
                  CupertinoListTile(
                    leading: const Icon(CupertinoIcons.person),
                    title: const Text('Profile'),
                    subtitle: const Text('Update Profile Data'),
                    trailing: CupertinoSwitch(
                        value: v.Profile,
                        onChanged: (_) => v.ChangeProfile()),
                  ),
                  Profile(visible: v.Profile, platform: v.Platform),
                  const Divider(),
                  CupertinoListTile(
                    leading: const Icon(CupertinoIcons.sun_max),
                    title: const Text('Theme'),
                    subtitle: const Text('Change Theme'),
                    trailing: CupertinoSwitch(
                        value: v.Dark,
                        onChanged: (_) => v.ThemeChange()),
                  ),
                ]),
              ),
            ),
          );
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 20),
              child: Column(
                children: [
                  SwitchListTile.adaptive(
                      secondary: const Icon(Icons.person),
                      title: const Text('Profile'),
                      subtitle: const Text('Update Profile Data'),
                      value: v.Profile,
                      onChanged: (_) => v.ChangeProfile()),
                  Profile(visible: v.Profile, platform: v.Platform),
                  const Divider(),
                  SwitchListTile.adaptive(
                      secondary:
                      const Icon(Icons.light_mode_outlined),
                      title: const Text('Theme'),
                      subtitle: const Text('Change Theme'),
                      value: v.Dark,
                      onChanged: (_) => v.ThemeChange()),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
