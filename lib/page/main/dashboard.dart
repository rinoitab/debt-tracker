import 'package:debttracker/dashboard/card/completed.dart';
import 'package:debttracker/dashboard/card/due-today.dart';
import 'package:debttracker/dashboard/card/monthly-earnings.dart';
import 'package:debttracker/dashboard/card/overdue.dart';
import 'package:debttracker/dashboard/card/pending.dart';
import 'package:debttracker/dashboard/card/yearly-earnings.dart';
import 'package:debttracker/dashboard/searchbox.dart';
import 'package:debttracker/dashboard/floating-menu.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: new Container(
          padding: EdgeInsets.all(20.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Search Box
              searchBox(),

              // Cards
              Container(
                padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                child: Wrap(
                  children: <Widget>[
                    dueToday(context),
                    overdue(context),
                    monthlyEarnings(context),
                    yearlyEarnings(context),
                    pending(context),
                    completed(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 10.0, bottom: 15.0),
          child: floatingMenu(context),        
      ),
    );
  }
}
