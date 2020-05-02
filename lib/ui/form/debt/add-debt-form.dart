import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debttracker/shared/dialog.dart';
import 'package:debttracker/shared/loading.dart';
import 'package:debttracker/view-model/debt-viewmodel.dart';
import 'package:debttracker/view-model/debtor-viewmodel.dart';
import 'package:debttracker/view-model/payables-viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:debttracker/service/logic.dart';

class DebtForm extends StatefulWidget {
  @override
  _DebtFormState createState() => _DebtFormState();
}

class _DebtFormState extends State<DebtForm> {

  String _debtor;
  String _debtDate;
  String _startCollectionDate;
  String _secondCollectionDate;
  String _typeDesc;
  int _typeValue;


  final _formDebtDate = TextEditingController();
  final _formStartCollectionDate = TextEditingController();
  final _formSecondCollectionDate = TextEditingController();
  final _formAmount = TextEditingController();
  final _formDesc = TextEditingController();
  final _formTerm = TextEditingController();
  final _formMarkup = TextEditingController();

  final debtKey = GlobalKey<FormState>();
  DebtorVM _debtorModel = DebtorVM();
  DebtVM _debtModel = DebtVM();
  PayablesVM _payablesModel = PayablesVM();
  Logic _businessLogic = Logic();

  void clearFields() {
    // _fdate.text = '';
    // _amount.text = '';
    // _desc.text = '';
    // _term.text = '';
    // _markup.text = '';
    // _sdate.text = '';
    // _cdate.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: debtKey,
      autovalidate: true,
      child: ListView(
        children: <Widget>[
          getDebtor(),
          SizedBox(height: 15),
          getDate(context),
          SizedBox(height: 15),
          getAmount(),
          SizedBox(height: 15),
          getDesc(),
          SizedBox(height: 15),
          getTerm(),
          SizedBox(height: 15),
          getType(),
          SizedBox(height: 15),
          getMarkup(),
          SizedBox(height: 15),
          getStartDate(),
          SizedBox(height: 15),
          getSecondDate(),
          SizedBox(height: 40),
          saveDebt()        
        ],
      )
    );
  }

  // * Save Debt
  // note: this will save debt information provided in the form
  // todo: connect to database
  Widget saveDebt() {
    return Center(
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
          elevation: 0,
          onPressed: () {
            if (debtKey.currentState.validate()) {

              var list = _businessLogic.getPayableDates(double.parse(_formTerm.text), _typeValue, _startCollectionDate, _secondCollectionDate ?? '');
              var adjustedAmt = _businessLogic.getAdjustedAmount(double.parse(_formAmount.text), int.parse(_formMarkup.text));
              var installmentAmt = _businessLogic.getInstallmentAmount(adjustedAmt, double.parse(_formTerm.text), _typeValue);
              String _debtId;

              _debtModel.addDebt(
                debtorId: _debtor, 
                date: DateTime.parse(_debtDate),
                amount: double.parse(_formAmount.text),
                desc: _formDesc.text,
                term: double.parse(_formTerm.text),
                type: _typeValue,
                markup: int.parse(_formMarkup.text),
                adjustedAmount: adjustedAmt,
                installmentAmount: installmentAmt)
                .then((result) {
                    successDialog(context, 'debt');
                    clearFields();
                   _debtId = result.documentID;
                  }).catchError((e) {
                    print(e.toString());
                    errorDialog(context, 'debt');
                  });

              for (var i = 0; i < list.length; i++) {
                _payablesModel.addPayable(
                  debtorId: _debtor, 
                  debtId: _debtId,
                  amount: installmentAmt,
                  date: list[i]);
              }
              
            }
          },
        ),
      )
    );
  }

  // * Debtor
  // note: Will return all Debtor in database
  // todo: connect to database 
  Widget getDebtor() {
    

    return StreamBuilder<QuerySnapshot>(
      stream: _debtorModel.streamAllDebtors(),
      builder: (context, snap) {
        if (!snap.hasData) return Loading();
        return new DropdownButtonFormField(
          value: _debtor,
          items: snap.data.documents.map((DocumentSnapshot ds) {
            return DropdownMenuItem<String>(
              value: ds.documentID,
              child: Text(ds.data['name']));
          }).toList(),
          isDense: true,
          decoration: InputDecoration(
            isDense: true,
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
          onChanged: (value) {
            setState(() {
              this._debtor = value;
            });
          },
          validator: (value) {
            if (value == null) {
              return '';
            }
            return null;
        });
      }
    );
  }

  // * Date
  // note: Will pop calendar which will allow user to select date
  Widget getDate(BuildContext context) {
    return new TextFormField(
    controller: _formDebtDate,
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
      _debtDate = date.toIso8601String();
      _formDebtDate.text = new DateFormat("MMM d, yyyy").format(date).toString();
    },
    validator: (value) {
      if (value.isEmpty) {
        return '';
      } return null;
    });
  }

  Widget getStartDate() {
    return new TextFormField(
    controller: _formStartCollectionDate,
    decoration: InputDecoration(
      isDense: true,
      labelText: 'Start Collection Date',
      hintText: 'Input start of collection date',
      icon: Icon(Icons.looks_one),
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
      _startCollectionDate = date.toIso8601String();
      _formStartCollectionDate.text =
          new DateFormat("MMM d, yyyy").format(date).toString();
    },
    validator: (value) {
      if (value.isEmpty) {
        return '';
      } return null;
    });
  }

  Widget getSecondDate() {
    return new TextFormField(
    controller: _formSecondCollectionDate,
    decoration: InputDecoration(
      isDense: true,
      labelText: 'Second Collection Date',
      hintText: 'Input second collection date',
      icon: Icon(Icons.looks_two),
      errorStyle: TextStyle(height: 0),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xff99b898),
          ),
          borderRadius: BorderRadius.circular(24.0)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0)),
    ),
    enabled: _typeValue == 2 ? true : false,
    onTap: () async {
      DateTime date = DateTime(1900);
      FocusScope.of(context).requestFocus(new FocusNode());
      date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100));
      _secondCollectionDate = date.toIso8601String();
      _formSecondCollectionDate.text =
          new DateFormat("MMM d, yyyy").format(date).toString();
    });
  }

  // * Amount
  Widget getAmount() {
    return new TextFormField(
      controller: _formAmount,
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
        if (value == '0.00') {
          return '';
        } return null;
      });
  }

  // * Description 
  Widget getDesc() {
    return new TextFormField(
      controller: _formDesc,
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
      });
  }

  // * Payment
  // todo: add word months when user inputs
  Widget getTerm() {
    return new TextFormField(
      controller: _formTerm,
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
        var amtCheck = num.tryParse(value);
        if (amtCheck == null) {
          return '';
        } return null;
      });  
  }

  // * Type
  // note: Will return payment type based on list
  // todo: Should get value instead of label
  Widget getType() {
    List<String> _type = ['once a month', 'every 15th', 'once a week'];

    return new DropdownButtonFormField(
      value: _typeDesc,
      isDense: true,
      decoration: InputDecoration(
        isDense: true,
        labelText: 'Type',
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
      items: _type.map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: new Text(value));
      }).toList(), 
      onChanged: (value) {
        setState(() {
          _typeDesc = value;
          _typeValue = value != 'once a week' ? _type.indexOf(value) + 1 : 4;
        });
      },
      validator: (value) {
        if (value == null) {
          return '';
        }
        return null;
    });
  }

  // * Markup 
  // todo: Add % sign in text field
  Widget getMarkup() {
    return new TextFormField(
      controller: _formMarkup,
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
    );
  }


}