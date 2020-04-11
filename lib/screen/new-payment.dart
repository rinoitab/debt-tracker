import 'package:debttracker/screen/form/new-payment-form.dart';
import 'package:flutter/material.dart';

class NewPayment extends StatefulWidget {
  @override
  _NewPaymentState createState() => _NewPaymentState();
}

class _NewPaymentState extends State<NewPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('New Payment'),
          backgroundColor: Color(0xff99b898),
        ),
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: PaymentForm(),
        ),

        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 20.0, right: 10.0),
          child: FloatingActionButton(
            elevation: 4,
            backgroundColor: Color(0xff99b898),
            child: Icon(Icons.save),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ));
  }
}