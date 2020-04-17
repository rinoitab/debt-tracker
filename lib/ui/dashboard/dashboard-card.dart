import 'package:debttracker/data/access-payable.dart';
import 'package:debttracker/model/payables/payables-viewmodel.dart';
import 'package:debttracker/ui/list/completed.dart';
import 'package:debttracker/ui/list/due-today.dart';
import 'package:debttracker/ui/list/monthly-earnings.dart';
import 'package:debttracker/ui/list/overdue.dart';
import 'package:debttracker/ui/list/pending.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:intl/intl.dart';

// todo: should show debt with payables due today
Widget dueToday(BuildContext context) {
  double width = (MediaQuery.of(context).size.width / 2) - 30;
  double height = (MediaQuery.of(context).size.height / 4) - 60;

  return Container(
    height: height,
    width: width,
    child: GestureDetector(
      onTap: () async {
          PayablesList payable = await loadPayable();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DueToday(payable: payable)
            ));
        },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
        color: new Color(0xff99b898),
        child: dashboardCard(context, 'Due Today', '23', Icons.perm_identity)
      ),
    )
  );
}

// todo: should show count of debt with overdue payables
Widget overdue(BuildContext context) {
  double width = (MediaQuery.of(context).size.width / 2) - 30;
  double height = (MediaQuery.of(context).size.height / 4) - 60;

  return Container(
    height: height,
    width: width,
    child: GestureDetector(
      onTap: () async {
          PayablesList payable = await loadPayable();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Overdue(payable: payable)
            ));
        },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
        color: new Color(0xffe84a5f),
        child: dashboardCard(context, 'Overdue', '12', Icons.report)
      ),
    )
  );
}

// todo: show count of debts where isCompleted == false
Widget pending(BuildContext context) {
  double width = (MediaQuery.of(context).size.width / 2) - 30;
  double height = (MediaQuery.of(context).size.height / 4) - 60;

  return Container(
    height: height,
    width: width,
    child: GestureDetector(
      onTap: () async {
          PayablesList payable = await loadPayable();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Pending(payable: payable)
            ));
        },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
        color: new Color(0xffff847c),
        child: dashboardCard(context, 'Pending', '23', Icons.money_off)
      ),
    )
  );
}

// todo: show count of debt where isCompleted == true
Widget completed(BuildContext context) { 
  double width = (MediaQuery.of(context).size.width / 2) - 30;
  double height = (MediaQuery.of(context).size.height / 4) - 60;

  return Container(
    height: height,
    width: width,
    child: GestureDetector(
      onTap: () async {
          PayablesList payable = await loadPayable();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Completed(payable: payable)
            ));
        },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
        color: new Color(0xfffeceab),
        child: dashboardCard(context, 'Completed', '49', Icons.done)
      ),
    )
  );
}

// todo: should sum of payables marked as isPaid for the current month
Widget monthlyEarnings(BuildContext context) {
  double width = MediaQuery.of(context).size.width - 30;
  double height = (MediaQuery.of(context).size.height / 4) - 60;

  final cur = new NumberFormat.simpleCurrency(name: 'PHP');

  return Container(
    height: height,
    width: width,
    child: GestureDetector(
      onTap: () async {
          PayablesList payable = await loadPayable();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MonthlyEarnings(payable: payable)
            ));
        },
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
                    'Monthly Earnings',
                    style: TextStyle(
                      fontSize: 20.0, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.white)
                  ),
                ),

                SizedBox(height: 20.0),

                // * data
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: 50.0,
                      child: Text(
                        cur.format(58000.0).toString(),
                        style: TextStyle(
                          fontSize: 50.0, 
                          fontWeight: FontWeight.bold, 
                          color: Colors.white)
                      ),
                    )
                  ],
                )
              ],
            )),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
        color: new Color(0xff2a363b),
      ),
    ),
  );
}

// todo: get sum of payables marked as isPaid per month
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

              // * header
              Container(
                height: 50.0,
                child: Text(
                  'Yearly Earnings',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold, 
                    color: Colors.white),
                ),
              ),

              SizedBox(height: 5.0),

              // * return graph based on data list
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
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      color: new Color(0xff83af9b),
    ),
  );
}


// * Widget with the Dashboard Card style
Widget dashboardCard(BuildContext context, String header, String value, IconData icon) {
  return Padding(
    padding: EdgeInsets.all(15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        cardHeader(header),
        SizedBox(height: 20.0),
        cardValue(icon, value)

      ],
  ));
}

// * Widget for Dashboard Card Header
Widget cardHeader(String header) {
  return Container(
    height: 50.0,
    child: new Text(
    header,
    style: TextStyle(
      fontSize: 20.0, 
      fontWeight: FontWeight.bold, 
      color: Colors.white)
  ));
}

// * Widget for Dashboard Card Value
Widget cardValue(IconData icon, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Container(
        height: 50.0,
        child: Icon(icon,
        size: 50.0,
        color: Colors.white),
      ),
      Container(
        height: 50.0,
        child: Text(
          value,
          style: TextStyle(
            fontSize: 50.0, 
            fontWeight: FontWeight.bold, 
            color: Colors.white)
        ),
      ),
    ],
  );
}