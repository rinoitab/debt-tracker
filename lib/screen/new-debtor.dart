import 'package:debttracker/screen/form/new-debtor-form.dart';
import 'package:flutter/material.dart';

class NewDebtor extends StatefulWidget {
  @override
  _NewDebtorState createState() => _NewDebtorState();
}

class _NewDebtorState extends State<NewDebtor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('New Debtor'),
          backgroundColor: Color(0xff99b898),
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: DebtorForm(),
        ));
  }
}
