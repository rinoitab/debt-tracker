import 'package:debttracker/ui/form/debtor/add-debtor-form.dart';
import 'package:flutter/material.dart';

class AddDebtor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: EdgeInsets.all(50.0),
      child: AddDebtorForm(),
    );
  }
}