import 'package:debttracker/ui/form/payment/add-payment-form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddPayment extends StatelessWidget {
  final String debtorId;
  final String debtId;
  AddPayment({this.debtorId, this.debtId});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.5,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 50.0, 0.0, 50.0),
              child: AddPaymentForm(debtorId: debtorId, debtId: debtId),
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
