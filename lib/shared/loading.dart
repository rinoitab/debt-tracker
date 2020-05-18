import 'package:flutter/material.dart';
import 'package:debttracker/shared/constant.dart' as constant;

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(constant.green),
      ));
  }
}