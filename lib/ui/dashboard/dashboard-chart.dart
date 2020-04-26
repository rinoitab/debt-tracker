import 'package:flutter/material.dart';
import 'package:debttracker/shared/constant.dart' as constant;

class DashboardChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
        width: width * 0.47,
        height: height * 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: (height * 0.6) * 0.08),
            Text('Pending vs Completed', style: constant.header),
            SizedBox(height: (height * 0.6) * 0.02),
            // note: add pie chart here
            SizedBox(height: (height * 0.6) * 0.05),
            Text('Earnings Growth', style: constant.header),
            SizedBox(height: (height * 0.6) * 0.02),
            // note: add bar chart here
          ],
        ));
  }
}
