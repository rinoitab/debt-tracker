import 'package:debttracker/model/debt-model.dart';
import 'package:debttracker/model/debtor-model.dart';
import 'package:debttracker/model/payables-model.dart';
import 'package:debttracker/ui/form/payment/add-payment-form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddPayment extends StatelessWidget {
  final Debtor debtor;
  final Debt debt;
  final Payables payables;
  AddPayment({this.debtor, this.debt, this. payables});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.5,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 50.0, 0.0, 50.0),
              child: AddPaymentForm(debtor: debtor, payables: payables),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SvgPicture.asset('images/savings.svg',
                alignment: Alignment.bottomRight),
            )
          )
        ],
      ),
    );
  }
}
