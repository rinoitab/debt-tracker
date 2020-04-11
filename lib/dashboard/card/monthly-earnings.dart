import 'package:debttracker/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget monthlyEarnings (BuildContext context) {
  double width = MediaQuery.of(context).size.width - 30;
  double height = (MediaQuery.of(context).size.height / 4) - 60;

  double amount = 58000.0;
  final cur = new NumberFormat.simpleCurrency(name: 'PHP');

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
                  'Monthly Earnings',
                  style: dashboardCardHeader,
                ),
              ),

              SizedBox(height: 20.0),

              // Data
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: 50.0,
                    child: Text(
                      cur.format(amount).toString(),
                      style: dashboardCardValue
                    ),
                  )
                ],
              )
            ],
          )),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      color: new Color(0xff2a363b),
    ),
  );
}