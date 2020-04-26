import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debttracker/shared/dialog.dart';
import 'package:debttracker/shared/loading.dart';
import 'package:debttracker/view-model/debt-viewmodel.dart';
import 'package:debttracker/view-model/debtor-viewmodel.dart';
import 'package:debttracker/view-model/payables-viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'package:debttracker/business-logic/business-logic.dart';

class DebtForm extends StatefulWidget {
  @override
  _DebtFormState createState() => _DebtFormState();
}

class _DebtFormState extends State<DebtForm> {

  String _debtor;
  String _date;
  String _startDate;
  String _secondDate;
  String _ptype;
  int _typeIndex;

  final _fdate = TextEditingController();
  final _cdate = TextEditingController();
  final _sdate = TextEditingController();
  final _amount = TextEditingController();
  final _desc = TextEditingController();
  final _term = TextEditingController();
  final _markup = TextEditingController();

  final debtKey = GlobalKey<FormState>();
  DebtorVM model = DebtorVM();
  DebtVM debtModel = DebtVM();
  PayablesVM payablesModel = PayablesVM();
  BusinessLogic logic = BusinessLogic();

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
          getDate(),
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

              var list = logic.getPayableDates(double.parse(_term.text), _typeIndex, _startDate, _secondDate ?? '');
              var adjustedAmt = logic.getAdjustedAmount(double.parse(_amount.text), int.parse(_markup.text));
              var installmentAmt = logic.getInstallmentAmount(adjustedAmt, double.parse(_term.text), _typeIndex);
              String _debtId;

                debtModel.addDebt(
                debtorId: _debtor, 
                date: DateTime.parse(_date),
                amount: double.parse(_amount.text),
                desc: _desc.text,
                term: double.parse(_term.text),
                type: _typeIndex,
                markup: int.parse(_markup.text),
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
                payablesModel.addPayable(
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
      stream: model.fetchDebtorForDropdown(),
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
  Widget getDate() {
    return new TextFormField(
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
    });
  }

  Widget getStartDate() {
    return new TextFormField(
    controller: _cdate,
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
      _startDate = date.toIso8601String();
      _cdate.text =
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
    controller: _sdate,
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
    enabled: _typeIndex == 2 ? true : false,
    onTap: () async {
      DateTime date = DateTime(1900);
      FocusScope.of(context).requestFocus(new FocusNode());
      date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100));
      _secondDate = date.toIso8601String();
      _sdate.text =
          new DateFormat("MMM d, yyyy").format(date).toString();
    });
  }

  // * Amount
  Widget getAmount() {
    return new TextFormField(
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
        if (value == '0.00') {
          return '';
        } return null;
      });
  }

  // * Description 
  Widget getDesc() {
    return new TextFormField(
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
      });
  }

  // * Payment
  // todo: add word months when user inputs
  Widget getTerm() {
    return new TextFormField(
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
      value: _ptype,
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
          _ptype = value;
          _typeIndex = value != 'once a week' ? _type.indexOf(value) + 1 : 4;
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
    );
  }


}