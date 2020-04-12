import 'package:debttracker/model/debt.dart';
import 'package:debttracker/page/main/debtor-page.dart';
import 'package:flutter/material.dart';
import 'package:debttracker/shared/constant.dart';
import 'package:intl/intl.dart';

class DueTodayTile extends StatelessWidget {

  final Debt debt;
  DueTodayTile({this.debt});

  @override
  Widget build(BuildContext context) {
    var date = new DateFormat("MMM d, yyyy").format(debt.date);
    final cur = new NumberFormat.simpleCurrency(name: 'PHP');

    return Card(
        child: Column(
          children: <Widget>[
            // * display name of debtor
            new ListTile(
              leading: Text(debt.name,
                    style: dashboardListLeading),
            
            // * display debt information
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(date.toString(),
                    style: dashboardListSubtitle,
                    textAlign: TextAlign.end),
                  Text(cur.format(debt.installment),
                    style: dashboardListSubtitle,
                    textAlign: TextAlign.end),
                  Text(debt.desc,
                    style: dashboardListSubtitle,
                    textAlign: TextAlign.end),
              ]),
            onTap: () async {

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DebtorDetails(),
                    settings: RouteSettings(
                      arguments: debt.debtorId, // ? pass debtor id from debt table
                    )),
              );
              
          },
        )],
      )
    );
  }
}