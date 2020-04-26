import 'package:debttracker/shared/dialog.dart';
import 'package:debttracker/view-model/debtor-viewmodel.dart';
import 'package:flutter/material.dart';

class DebtorForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final debtorKey = GlobalKey<FormState>();

    final _name = TextEditingController();
    final _contact = TextEditingController();
    final _address = TextEditingController();
    final _comaker = TextEditingController();
    final _altcontact = TextEditingController();

    DebtorVM model = new DebtorVM();

    void clearFields() {
      _name.text = '';
      _contact.text = '';
      _address.text = '';
      _comaker.text = '';
      _altcontact.text = '';
    }

    // todo: Clean up same as Debt form
    return new Form(
      key: debtorKey,
      autovalidate: true,
      child: new ListView(
        children: <Widget>[
          // * Debtor Name
          new TextFormField(
              controller: _name,
              decoration: InputDecoration(
                isDense: true,
                labelText: 'Name',
                hintText: 'Input name of debtor',
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
              validator: (value) {
                if (value.length < 2) {
                  return '';
                }
                return null;
              }),
          SizedBox(height: 15.0),

          // * Contact Number
          new TextFormField(
              controller: _contact,
              decoration: InputDecoration(
                isDense: true,
                labelText: 'Contact Number',
                hintText: 'Input contact number',
                icon: Icon(Icons.phone),
                errorStyle: TextStyle(height: 0),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff99b898),
                    ),
                    borderRadius: BorderRadius.circular(24.0)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0)),
              ),
              validator: (value) {
                var parseContact = int.tryParse(value);
                if (parseContact == null) {
                  return '';
                }
                return null;
              }),
          SizedBox(height: 15.0),

          // * Address
          new TextFormField(
              controller: _address,
              decoration: InputDecoration(
                isDense: true,
                labelText: 'Address',
                hintText: 'Input address',
                icon: Icon(Icons.map),
                errorStyle: TextStyle(height: 0),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff99b898),
                    ),
                    borderRadius: BorderRadius.circular(24.0)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0)),
              )),
          SizedBox(height: 15.0),

          // * Co-maker
          new TextFormField(
              controller: _comaker,
              decoration: InputDecoration(
                isDense: true,
                labelText: 'Co-maker',
                hintText: 'Input co-maker',
                icon: Icon(Icons.person_add),
                errorStyle: TextStyle(height: 0),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff99b898),
                    ),
                    borderRadius: BorderRadius.circular(24.0)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0)),
              )),
          SizedBox(height: 15.0),

          // * Alternate Contact
          new TextFormField(
              controller: _altcontact,
              decoration: InputDecoration(
                isDense: true,
                labelText: 'Alternate Contact Number',
                hintText: 'Input secondary contact number',
                icon: Icon(Icons.phone_missed),
                errorStyle: TextStyle(height: 0),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff99b898),
                    ),
                    borderRadius: BorderRadius.circular(24.0)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0)),
              ),
              validator: (value) {
                if (value.isNotEmpty) {
                  var parseContact = int.tryParse(value);
                  if (parseContact == null) {
                    return '';
                  }
                  return null;
                } else {
                  return null;
                }} 
            ),
          SizedBox(height: 40),

          // * Save Debtor based on information provided in form
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
                      fontWeight: FontWeight.bold)),
              elevation: 0,
              onPressed: () {
                if (debtorKey.currentState.validate()) {
                  model.addDebtor(
                    name: _name.text, 
                    contact: int.parse(_contact.text),
                    address: _address.text ?? '',
                    comaker: _comaker.text ?? '',
                    altcontact: _altcontact.text.isNotEmpty ? int.parse(_altcontact.text) : null
                  ).then((result) {
                    successDialog(context, _name.text);
                    clearFields();
                  }).catchError((e) {
                    errorDialog(context, _name.text);
                  });
                }
              },
            ),
          ))
        ],
      ),
    );
  }
}
