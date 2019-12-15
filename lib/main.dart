import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(dialogBackgroundColor: Colors.white),
      routes: {
        '/': (context) => LoadingScreen(),
        '/city': (context) => CityScreen()
      },
      initialRoute: '/',
    );
  }
}
