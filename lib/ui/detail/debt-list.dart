import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

Widget debtList(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final cur = new NumberFormat.simpleCurrency(name: 'PHP');

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      width: width,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        ),
        child: ExpansionTile(
          leading: CircleAvatar(
            backgroundColor: Color(0xffe84a5f),
            radius: 25,
            child: Icon(Icons.warning,
              color: Colors.white,),
          ),
          title: Text('Macbook Pro 2017 256gb',
            style: TextStyle(
              fontWeight: FontWeight.bold
            )),
          subtitle: Text('Jan 5, 2020'),
          trailing: CircularPercentIndicator(
            radius: 50,
            percent: 0.6,
            circularStrokeCap: CircularStrokeCap.round,
            backgroundColor: Colors.grey[200],
            progressColor: Color(0xffe84a5f),
            animation: true,
            animationDuration: 3000,
            center: Text('60%'),),
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 10),
              width: width,
              child: Row(
                children: <Widget>[
                  Container(
                    width: width * 0.35,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text('Amount',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                        Text('Installment',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                        Text('Balance',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                        Text('Last Payment',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14))
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: width * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(cur.format(50000).toString(),
                          style: TextStyle(
                            fontSize: 14)),
                        Text(cur.format(5000).toString() + ' for 6 MO',
                          style: TextStyle(
                            fontSize: 14)),
                        Text(cur.format(34000).toString() + ' / ' + cur.format(64000).toString(),
                          style: TextStyle(
                            fontSize: 14)),
                        Text('Mar 15, 2020',
                          style: TextStyle(
                            fontSize: 14))
                      ],
                    ),
                  ),
                ], 
              ),
            ),
            Text('Details',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Color(0xffe84a5f)
              )),
            SizedBox(height: 20)
          ],
        )
      )
    );
}