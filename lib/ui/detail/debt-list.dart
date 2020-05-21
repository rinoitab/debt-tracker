import 'package:debttracker/model/debt-model.dart';
import 'package:debttracker/model/debtor-model.dart';
import 'package:debttracker/service/logic.dart';
import 'package:debttracker/shared/loading.dart';
import 'package:debttracker/ui/detail/payment-list.dart';
import 'package:debttracker/view-model/debt-viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:debttracker/shared/constant.dart' as constant;
import 'package:percent_indicator/circular_percent_indicator.dart';

class DebtList extends StatefulWidget {
  final Debtor debtor;
  const DebtList({Key key, this.debtor}) : super(key: key);

  @override
  _DebtListState createState() => _DebtListState();
}

class _DebtListState extends State<DebtList> {

  DebtVM _debtModel = DebtVM();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        width: width,
        height: height,
        child: StreamBuilder<List<Debt>>(
          stream: _debtModel.streamDebtById(widget.debtor.id),
          builder: (BuildContext context, AsyncSnapshot<List<Debt>> snap) {
            if(!snap.hasData) return Loading();
            return ListView.builder(
              itemCount: snap.data.length,
              itemBuilder: (context, index) {
                return DebtListCard(debt: snap.data[index], debtor: widget.debtor);
              });
          }
        )
      ),
    );
  }
}

class DebtListCard extends StatelessWidget {
  final Debtor debtor;
  final Debt debt;
  const DebtListCard({Key key, this.debtor, this.debt}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    Logic _logic = Logic();

    int _percentInDecimal = _logic.getPercentInDecimal(debt.adjustedAmount, debt.balance);
    double _percentage = _logic.getPercentage(debt.adjustedAmount, debt.balance);

    List<String> interval = [
      'once a month',
      'every 15th',
      'once a week'
    ];

    return Container(
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: debt.isCompleted == false ? constant.pink : constant.green,
          radius: 25,
          child: Icon(debt.isCompleted == false ? Icons.warning : Icons.done,
            color: Colors.white,),
        ),
        title: Text('${debt.desc}',
          style: constant.subtitle.copyWith(
            fontWeight: FontWeight.bold,
            color: constant.bluegreen,
            fontSize: 20.0
          )),
        trailing: CircularPercentIndicator(
            backgroundColor: Colors.grey.shade100,
            progressColor: _percentInDecimal > 50 ? constant.green : constant.pink,
            radius: 50.0,
            center: Text('$_percentInDecimal%'),
            percent: _percentage,
        ),
        subtitle: 
          Container(
            padding: EdgeInsets.only(
              left: 50.0,
              bottom: 20.0),
            width: width,
            child: Row(
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      Text('Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: constant.bluegreen)),
                      Text('Principal + Interest',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: constant.bluegreen)),
                      Text('Amortization',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: constant.bluegreen)),
                      Text('Balance',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: constant.bluegreen)),
                      
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      Text(_logic.formatDate(debt.date),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade800)),
                      Text(_logic.formatCurrency(debt.adjustedAmount) +
                        ' (${_logic.formatCurrency(debt.amount)} + ${debt.markup}%)',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade800)),
                      Text(_logic.formatCurrency(debt.installmentAmount) + ' for ${debt.term} months ${debt.type == 1 ? interval[0] : debt.type == 2 ? interval[1] : interval[2]}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade800)),
                      Text(_logic.formatCurrency(debt.balance) + ' / ' + _logic.formatCurrency(debt.adjustedAmount),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade800)),
                      
                    ],
                  ),
                ),
              ], 
            ),
          ),
        children: <Widget>[
          PaymentList(id: debt.id, debtor: debtor, debt: debt)
        ],
      ),
  );
  }
}