import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

class DebtForm extends StatefulWidget {
  @override
  _DebtFormState createState() => _DebtFormState();
}

class _DebtFormState extends State<DebtForm> {
  List<DocumentSnapshot> debtorList = [];
  List<DocumentSnapshot> typeList = [];
  var _debtor;
  var _date;
  var _type;

  final _fdate = TextEditingController();
  final _amount = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');
  final _desc = TextEditingController();
  final _term = TextEditingController();
  final _markup = TextEditingController();

  final debtKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return getDebtForm();
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
                });
              },
              validator: (value) {
                if (value == null) {
                  return '';
                }
                return null;
              });
        });
  }

  Widget getPaymentType(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('type').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(child: const CupertinoActivityIndicator());
          debtorList = snapshot.data.documents;
          return new DropdownButtonFormField(
              isDense: true,
              value: _type,
              decoration: InputDecoration(
                isDense: true,
                labelText: 'Payment Type',
                hintText: 'Select payment type',
                icon: Icon(Icons.money_off),
                errorStyle: TextStyle(height: 0),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff99b898),
                    ),
                    borderRadius: BorderRadius.circular(24.0)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0)),
              ),
              items: typeList.map((DocumentSnapshot type) {
                return DropdownMenuItem(
                  value: type.data['value'].toString(),
                  child: Text(type.data['label']),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _type = value;
                });
              },
              validator: (value) {
                if (value == null) {
                  return '';
                }
                return null;
              });
        });
  }

  Widget getDebtForm() {
    return new Form(
      key: debtKey,
      autovalidate: true,
      child: new ListView(
        children: <Widget>[
          getDebtorList(context),
          SizedBox(height: 15.0),
          new TextFormField(
              controller: _fdate,
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
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0)),
              ),
              onTap: () async {
                DateTime date = DateTime(1900);
                FocusScope.of(context).requestFocus(new FocusNode());
                date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100));
                _date = date.toIso8601String();
                _fdate.text =
                    new DateFormat("MMM d, yyyy").format(date).toString();
              },
              validator: (value) {
                if (value.isEmpty) {
                  return '';
                } return null;
              }),
          SizedBox(height: 15.0),
          new TextFormField(
            controller: _amount,
            decoration: InputDecoration(
              isDense: true,
              labelText: 'Amount',
              hintText: 'Input amount',
              icon: Icon(Icons.attach_money),
              errorStyle: TextStyle(height: 0),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff99b898),
                  ),
                  borderRadius: BorderRadius.circular(24.0)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(24.0)),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null) {
                return '';
              } return null;
            },
          ),
          SizedBox(height: 15.0),
          new TextFormField(
            controller: _desc,
            decoration: InputDecoration(
              isDense: true,
              labelText: 'Description',
              hintText: 'Input description',
              icon: Icon(Icons.note),
              errorStyle: TextStyle(height: 0),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff99b898),
                  ),
                  borderRadius: BorderRadius.circular(24.0)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(24.0)),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return '';
              } return null;
            },
          ),
          SizedBox(height: 15.0),
          new TextFormField(
            controller: _term,
            decoration: InputDecoration(
              isDense: true,
              labelText: 'Payment Term',
              hintText: 'Enter payment term',
              icon: Icon(Icons.payment),
              errorStyle: TextStyle(height: 0),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff99b898),
                  ),
                  borderRadius: BorderRadius.circular(24.0)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(24.0)),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              var amtCheck = int.tryParse(value);
              if (amtCheck == null) {
                return '';
              } return null;
            },
          ),
          SizedBox(height: 15.0),
          getPaymentType(context),
          SizedBox(height: 15.0),
          new TextFormField(
            controller: _markup,
            decoration: InputDecoration(
              isDense: true,
              labelText: 'Markup',
              hintText: 'Input markup percentage',
              icon: Icon(Icons.trending_up),
              errorStyle: TextStyle(height: 0),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff99b898),
                  ),
                  borderRadius: BorderRadius.circular(24.0)),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(24.0)),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              var amtCheck = int.tryParse(value);
              if (amtCheck == null) {
                return '';
              } return null;
            },
          ),

          SizedBox(height: 40),

          Center(
            child: ButtonTheme(
              minWidth: 200,
              child: RaisedButton(
                color: Color(0xff99b898),
                padding: EdgeInsets.all(10),
                splashColor: Colors.green,
                animationDuration: Duration(seconds: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(24.0),
                ),
                child: Text('Save',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  )),
                elevation: 5,
                onPressed: () {
                  if (debtKey.currentState.validate()) {
                    print(_debtor);
                    print(_date.toString());
                    print(_amount.text);
                    print(_desc.text);
                    print(_term.text);
                    print(_type);
                    print(_markup.text);
                  }
                },
              ),
            )
          )
        ],
      ),
    );
  }
}
