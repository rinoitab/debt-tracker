import 'package:debttracker/ui/form/debtor/add-debtor-form.dart';
import 'package:flutter/material.dart';

class AddDebtor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('New Debtor'),
          backgroundColor: Color(0xff99b898),
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: DebtorForm()
        ));
  }
}