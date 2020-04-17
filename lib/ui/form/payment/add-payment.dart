import 'package:debttracker/ui/form/payment/add-payment-form.dart';
import 'package:flutter/material.dart';

class AddPayment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Payment'),
        backgroundColor: Color(0xff99b898),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: PaymentForm()
      ),
    );
  }
}