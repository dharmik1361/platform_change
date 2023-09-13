import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_change/Provider/image_provider.dart';
import 'package:platform_change/view/home.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Provider/contact_provider.dart';
import 'Provider/provider_page.dart';
import 'Provider/theme_povider.dart';

late SharedPreferences pref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  pref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ContactProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ImagePickerProvider(),
        )
      ],
      builder: (context, child) {
        final provider = Provider.of<ThemeProvider>(context);
        return Provider.of<ThemeProvider>(context).Platform
            ? CupertinoApp(
                debugShowCheckedModeBanner: false,
                theme: CupertinoThemeData(
                  brightness:
                      provider.Dark ? Brightness.dark : Brightness.light,
                ),
                home: const HomeScreen(),
              )
            : MaterialApp(
                title: 'Platform Converter',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  brightness:
                      provider.Dark ? Brightness.dark : Brightness.light,
                  useMaterial3: true,
                ),
                home: const HomeScreen(),
              );
      },
    );
  }
}
