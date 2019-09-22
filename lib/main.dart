import 'package:flutter/material.dart';
import 'package:testproject/pages/LandingPage.dart';
import 'package:testproject/pages/home.dart';
import 'package:testproject/pages/iconChange.dart';
import 'package:testproject/pages/infinitelist.dart';
import 'package:testproject/pages/settings.dart';
import 'package:testproject/utils/service_locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Josefin Sans',
        primarySwatch: Colors.blue,
      ),
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/home': (context) => Home(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => Settings(),
      },
      home: Scaffold(
        body: Landing(),
      ),
    );
  }
}
