// todo: Should show payable date > today's date AND isPaid == false

import 'package:debttracker/model/payables/payables-viewmodel.dart';
import 'package:debttracker/ui/detail/debtor.dart';
import 'package:debttracker/ui/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Overdue extends StatelessWidget {

  final PayablesList payable;
  Overdue({this.payable});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Overdue'),
          elevation: 0,),
        body: ListView.separated(
          separatorBuilder: (context, index) => Divider(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: payable.payable.length,
          itemBuilder: (context, index) {
            if (payable == null) {
              return Loading();
            } return overdueTile(context, index);
         },
        ),
    );
  }

  // todo: Connect to database
  // todo: Show debt with overdue payables
  Widget overdueTile(BuildContext context, int index) {
    // var date = new DateFormat("MMM d, yyyy").format(debt.date);
    double width = MediaQuery.of(context).size.width * 0.5;
    final cur = new NumberFormat.simpleCurrency(name: 'PHP');

    return ListTile(
      leading: Container(
        width: width,
        child: Text(payable.payable[index].debtorId,
        style: TextStyle(
          fontSize: 18.0, 
          fontWeight: FontWeight.bold)),
      ),
    
      // * Display debtor information
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(payable.payable[index].date,
            style: TextStyle(
              fontSize: 15.0, 
              fontWeight: FontWeight.normal),
            textAlign: TextAlign.end),
          Text(cur.format(payable.payable[index].amount),
            style: TextStyle(
              fontSize: 15.0, 
              fontWeight: FontWeight.normal),
            textAlign: TextAlign.end),
          // todo: Should show Debt description
          Text(payable.payable[index].debtId,
            style: TextStyle(
              fontSize: 15.0, 
              fontWeight: FontWeight.normal),
            textAlign: TextAlign.end),
      ]),
      onTap: () async {
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => DebtorPage(),
            settings: RouteSettings(
              arguments: payable.payable[index].debtorId
            )));
      },
    );
  }
}