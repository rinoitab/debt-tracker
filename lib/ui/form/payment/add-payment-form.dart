import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debttracker/model/debtor-model.dart';
import 'package:debttracker/service/logic.dart';
import 'package:debttracker/shared/dialog.dart';
import 'package:debttracker/shared/loading.dart';
import 'package:debttracker/view-model/debt-viewmodel.dart';
import 'package:debttracker/view-model/debtor-viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:debttracker/shared/constant.dart' as constant;

class AddPaymentForm extends StatefulWidget {
  final String debtorId;
  final String debtId;
  AddPaymentForm({this.debtorId, this.debtId});

  @override
  _AddPaymentFormState createState() => _AddPaymentFormState();
}

class _AddPaymentFormState extends State<AddPaymentForm> {
  
  String _debtor;
  String _debt;
  String _desc;
  String _date;
  double _amount;


  final cur = new NumberFormat.simpleCurrency(name: 'PHP');
  final _dateController = TextEditingController();
  final _amountController =
      MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');

  final key = GlobalKey<FormState>();

  DebtorVM _debtorModel = DebtorVM();
  DebtVM _debtModel = DebtVM();
  Logic logic = Logic();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      autovalidate: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FutureBuilder<Debtor>(
            future: _debtorModel.getDebtorById(widget.debtorId),
            builder: (context, snapshot) {
              if(!snapshot.hasData) return TinyLoading();
              _debtor = snapshot.data.name;
              return TextFormField(
                enabled: false,
                initialValue: snapshot.data.name,
                decoration: constant.form.copyWith(
                  icon: Icon(Icons.face,
                    color: Colors.grey.shade600,)),
                );
            }
          ),
          SizedBox(height: 15.0),
          StreamBuilder<QuerySnapshot>(
            stream: _debtModel.streamDebtsById(widget.debtorId),
            builder: (context, snapshot) {
              if(!snapshot.hasData) return Container();
              return DropdownButtonFormField(
                onChanged: (value) {
                  setState(() {
                    _debt = value;
                  });
                },
                value: _debt,
                items: snapshot.data.documents.map((DocumentSnapshot ds) {
                  _desc = ds.data['desc'];
                  return DropdownMenuItem<String>(
                    value: ds.documentID,
                    child: Text(ds.data['desc']));
                }).toList(),
                isDense: true,
                decoration: constant.form.copyWith(
                  labelText: 'Debt', 
                  icon: Icon(Icons.shopping_cart,
                    color: Colors.grey.shade600)));
            }
          ),
          SizedBox(height: 15.0),
          TextFormField(
            controller: _dateController,
            decoration: constant.form.copyWith(
              labelText: 'Date', 
              icon: Icon(Icons.schedule,
                color: Colors.grey.shade600)),
            onTap: () async {
              DateTime date = DateTime(1900);
              FocusScope.of(context).requestFocus(new FocusNode());
              date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                builder: (BuildContext context, Widget child) {
                  return Theme(
                    child: child,
                    data: ThemeData(
                      primaryColor: constant.pink,
                      primaryColorBrightness: Brightness.dark,
                      accentColor: constant.green,
                      accentColorBrightness: Brightness.dark,
                      colorScheme: ColorScheme.light(
                        primary: constant.pink
                      )
                    )
                  );
                });
                _date = date.toIso8601String();
                _dateController.text = new DateFormat("MMM d, yyyy").format(date).toString();
            }
          ),
          SizedBox(height: 15.0),
          TextFormField(
            controller: _amountController,
            decoration: constant.form.copyWith(
              labelText: 'Amount', 
              hintText: 'Enter payment amount',
              icon: Icon(Icons.payment,
                color: Colors.grey.shade600)),
            onChanged: (value) {
              _amount = _amountController.numberValue;
            },
            keyboardType: TextInputType.number),
          SizedBox(height: 20.0),
          FlatButton(
            onPressed: () {
              print('Generate receipt');
              print(widget.debtorId);
              print(_debtor);
              print(_debt);
              print(_desc);
              print(_date);
              print('$_amount');

              var text = logic.generateReceipt('SAMPLE-RECEIPT', _debtor, _desc, DateFormat("MMM d, yyyy").format(DateTime.parse(_date)).toString(), cur.format(_amount));
              generateReceiptDialog(context, text, 'SAMPLE-RECEIPT');

            }, 
            child: Card(
              color: constant.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
              ),
              child: Container(
                width: double.infinity,
                height: 40.0,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: Text('Generate Receipt',
                        style: constant.subtitle.copyWith(
                          color: constant.bluegreen, 
                        )
                      ),
                    ),
                  ),
                ),
              ),
            ))
        ],
      ),
    );
  }
}
