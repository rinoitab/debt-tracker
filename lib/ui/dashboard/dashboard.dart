import 'package:debttracker/ui/dashboard/dashboard-earnings-card.dart';
import 'package:debttracker/ui/dashboard/dashboard-list.dart';
import 'package:debttracker/ui/dashboard/dashboard-menu.dart';
import 'package:debttracker/ui/form/debt/add-debt.dart';
import 'package:debttracker/ui/form/debtor/add-debtor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:debttracker/shared/constant.dart' as constant;


class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // * Card that will show current and previous earnings
              Expanded(
                flex: 4,
                child: DashboardEarningsCard()),
              Expanded(
                child: DashboardMenu()),
              Expanded(
                flex: 6,
                child: DashboardList()
              )
            ],
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        elevation: 1,
        backgroundColor: constant.pink,
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            label: 'Add borrower',
            elevation: 1,
            child: Icon(Icons.face),
            backgroundColor: constant.peach,
            onTap: () {
              showModalBottomSheet(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0))),
              context: context, 
              builder: (context) => 
                AddDebtor());
            }
          ),
          SpeedDialChild(
            label: 'Add debt',
            elevation: 1,
            child: Icon(Icons.shopping_cart),
            backgroundColor: constant.green,
            onTap: () {
              showModalBottomSheet(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0))),
              context: context, 
              builder: (context) => 
                AddDebt());
            }
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}