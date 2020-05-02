import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debttracker/shared/dialog.dart';
import 'package:debttracker/view-model/debt-viewmodel.dart';
import 'package:debttracker/view-model/debtor-viewmodel.dart';
import 'package:debttracker/view-model/payables-viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:debttracker/service/logic.dart';
import 'package:debttracker/shared/constant.dart' as constant;

class AddDebtForm extends StatefulWidget {
  @override
  _AddDebtFormState createState() => _AddDebtFormState();
}

class _AddDebtFormState extends State<AddDebtForm> {

  final key = GlobalKey<FormState>();

  String _debtor;
  String _date;
  double _amount;
  int _markup;
  String _typeDesc;
  int _type;
  String _start;
  String _end;

  final _formDate = TextEditingController();
  final _formDesc = TextEditingController();
  final _formAmount = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');
  final _formMarkup = TextEditingController();
  final _formInterval = TextEditingController();
  final _formStart = TextEditingController();
  final _formEnd = TextEditingController();
  final _formAdjusted = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');
  final _formAmortization = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');

  List<String> _typeOptions = ['once a month', 'every 15th', 'once a week'];

  DebtorVM _debtorModel = DebtorVM();
  DebtVM _debtModel = DebtVM();
  PayablesVM _payablesModel = PayablesVM();
  Logic logic = Logic();

  double _getAdjustedAmount() {
    return logic.getAdjustedAmount(_amount, _markup);
  }

