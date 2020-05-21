import 'package:debttracker/model/combine-stream.dart';
import 'package:debttracker/service/logic.dart';
import 'package:debttracker/shared/loading.dart';
import 'package:debttracker/ui/detail/debtor.dart';
import 'package:debttracker/view-model/combine-stream-vm.dart';
import 'package:flutter/material.dart';
import 'package:debttracker/shared/constant.dart' as constant;

class OverdueList extends StatefulWidget {
  @override
  _OverdueListState createState() => _OverdueListState();
}

class _OverdueListState extends State<OverdueList> {

  CombineStreamVM _combineStreamModel = CombineStreamVM();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: constant.green,
        elevation: 0,
        title: Text('Overdue')
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: StreamBuilder<List<CombineStream>>(
          stream: _combineStreamModel.streamOverdue(),
          builder: (context, snap) {
            if(!snap.hasData) return Loading();
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snap.data.length,
              itemBuilder: (context, index) {
                return OverdueListTile(overdue: snap.data[index]);
              });
          }),
      )
    );
  }
}

class OverdueListTile extends StatelessWidget {

  final CombineStream overdue;
  OverdueListTile({this.overdue});
  

  @override
  Widget build(BuildContext context) {

    Logic _logic = Logic();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        isThreeLine: true,
        onTap: () {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => DebtorPage(id: overdue.debtor.id)));
        },
        leading: CircleAvatar(
          radius: 50.0,
          backgroundColor: constant.pink,
          child: Text('-${_logic.getDaysLate(overdue.payables.date)}',
            style: constant.subtitle.copyWith(
              fontSize: 20.0,
              color: Colors.white
            )),
        ),
        trailing: Text('${_logic.formatDate(overdue.payables.date)}',
          style: constant.subtitle.copyWith(
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          )),
        title: Text(overdue.debtor.name,
          style: constant.subtitle.copyWith(
            color: constant.bluegreen,
            fontSize: 25.0,
            fontWeight: FontWeight.bold
        )),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(overdue.debt.desc,
              style: constant.subtitle.copyWith(
                fontSize: 18.0,
                fontWeight: FontWeight.bold
            )),
            Text('${_logic.formatCurrency(overdue.debt.adjustedAmount - overdue.debt.balance)} over ${_logic.formatCurrency(overdue.debt.adjustedAmount)}',
              style: constant.subtitle.copyWith(
                fontSize: 18.0
            )),
          ],
        ),
      ),
    );
  }
}