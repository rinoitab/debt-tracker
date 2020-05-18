import 'package:debttracker/model/debt-model.dart';
import 'package:debttracker/model/debtor-model.dart';
import 'package:debttracker/model/payables-model.dart';
import 'package:debttracker/service/logic.dart';
import 'package:debttracker/shared/dialog.dart';
import 'package:debttracker/view-model/debt-viewmodel.dart';
import 'package:debttracker/view-model/debtor-viewmodel.dart';
import 'package:debttracker/view-model/payables-viewmodel.dart';
import 'package:debttracker/view-model/payment-viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:debttracker/shared/constant.dart' as constant;

class AddPaymentForm extends StatefulWidget {
  final Debtor debtor;
  final Payables payables;
  AddPaymentForm({this.debtor, this. payables});

  @override
  _AddPaymentFormState createState() => _AddPaymentFormState();
}

class _AddPaymentFormState extends State<AddPaymentForm> {
  
  String _debtor;
  String _debt;
  String _desc;
  String _date;
  double _amount;
  List<Debt> _debtList = [];


  final cur = new NumberFormat.simpleCurrency(name: 'PHP');
  final _debtorController = TextEditingController();
  final _dateController = TextEditingController();
  final _amountController =
      MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');

  final key = GlobalKey<FormState>();

  Debt debt;
  DebtorVM _debtorModel = DebtorVM();
  DebtVM _debtModel = DebtVM();
  PayablesVM _payablesModel = PayablesVM();
  PaymentVM _paymentModel = PaymentVM();
  Logic logic = Logic();

  @override
  void initState() {
    _dateController.text = new DateFormat("MMM d, yyyy").format(DateTime.now()).toString();
    _date = DateTime.now().toIso8601String();
    _debtorController.text = widget.debtor.name;
    super.initState();
  }

  void clear() {
    _dateController.text = new DateFormat("MMM d, yyyy").format(DateTime.now()).toString();
    _date = DateTime.now().toIso8601String();
    _amountController.updateValue(0);
  }

  Future _markAsPaid(double _amount, String id) async {
    var _debts = await _debtModel.getDebtById(id);
    var _payables = await _payablesModel.getPayablesById(id);
    logic.markPaidPayables(_payables, _amount, _debts);
    print(debt.balance);
    
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      autovalidate: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          StreamBuilder<Debtor>(
            stream: _debtorModel.streamDebtorById(widget.debtor.id),
            builder: (context, snapshot) {
              if(!snapshot.hasData) return Container();
              _debtor = snapshot.data.name;
              return TextFormField(
                enabled: false,
                controller: _debtorController,
                decoration: constant.form.copyWith(
                  icon: Icon(Icons.face,
                    color: Colors.grey.shade600,)),
                );
            }
          ),
          SizedBox(height: 15.0),
          StreamBuilder<List<Debt>>(
            stream: _debtModel.streamDebtById(widget.debtor.id),
            builder: (context, snapshot) {
              if(!snapshot.hasData) return Container();
              _debtList = [];
              for(int i = 0; i < snapshot.data.length; i++) {
                if(snapshot.data[i].isCompleted != true) {
                  _debtList.add(snapshot.data[i]);
                }
              }
              return DropdownButtonFormField(
                  onChanged: (value) {
                    setState(() {
                      _debt = value;
                    });
                  },
                  value: _debt,
                  items: 
                    _debtList.map((Debt _debt) {
                    _desc = _debt.desc;
                    if(_debt.isCompleted != true)
                    return DropdownMenuItem<String>(
                      value: _debt.id,
                      child: Text(_debt.desc));
                  })?.toList() ?? [],
                  isDense: true,
                  decoration: constant.form.copyWith(
                    labelText: 'Debt', 
                    icon: Icon(Icons.shopping_cart,
                      color: Colors.grey.shade600)),
                  validator: (value) {
                    if(value == null) return '';
                    else return null;
                  }); 
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
            },
            validator: (value) => value.isEmpty ? '' : null,
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
            validator: (value) => _amountController.numberValue == 0.0 ? '' : null,
            keyboardType: TextInputType.number),
          SizedBox(height: 20.0),
          FlatButton(
            onPressed: () {

              var text = logic.generateReceipt('SAMPLE-RECEIPT', _debtor, _desc, DateFormat("MMM d, yyyy").format(DateTime.parse(_date)).toString(), cur.format(_amount));
              if(key.currentState.validate()) {
                _paymentModel.addPayment(
                  debtorId: widget.debtor.id, 
                  debtId: _debt,
                  date: DateTime.parse(_date),
                  amount: _amount)
                  .then((result) {
                    clear();
                    _markAsPaid(_amount, _debt).whenComplete(
                      generateReceiptDialog(context, text, result.documentID.toString().toUpperCase())
                  );
                  }).catchError((e) {
                    print(e.toString());
                    errorDialog(context, _desc);
                  });
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
