import 'package:debttracker/shared/constant.dart';
import 'package:flutter/material.dart';

Widget pending (BuildContext context) {
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

              // * header
              Container(
                height: 50.0,
                child: Text(
                  'Pending',
                  style: dashboardCardHeader,
                ),
              ),

              SizedBox(height: 20.0),

              // * data
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 50.0,
                    child: Icon(Icons.money_off, size: 50.0, color: Colors.white),
                  ),
                  Container(
                    height: 50.0,
                    child: Text(
                      '23',
                      style: dashboardCardValue,
                    ),
                  )
                ],
              )
            ],
          )),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      color: new Color(0xffff847c),
    ),
  );
}