import 'package:debttracker/shared/constant.dart';
import 'package:flutter/material.dart';

Widget completed (BuildContext context) {
  double width = (MediaQuery.of(context).size.width / 2) - 30;
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
                  'Completed',
                  style: dashboardCardHeader,
                  ),
                ),

              SizedBox(height: 20.0),

              // Data
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 50.0,
                    child: Icon(Icons.done, size: 50.0, color: Colors.white),
                  ),
                  Container(
                    height: 50.0,
                    child: Text(
                      '43',
                      style: dashboardCardValue,
                    ),
                  )
                ],
              )
            ],
          )),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      color: new Color(0xfffeceab),
    ),
  );
}