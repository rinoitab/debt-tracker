import 'package:debttracker/screen/dashboard.dart';
import 'package:flutter/material.dart';

void main() => runApp(Root());

class Root extends StatelessWidget {
  String date = DateTime.now().toString();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Dashboard(),

      theme: ThemeData(
        primaryColor: Color(0xff99b898),
        primaryTextTheme: TextTheme(
          title: TextStyle(color: Colors.white)),
        primaryIconTheme: const IconThemeData.fallback().copyWith(
          color: Colors.white
        ),
      ),
    );
  }
}