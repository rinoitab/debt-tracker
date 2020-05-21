import 'package:debttracker/model/combine-stream.dart';
import 'package:debttracker/service/logic.dart';
import 'package:debttracker/shared/loading.dart';
import 'package:debttracker/ui/detail/debtor.dart';
import 'package:debttracker/view-model/combine-stream-vm.dart';
import 'package:flutter/material.dart';
import 'package:debttracker/shared/constant.dart' as constant;
import 'package:percent_indicator/circular_percent_indicator.dart';

class PendingList extends StatefulWidget {
  @override
  _PendingListState createState() => _PendingListState();
}

class _PendingListState extends State<PendingList> {

  CombineStreamVM _combineStreamModel = CombineStreamVM();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: constant.green,
        elevation: 0,
        title: Text('Pending')
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: StreamBuilder<List<CombineStream>>(
          stream: _combineStreamModel.streamPendingDebts(),
          builder: (context, snap) {
            if(!snap.hasData) return Loading();
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snap.data.length,
              itemBuilder: (context, index) {
                return PendingListTile(pending: snap.data[index]);
              });
          }),
      )
    );
  }
}

class PendingListTile extends StatelessWidget {

  final CombineStream pending;
  PendingListTile({this.pending});

  @override
  Widget build(BuildContext context) {

    Logic _logic = Logic();
    int _percentInDecimal = _logic.getPercentInDecimal(pending.debt.adjustedAmount, pending.debt.balance);
    double _percentage = _logic.getPercentage(pending.debt.adjustedAmount, pending.debt.balance);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        isThreeLine: true,
        onTap: () {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => DebtorPage(id: pending.debtor.id)));
        },
        leading: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: CircularPercentIndicator(
            backgroundColor: Colors.grey.shade100,
            progressColor: _percentInDecimal > 50 ? constant.green : constant.pink,
            radius: 50.0,
            center: Text('$_percentInDecimal%'),
            percent: _percentage,
        )),
        title: Text(pending.debtor.name,
          style: constant.subtitle.copyWith(
            color: constant.bluegreen,
            fontSize: 25.0,
            fontWeight: FontWeight.bold
        )),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(pending.debt.desc,
              style: constant.subtitle.copyWith(
                fontSize: 18.0,
                fontWeight: FontWeight.bold
            )),
            Text('${_logic.formatCurrency(pending.debt.adjustedAmount - pending.debt.balance)} over ${_logic.formatCurrency(pending.debt.adjustedAmount)}',
              style: constant.subtitle.copyWith(
                fontSize: 18.0
            )),
          ],
        ),
      ),
    );
  }
}