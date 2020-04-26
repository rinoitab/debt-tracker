import 'package:debttracker/model/debt-model.dart';
import 'package:debttracker/model/debtor-model.dart';
import 'package:debttracker/shared/loading.dart';
import 'package:debttracker/view-model/debt-viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:debttracker/shared/constant.dart' as constant;

class DebtList extends StatefulWidget {
  final Debtor debtor;
  const DebtList({Key key, this.debtor}) : super(key: key);

  @override
  _DebtListState createState() => _DebtListState();
}

class _DebtListState extends State<DebtList> {

  DebtVM debt = DebtVM();
  Future<List<Debt>> debtList;

  @override
  void initState() {
    super.initState();
    debtList = debt.fetchDebts(widget.debtor.id);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        width: width,
        height: height,
        child: FutureBuilder<List<Debt>>(
          future: debtList,
          builder: (BuildContext context, AsyncSnapshot<List<Debt>> snap) {
            if(!snap.hasData) return Loading();
            return ListView.builder(
              itemCount: snap.data.length,
              itemBuilder: (context, index) {
                return DebtListCard(debt: snap.data[index]);
              });
          }
        )
      ),
    );
  }
}

class DebtListCard extends StatelessWidget {
  final Debt debt;
  const DebtListCard({Key key, this.debt}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    final cur = new NumberFormat.simpleCurrency(name: 'PHP');

    return Card(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30)
    ),
    child: ExpansionTile(
      leading: CircleAvatar(
        backgroundColor: debt.isCompleted == false ? constant.red : constant.green,
        radius: 25,
        child: Icon(debt.isCompleted == false ? Icons.warning : Icons.done,
          color: Colors.white,),
      ),
      title: Text('${debt.desc}',
        style: TextStyle(
          fontWeight: FontWeight.bold
        )),
      subtitle: Text('${debt.date}'),
      trailing: CircularPercentIndicator(
        radius: 50,
        percent: 0.6,
        circularStrokeCap: CircularStrokeCap.round,
        backgroundColor: Colors.grey[200],
        progressColor: debt.isCompleted == false ? constant.red : constant.green,
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
                    Text(cur.format(debt.amount),
                      style: TextStyle(
                        fontSize: 14)),
                    Text(cur.format(debt.amount) + ' for ${debt.term}',
                      style: TextStyle(
                        fontSize: 14)),
                    Text(cur.format(debt.amount) + ' / ' + cur.format(debt.amount),
                      style: TextStyle(
                        fontSize: 14)),
                    Text('${debt.date}',
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
            color: debt.isCompleted == false ? constant.red : constant.green
          )),
        SizedBox(height: 20)
      ],
    )
  );
  }
}