import 'package:debttracker/page/form/new-debt-form.dart';
import 'package:flutter/material.dart';

class NewDebt extends StatefulWidget {
  @override
  _NewDebtState createState() => _NewDebtState();
}

class _NewDebtState extends State<NewDebt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Debt'),
        backgroundColor: Color(0xff99b898),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: DebtForm(),
      ),
    );
  }
}
