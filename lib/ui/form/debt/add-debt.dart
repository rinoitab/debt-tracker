import 'package:debttracker/model/debtor-model.dart';
import 'package:debttracker/ui/form/debt/add-debt-form.dart';
import 'package:flutter/material.dart';

class AddDebt extends StatelessWidget {
  final Debtor debtor;
  AddDebt({this.debtor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: EdgeInsets.all(50.0),
      child: AddDebtForm(debtor: debtor),
    );
  }
}