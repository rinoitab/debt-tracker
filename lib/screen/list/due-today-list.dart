import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debttracker/screen/debtor-detail-page.dart';
import 'package:debttracker/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DueTodayList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Due Today')),
      body: SafeArea(
        child: Container(
          child: StreamBuilder(
              stream: Firestore.instance.collection('debt').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text('Loading...');
                return ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) =>
                      getDueToday(context, snapshot.data.documents[index]),
                );
              }),
        ),
      ),
    );
  }

  Widget getDueToday(BuildContext context, DocumentSnapshot debt) {
    DateTime debtDate = debt['date'].toDate();
    var formattedDate = new DateFormat("MMM d, yyyy").format(debtDate);
    final cur = new NumberFormat.simpleCurrency(name: 'PHP');

    return new Card(
        child: new Column(
      children: <Widget>[
        new ListTile(
          leading: new Text(debt['debtor'],
                style: dashboardListLeading),
  
          subtitle: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Text(formattedDate.toString(),
                      style: dashboardListSubtitle,
                      textAlign: TextAlign.end),
                  new Text(cur.format(debt['amount']),
                      style: dashboardListSubtitle,
                      textAlign: TextAlign.end),
                  new Text(debt['desc'],
                      style: dashboardListSubtitle,
                      textAlign: TextAlign.end),
                ]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DebtorDetails(),
                  settings: RouteSettings(
                    arguments: debt['debtor'],
                  )),
            );
          },
        )
      ],
    ));
  }
}
