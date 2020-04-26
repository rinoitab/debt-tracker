import 'package:flutter/material.dart';
import 'package:debttracker/ui/dashboard/dashboard.dart';
import 'package:flutter/services.dart';
import 'package:debttracker/shared/constant.dart' as constant;

void main() => runApp(DebtTracker());

class DebtTracker extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Dashboard(),

      theme: ThemeData(
        primaryColor: constant.green,
        primaryTextTheme: TextTheme(
          title: TextStyle(color: Colors.white)),
        primaryIconTheme: const IconThemeData.fallback().copyWith(
          color: Colors.white
        )
      ),
    );
  }
}