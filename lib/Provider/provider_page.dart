import 'package:flutter/material.dart';

import '../view/add_screen.dart';
import '../view/call_screen.dart';
import '../view/chat_screen.dart';
import '../view/setting_screen.dart';


class PageProvider extends ChangeNotifier {
  final List<Widget> _pages = [
    const AddEditScreen(),
    const ChatScreen(),
    const CallScreen(),
    const SettingScreen()
  ];
  int selectedIndex = 1;
  List<Widget> get pages => _pages;

  void selectedPage(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
