import 'package:debttracker/ui/form/debt/add-debt-form.dart';
import 'package:flutter/material.dart';

class AddDebt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Debt'),
        backgroundColor: Color(0xff99b898),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: DebtForm(),
      ),
    );
  }
}