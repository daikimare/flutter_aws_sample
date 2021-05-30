import 'package:flutter/material.dart';
import 'login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override 
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Gallery App',
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),

      home: Navigator(
        pages: [MaterialPage(child: LoginPage())],
        onPopPage: (route, result) => route.didPop(result),
      ),
    );
  }
}