import 'package:flutter/material.dart';
import 'package:debttracker/ui/dashboard/dashboard.dart';

void main() => runApp(DebtTracker());

class DebtTracker extends StatelessWidget {

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