  double _getAmortization() {
    return logic.getInstallmentAmount(_formAdjusted.numberValue, double.parse(_formInterval.text), _type);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      autovalidate: true,
      child: Column(
        children: <Widget>[
          Text('Debt Details',
            style: constant.subtitle.copyWith(
              color: constant.bluegreen,
              fontWeight: FontWeight.bold,
              fontSize: 20.0
            )),
          SizedBox(height: 15.0),
          StreamBuilder<QuerySnapshot>(
            stream: _debtorModel.streamAllDebtors(),
            builder: (context, snapshot) {
              if(!snapshot.hasData) return Container();
              return DropdownButtonFormField(
                onChanged: (value) {
                  setState(() {
                    _debtor = value;
                  });
                },
                isDense: true,
                items: snapshot.data.documents.map((DocumentSnapshot ds) {
                  return DropdownMenuItem<String>(
                    value: ds.documentID,
                    child: Text(ds.data['name']));
                }).toList(),
                value: _debtor,
                decoration: constant.form.copyWith(
                  labelText: 'Name',
                  icon: Icon(Icons.face,
                    color: Colors.grey.shade600)));
            }
          ),
          SizedBox(height: 15.0),
          TextFormField(
            controller: _formDate,
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
                _formDate.text = new DateFormat("MMM d, yyyy").format(date).toString();
            },
            validator: (value) => value.isEmpty || value == null ? '' : null),
          SizedBox(height: 15.0),
          TextFormField(
            controller: _formDesc,
            decoration: constant.form.copyWith(
              labelText: 'Description',
              hintText: 'Input description or note',
              icon: Icon(Icons.shopping_cart,
                color: Colors.grey.shade600)),
            validator: (value) => value.isEmpty || value == null ? '' : null),
          SizedBox(height: 15.0),
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: _formAmount,
                  decoration: constant.form.copyWith(
                    labelText: 'Principal Amount',
                    icon: Icon(Icons.payment,
                      color: Colors.grey.shade600)),
                  onChanged: (value) {
                    _amount = _formAmount.numberValue;
                    _formAdjusted.updateValue(_getAdjustedAmount());
                    _formAmortization.updateValue(_getAmortization());
                  },
                  keyboardType: TextInputType.number,
                  validator: (value) => _formAmount.numberValue == 0.00 ? '' : null),
              ),
              SizedBox(width: 20.0),
              Expanded(
                child: TextFormField(
                  controller: _formMarkup,
                  decoration: constant.form.copyWith(
                    labelText: 'Markup'),
                  onChanged: (value) {
                    _markup = int.parse(value);
                    _formAdjusted.updateValue(_getAdjustedAmount());
                    _formAmortization.updateValue(_getAmortization());
                  },
                  validator: (value) => value.isEmpty || value == null || int.tryParse(value) == null ? '' : null)
              ),
              SizedBox(width: 20.0),
              Expanded(
                flex: 2,
                child: TextFormField(
                  readOnly: true,
                  controller: _formAdjusted,
                  decoration: constant.form.copyWith(
                    labelText: 'Principal + Interest',
                    icon: Icon(Icons.trending_up,
                      color: Colors.grey.shade600)),
                validator: (value) => _formAdjusted.numberValue == 0.00 ? '' : null),
              ),
            ],
          ),
          SizedBox(height: 15.0),
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  onChanged: (value) {
                    _formAmortization.updateValue(_getAmortization());
                  },
                  controller: _formInterval,
                  decoration: constant.form.copyWith(
                    labelText: 'Payment Interval',
                    hintText: 'Input months',
                    icon: Icon(Icons.low_priority,
                      color: Colors.grey.shade600)),
                    validator: (value) => value.isEmpty || value == null || double.tryParse(value) == null ? '' : null),
              ),
              SizedBox(width: 20.0),
              Expanded(
                child: DropdownButtonFormField(
                  isDense: true,
                  onChanged: (value) {
                    setState(() {
                      _typeDesc = value;
                      _type = value != 'once a week' ? _typeOptions.indexOf(value) + 1 : 4;
                    });
                    _formAmortization.updateValue(_getAmortization());
                  },
                  value: _typeDesc,
                  items: _typeOptions.map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value));
                  }).toList(),
                  decoration: constant.form.copyWith(
                    labelText: 'Schedule'))
              ),
              SizedBox(width: 20.0),
              Expanded(
                child: TextFormField(
                  readOnly: true,
                  controller: _formAmortization,
                  decoration: constant.form.copyWith(
                    labelText: 'Amortization',
                    icon: Icon(Icons.calendar_today,
                      color: Colors.grey.shade600)),
                  validator: (value) => _formAmortization.numberValue == 0.00 ? '' : null)
              ),
            ],
          ),
          SizedBox(height: 15.0),
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  controller: _formStart,
                  decoration: constant.form.copyWith(
                    labelText: 'Collection Schedule',
                    icon: Icon(Icons.event,
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
                      _start = date.toIso8601String();
                      _formStart.text = new DateFormat("MMM d, yyyy").format(date).toString();
                  },
                  validator: (value) => value.isEmpty || value == null ? '' : null),
              ),
              SizedBox(width: 20.0),
              Expanded(
                child: TextFormField(
                  enabled: _type == 2 ? true : false,
                  controller: _formEnd,
                  decoration: constant.form.copyWith(
                    labelText: 'Collection Schedule'),
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
                      _end = date.toIso8601String();
                      _formEnd.text = new DateFormat("MMM d, yyyy").format(date).toString();
                  })
              ),
            ],
          ),
          SizedBox(height: 15.0),
          FlatButton(
            onPressed: () {
              if(key.currentState.validate()) {
                print(_debtor);
                print(_date);
                print(_formDesc.text);
                print(_amount);
                print(_formMarkup.text);
                print(_formAdjusted.numberValue);
                print(_formInterval.text);
                print(_type);
                print(_formAmortization.numberValue);
                print(_start);
                print(_end);

                String _debtId;

                _debtModel.addDebt(
                  debtorId: _debtor, 
                  date: DateTime.parse(_date),
                  desc: _formDesc.text,
                  amount: _amount,
                  markup: int.parse(_formMarkup.text),
                  adjustedAmount: _formAdjusted.numberValue,
                  term: double.parse(_formInterval.text),
                  type: _type,
                  installmentAmount: _formAmortization.numberValue)
                  .then((result) {
                    successDialog(context, _formDesc.text, '');
                   _debtId = result.documentID;
                  }).catchError((e) {
                    errorDialog(context, _formDesc.text);
                  });

                var payableDateList = logic.getPayableDates(double.parse(
                  _formInterval.text), 
                  _type, 
                  _start, 
                  _end ?? '');      

                for (var i = 0; i < payableDateList.length; i++) {
                _payablesModel.addPayable(
                  debtorId: _debtor, 
                  debtId: _debtId,
                  amount: _formAmortization.numberValue,
                  date: payableDateList[i]);
                }     
              }
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
                      child: Text('Save',
                        style: constant.subtitle.copyWith(
                          color: constant.bluegreen, 
                      )
                    ),
                  ),
                ),
              )),
            ))
        ],
      )
    );
  }
}