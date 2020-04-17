import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

class DebtForm extends StatefulWidget {
  @override
  _DebtFormState createState() => _DebtFormState();
}

class _DebtFormState extends State<DebtForm> {

  var _debtor;
  var _date;
  var _ptype;

  final _fdate = TextEditingController();
  final _amount = MoneyMaskedTextController(decimalSeparator: '.', thousandSeparator: ',');
  final _desc = TextEditingController();
  final _term = TextEditingController();
  final _markup = TextEditingController();

  final debtKey = GlobalKey<FormState>();

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
              print(_debtor);
              print(_date.toString());
              print(_amount.text);
              print(_desc.text);
              print(_term.text);
              print(_ptype);
              print(_markup.text);
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