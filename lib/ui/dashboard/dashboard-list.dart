import 'package:debttracker/model/combine-stream.dart';
import 'package:debttracker/service/logic.dart';
import 'package:debttracker/shared/loading.dart';
import 'package:debttracker/ui/detail/debtor.dart';
import 'package:debttracker/ui/form/payment/add-payment.dart';
import 'package:debttracker/view-model/combine-stream-vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:debttracker/shared/constant.dart' as constant;

class DashboardList extends StatefulWidget {
  @override
  _DashboardListState createState() => _DashboardListState();
}

class _DashboardListState extends State<DashboardList> {
  CombineStreamVM _combineStreamModel = CombineStreamVM();
  List<CombineStream> _list = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CombineStream>>(
      stream: _combineStreamModel.streamDueToday(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) return Loading();
        _list = [];
        for(int i = 0; i < snapshot.data.length; i++) {
          if(snapshot.data[i].payables.isPaid != true) {
            _list.add(snapshot.data[i]);
          }
        }
        return ListView.builder(
          shrinkWrap: true,
          itemCount: _list.length,
          itemBuilder: (context, index) {
            return DashboardListTile(combineStream: _list[index]); 
          }
        );
      }
    );
  }
}

class DashboardListTile extends StatelessWidget {
  final CombineStream combineStream;
  DashboardListTile({this.combineStream});

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    Logic _logic = Logic();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: 20.0),
        Container(
          height: 100.0,
          width: width * 0.8,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text('${combineStream.debtor.name}',
                style: constant.subtitle.copyWith(
                  color: constant.bluegreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0
                )),
              subtitle: Text(_logic.formatDate(combineStream.payables.date), 
                style: constant.subtitle.copyWith(
                  fontSize: 18.0,
                  color: Colors.grey.shade600
              )),
              trailing: RichText(
                textAlign: TextAlign.right,
                text: TextSpan(
                  text: '${_logic.formatCurrency(combineStream.payables.balance)}',
                  style: constant.subtitle.copyWith(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: constant.bluegreen),
                  children: [
                    TextSpan(
                      text: '\n${_logic.formatCurrency(combineStream.debt.balance)}',
                      style: constant.subtitle.copyWith(
                        fontWeight: FontWeight.normal,
                        color: Colors.grey.shade600,
                        fontSize: 18.0
                      )
                    )
                  ]
                ),
              ),
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => DebtorPage(id: combineStream.debtor.id)));
              }
            ),
          ),
        ),
        SizedBox(width: 40.0),
        IconButton(
          icon: Icon(Icons.arrow_forward_ios,
            color: constant.pink),
          onPressed: () {
            showModalBottomSheet(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(240.0),
                  topLeft: Radius.circular(40.0))),
              context: context, 
              builder: (context) => 
                AddPayment(debtor: combineStream.debtor, debt: combineStream.debt, payables: combineStream.payables));
          },
        )
      ],
    );
  }
}