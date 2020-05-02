import 'package:debttracker/model/payables-model.dart';
import 'package:debttracker/shared/loading.dart';
import 'package:debttracker/ui/form/payment/add-payment.dart';
import 'package:debttracker/view-model/payables-viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:debttracker/shared/constant.dart' as constant;
import 'package:intl/intl.dart';

class DashboardList extends StatefulWidget {
  @override
  _DashboardListState createState() => _DashboardListState();
}

class _DashboardListState extends State<DashboardList> {
  PayablesVM _payablesModel = PayablesVM();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Payables>>(
      stream: _payablesModel.getDueToday(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) return Loading();
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) {
            if(snapshot.data[index].isPaid != true)
            return DashboardListTile(payables: snapshot.data[index]);
          }
        );
      }
    );
  }
}

class DashboardListTile extends StatelessWidget {
  final Payables payables;
  DashboardListTile({this.payables});

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    final cur = new NumberFormat.simpleCurrency(name: 'PHP');

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(width: 20.0),
        Container(
          height: 100.0,
          width: width * 0.7,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text('${payables.debtorId}',
                style: constant.subtitle.copyWith(
                  color: constant.bluegreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0
                )),
              subtitle: Text(new DateFormat("MMMM d, yyyy").format(payables.date).toString(), 
                style: constant.subtitle.copyWith(
                  fontSize: 18.0,
                  color: Colors.grey.shade600
              )),
              trailing: RichText(
                textAlign: TextAlign.right,
                text: TextSpan(
                  text: '${cur.format(payables.amount)}',
                  style: constant.subtitle.copyWith(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: constant.bluegreen),
                  children: [
                    TextSpan(
                      text: '\n${cur.format(35000)}',
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
                print('Clicked list.');
              },
            ),
          ),
        ),
        SizedBox(width: 30.0),
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
                AddPayment(debtorId: payables.debtorId, debtId: payables.debtId));
          },
        )
      ],
    );
  }
}