import 'package:flutter/material.dart';
import 'package:hodos/themes/app_theme.dart';
import 'package:hodos/views/screens/login.dart';
import 'package:hodos/views/screens/detail_route.dart';
import 'package:hodos/views/screens/search_route_page.dart';
import 'package:hodos/views/screens/user_page.dart';
//import 'package:hodos/views/screens/inscription_page.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());

  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.white, // status bar color
  // ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // home: LoginScreen(),
        // TO DO ROUTAGE comment by Jorge
        home: const LoginScreen(),
        // home: const SearchRoutePage(),
        debugShowCheckedModeBanner: false,
        theme: Apptheme.lighTheme);
  }
}
