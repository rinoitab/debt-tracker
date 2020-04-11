import 'package:debttracker/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

Widget yearlyEarnings(BuildContext context) {
  var amount = [
    0.0,
    12890.0,
    32190.0,
    29013.0,
    0.0,
    18200.0,
    8070.0,
    40980.0,
    50900.0,
    39000.0,
    41000.0,
    78000.0
  ];

  double width = MediaQuery.of(context).size.width - 30;
  double height = (MediaQuery.of(context).size.height / 4) - 60;
 
  return Container(
    height: height,
    width: width,
    child: Card(
      child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Header
              Container(
                height: 50.0,
                child: Text(
                  'Yearly Earnings',
                  style: dashboardCardHeader,
                ),
              ),

              SizedBox(height: 5.0),

              // Data
              Row(children: <Widget>[
                Container(
                  height: 50.0,
                  width: width - 80,
                  child: Sparkline(
                    data: amount,
                    lineColor: Colors.white,
                    pointsMode: PointsMode.all,
                    pointSize: 10.0,
                    pointColor: Colors.white,
                  ),
                ),
              ]),
            ],
          )),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      color: new Color(0xff83af9b),
    ),
  );
}
