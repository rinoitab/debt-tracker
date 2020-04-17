// todo: bottom sheet widget with debt details
import 'package:debttracker/ui/form/debt/add-debt.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DebtDetail extends StatefulWidget {
  @override
  _DebtDetailState createState() => _DebtDetailState();
}

class _DebtDetailState extends State<DebtDetail> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff99b898),
        elevation: 0,
        title: Text('Debt Detail'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddDebt()
                  ));
              },
            ),
          )
        ]
      ),
      body: Stack(
      children: <Widget>[
        Container(
          width: width,
          height: height * 0.3,
          decoration: BoxDecoration(
            color: Color(0xff99b898),
            borderRadius:
                BorderRadius.only(bottomLeft: Radius.circular(240.0)))),
      ])
    );
  }
}