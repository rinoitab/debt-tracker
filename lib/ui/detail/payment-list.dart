import 'package:debttracker/model/debt-model.dart';
import 'package:debttracker/model/debtor-model.dart';
import 'package:debttracker/model/payment-model.dart';
import 'package:debttracker/service/logic.dart';
import 'package:debttracker/shared/loading.dart';
import 'package:debttracker/view-model/payment-viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:debttracker/shared/constant.dart' as constant;
import 'package:flutter/services.dart';

class PaymentList extends StatefulWidget {

  final String id;
  final Debt debt;
  final Debtor debtor;
  PaymentList({this.id, this.debt, this.debtor});

  @override
  _PaymentListState createState() => _PaymentListState();
}

class _PaymentListState extends State<PaymentList> {
  PaymentVM _paymentModel = PaymentVM();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Payment>>(
      stream: _paymentModel.streamPaymentById(widget.id),
      builder: (context, snapshot) {
        if(!snapshot.hasData) return Loading();
        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data.length,
          itemBuilder: (context, index) { 
            return PaymentListTile(payment: snapshot.data[index], debtor: widget.debtor, debt: widget.debt);
          });
      }
    );
  }
}

class PaymentListTile extends StatelessWidget {

  final Debtor debtor;
  final Debt debt;
  final Payment payment;
  PaymentListTile({this.payment, this.debtor, this.debt});

  @override
  Widget build(BuildContext context) {
    Logic _logic = Logic();

    return GestureDetector(
      onTap: (){
        Clipboard.setData(new ClipboardData(text: 
          _logic.generateReceipt(payment.id, debtor.name, debt.desc, _logic.formatDate(payment.date), _logic.formatCurrency(payment.amount))));
        Scaffold.of(context).showSnackBar(
          new SnackBar(
            backgroundColor: constant.pink,
            duration: Duration(seconds: 3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0)
              )
            ),
            content: Text('Copied ${payment.id.toUpperCase()} to Clipboard.'))
        );
      },
      child: Container(
        padding: EdgeInsets.only(left: 30.0),
        child: ListTile(
          leading: Text(_logic.formatDate(payment.date),
            style: constant.subtitle.copyWith(
              fontSize: 20.0,
              color: constant.bluegreen,
              fontWeight: FontWeight.bold
            )),
          title: Container(
            margin: EdgeInsets.only(left: 30.0),
            child: Text('Reference Code: ${payment.id.toUpperCase()}',
              style: constant.subtitle.copyWith(
                fontSize: 20.0,
                color: constant.pink,
                fontWeight: FontWeight.bold
            )),
          ),
          trailing: Text('${_logic.formatCurrency(payment.amount)}',
            style: constant.subtitle.copyWith(
              fontSize: 20.0,
              color: constant.bluegreen,
              fontWeight: FontWeight.bold
            )),
        ),
      ),
    );
  }
}