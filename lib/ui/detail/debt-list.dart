import 'package:debttracker/ui/detail/debt.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

Widget debtList(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      width: width,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        ),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.red[400],
                child: Icon(Icons.report_problem,
                  color: Colors.white),
              ),
              title: Container(
                width: width * 0.5,
                child: new Text('Incidunt consequuntur labore Minima et accusantium et ',
                  overflow: TextOverflow.visible,
                  maxLines: 2,
                  style: new TextStyle(
                      color: Colors.black87, fontSize: 18.0, fontWeight: FontWeight.bold)),
              ),
              subtitle: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text('Jan 5, 2010',
                      style: new TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.end),
                    SizedBox(height: 5),
                    new LinearPercentIndicator(
                      percent: 0.8,
                      width: width * 0.6,
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      linearGradient: LinearGradient(
                        colors: [Colors.red[500], Colors.red[200]]),
                      backgroundColor: Colors.grey[200],
                    )
                  ]),
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => DebtDetail()
                  ));
              },
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green[400],
                child: Icon(Icons.done,
                  color: Colors.white),
              ),
              title: Container(
                width: width * 0.5,
                child: new Text('Incidunt consequuntur labore Minima et accusantium et ',
                  overflow: TextOverflow.visible,
                  maxLines: 2,
                  style: new TextStyle(
                      color: Colors.black87, fontSize: 18.0, fontWeight: FontWeight.bold)),
              ),
              subtitle: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text('Apr 15, 2020',
                      style: new TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.end),
                    SizedBox(height: 5),
                    new LinearPercentIndicator(
                      percent: 1,
                      width: width * 0.6,
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      linearGradient: LinearGradient(
                        colors: [Colors.green[400], Colors.green[200]]),
                      backgroundColor: Colors.grey[200],
                    )
                  ]),
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => DebtDetail()
                  ));
              }
            ),
          ],
        ),
      )
    );
}