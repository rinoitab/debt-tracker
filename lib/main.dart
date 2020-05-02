import 'package:flutter/material.dart';
import 'package:debttracker/ui/dashboard/dashboard.dart';
import 'package:flutter/services.dart';

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
    );
  }
}