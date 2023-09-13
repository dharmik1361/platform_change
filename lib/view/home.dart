import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/provider_page.dart';
import '../Provider/theme_povider.dart';
import '../widget/switch.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context).Platform;
    if (provider) {
      return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Platform Converter'),
          trailing: PlatformSwitch(),
        ),
        child: Consumer<PageProvider>(
            builder: (context, value, child) {
              return CupertinoTabScaffold(
                tabBar: CupertinoTabBar(
                    onTap: (index) => value.selectedPage(index),
                    currentIndex: value.selectedIndex,
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(CupertinoIcons.person_add)),
                      BottomNavigationBarItem(
                          icon: Icon(CupertinoIcons.chat_bubble_2),
                          label: 'Chat'),
                      BottomNavigationBarItem(
                          icon: Icon(CupertinoIcons.phone), label: 'Call'),
                      BottomNavigationBarItem(
                          icon: Icon(CupertinoIcons.settings),
                          label: 'Setting'),
                    ]
                ),
                tabBuilder: (context, index) {
                  return value.pages[index];
                  // return _pages[_selectedIndex];
                },
              );
            }
        ),
      );
    } else {
      return Consumer<PageProvider>(
          builder: (context, value, child) {
            return DefaultTabController(
              length: value.pages.length,
              initialIndex: value.selectedIndex,
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('Platform Converter'),
                  actions: const [PlatformSwitch()],
                  bottom: TabBar(
                      isScrollable: true,
                      onTap: (index) => value.selectedPage(index),
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: const [
                        Tab(icon: Icon(Icons.person_add_alt)),
                        Tab(text: 'CHATS'),
                        Tab(text: 'CALLS'),
                        Tab(text: 'SETTINGS')
                      ]),
                ),
                body: TabBarView(children: value.pages),
              ),
            );
          }
      );
    }
  }
}
