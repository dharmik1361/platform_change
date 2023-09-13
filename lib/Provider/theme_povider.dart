
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  bool Platform = false;
  bool Dark = false;
  bool Profile = false;

  void ThemeChange(){
    Dark = !Dark;
    notifyListeners();
  }
  void ChangeProfile(){
    Profile = !Profile;
    notifyListeners();
  }

  void ChangePlatform(){
    Platform = ! Platform;
    notifyListeners();
  }
}