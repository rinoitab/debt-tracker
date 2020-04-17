import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

class PaymentForm extends StatefulWidget {
  PaymentForm({Key key}) : super(key: key);

  @override
  _PaymentFormState createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {

  var _debtor;
  var _debt;
  var _date;

  final _fdate = TextEditingController();
  final _amount = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');

  final paymentKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: paymentKey,
      autovalidate: true,
      child: ListView(
        children: <Widget>[
          getDebtor(),
          SizedBox(height: 15),
          getDebt(),
          SizedBox(height: 15),
          getDate(),
          SizedBox(height: 15),
          getAmount(),
          SizedBox(height: 15),
          savePayment()
        ],
      )
    );
  }

  // * Save Payment
  // note: this will save debt information provided in the form
  // todo: connect to database
  Widget savePayment() {
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
            if (paymentKey.currentState.validate()) {
              print(_debtor);
              print(_debt);
              print(_date.toString());
              print(_amount.text);
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
    List<String> _name = ['Ms. Randy Conn', 'Fidel Stamm', 'Edythe Hoeger'];

    return new DropdownButtonFormField(
      value: _debtor,
      isDense: true,
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
      items: _name.map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: new Text(value));
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
  }

  // * Debtor
  // note: Will return all debts of selected Debtor where isPaid == false in database
  // todo: connect to database 
  Widget getDebt() {
    List<String> _debts = ['Samsung Galaxy S10', 'iPhone XS', 'Macbook Pro'];

    return new DropdownButtonFormField(
      value: _debt,
      isDense: true,
      decoration: InputDecoration(
        isDense: true,
        labelText: 'Debt',
        hintText: 'Select debt',
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
      items: _debts.map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: new Text(value));
      }).toList(), 
      onChanged: (value) {
        setState(() {
          _debt = value;
        });
      },
      validator: (value) {
        if (value == null) {
          return '';
        }
        return null;
    });
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
        if (value == null) {
          return '';
        } return null;
      });
  }

}

