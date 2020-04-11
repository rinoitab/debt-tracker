import 'package:debttracker/model/debt.dart';
import 'package:debttracker/page/main/debtor-detail-page.dart';
import 'package:flutter/material.dart';
import 'package:debttracker/shared/constant.dart';
import 'package:intl/intl.dart';

class DueTodayTile extends StatelessWidget {

  final Debt debt;
  DueTodayTile({this.debt});

  @override
  Widget build(BuildContext context) {
    DateTime date = debt.date.toDate();
    var formattedDate = new DateFormat("MMM d, yyyy").format(date);
    final cur = new NumberFormat.simpleCurrency(name: 'PHP');

    return Card(
        child: Column(
          children: <Widget>[
            // * display name of debtor
            new ListTile(
              leading: Text(debt.debtor,
                    style: dashboardListLeading),
            
            // * display debt information
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(formattedDate.toString(),
                    style: dashboardListSubtitle,
                    textAlign: TextAlign.end),
                  Text(cur.format(debt.amount),
                    style: dashboardListSubtitle,
                    textAlign: TextAlign.end),
                  Text(debt.desc,
                    style: dashboardListSubtitle,
                    textAlign: TextAlign.end),
              ]),
            onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DebtorDetails(),
                  settings: RouteSettings(
                    arguments: debt.debtor, // ! pass debtor id from debt table
                  )),
            );
          },
        )],
      )
    );
  }
}