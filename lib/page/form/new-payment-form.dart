import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentForm extends StatefulWidget {
  @override
  _PaymentFormState createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  List<DocumentSnapshot> debtorList = [];
  List<DocumentSnapshot> debtList = [];

  String _debtor;
  String _debt;

  final paymentKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return getPaymentForm();
  }

  Widget getDebtList(BuildContext context, String id) {

    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('debt')
            .where('debtor', isEqualTo: id)
            .snapshots(),
        builder: (context, snapshot) {
          debtList = snapshot.data.documents;
          return DropdownButtonFormField(
              isDense: true,
              value: _debt,
              decoration: InputDecoration(
                isDense: true,
                labelText: 'Debt',
                hintText: 'Select debt description',
                icon: Icon(Icons.note),
                errorStyle: TextStyle(height: 0),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff99b898),
                    ),
                    borderRadius: BorderRadius.circular(24.0)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0)),
              ),
              items: debtList.map((DocumentSnapshot debt) {
                return DropdownMenuItem(
                  value: debt.documentID,
                  child: Text(debt.data['desc']),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _debt = value;
                  print('id $id');
                  print('_debt $_debt');
                });
              },
              validator: (value) {
                if (value == null) {
                  return '';
                } return null;
              });
        });
  }

  Widget getDebtorList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('debtor').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(child: const CupertinoActivityIndicator());
          debtorList = snapshot.data.documents;
          return new DropdownButtonFormField(
              isDense: true,
              value: _debtor,
              decoration: InputDecoration(
                isDense: true,
                labelText: 'Debtor',
                hintText: 'Select debtor',
                icon: Icon(Icons.person),
                errorStyle: TextStyle(height: 0),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff99b898),
                    ),
                    borderRadius: BorderRadius.circular(24.0)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0)),
              ),
              items: debtorList.map((DocumentSnapshot debtor) {
                return DropdownMenuItem(
                  value: debtor.documentID,
                  child: Text(debtor.data['name']),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _debtor = value;
                  debtList.clear();
                  getDebtList(context, value);
                  print('value $value');
                  print('_debtor $_debtor');
                });
              },
              validator: (value) {
                if (value == null) {
                  return '';
                } return null;
              });
        });
  }

  Widget getPaymentForm() {
    return new Form(
      key: paymentKey,
      autovalidate: true,
      child: new ListView(
        children: <Widget>[
          getDebtorList(context),
          SizedBox(height: 15.0),
          getDebtList(context, _debtor),
          SizedBox(height: 15.0),
          new TextFormField(
            decoration: InputDecoration(
              isDense: true,
              labelText: 'Date',
              hintText: 'Input date',
              icon: Icon(Icons.calendar_today),
              errorStyle: TextStyle(height: 0),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff99b898),
                  ),
                  borderRadius: BorderRadius.circular(24.0)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(24.0)),
            ),
          ),
          SizedBox(height: 15.0),
          new TextFormField(
            decoration: InputDecoration(
              isDense: true,
              labelText: 'Amount',
              hintText: 'Input payment amount',
              icon: Icon(Icons.person_add),
              errorStyle: TextStyle(height: 0),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff99b898),
                  ),
                  borderRadius: BorderRadius.circular(24.0)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(24.0)),
            ),
          ),
        ],
      ),
    );
  }
}
