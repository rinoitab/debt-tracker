import 'package:debttracker/view-model/debtor-viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:debttracker/shared/constant.dart' as constant;
import 'package:flutter_masked_text/flutter_masked_text.dart';

class AddDebtor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: EdgeInsets.all(50.0),
      child: AddDebtorForm(),
    );
  }
}

class AddDebtorForm extends StatefulWidget {
  @override
  _AddDebtorFormState createState() => _AddDebtorFormState();
}

class _AddDebtorFormState extends State<AddDebtorForm> {

  final _name = TextEditingController();
  final _contactPhone = MaskedTextController(mask: '(63) 000 000 0000');
  final _contactLandline = MaskedTextController(mask: '000-0000');
  final _address = TextEditingController();
  final _comaker = TextEditingController();
  final _altPhone = MaskedTextController(mask: '(63) 000 000 0000');
  final _altLandline = MaskedTextController(mask: '000-0000');

  final key = GlobalKey<FormState>();

  int _contactOption = 0;
  int _altOption = 0;
  List<String> _contactValue = ['Phone', 'Landline'];
  int _contact;
  int _altcontact;

  DebtorVM _debtorModel = DebtorVM();

  void clear() {
    _name.text = '';
    _contactPhone.text = '';
    _contactLandline.text = '';
    _address.text = '';
    _comaker.text = '';
    _altPhone.text = '';
    _altLandline.text = '';
    _contactOption = 0;
    _altOption = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      autovalidate: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Borrower Information',
            style: constant.subtitle.copyWith(
              color: constant.bluegreen,
              fontWeight: FontWeight.bold,
              fontSize: 25.0
            )),
          SizedBox(height: 20.0),
          TextFormField(
            controller: _name,
            decoration: constant.form.copyWith(
              labelText: 'Name',
              hintText: 'Input name of borrower',
              icon: Icon(Icons.face,
                color: Colors.grey.shade600))),
          SizedBox(height: 15.0),
          Row(
            children: <Widget>[
              Icon(Icons.phone,
                color: Colors.grey.shade600),
              SizedBox(width: 15.0),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: _contactValue[_contactOption],
                    items: _contactValue
                      .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem(
                        child: Text(value,
                          style: constant.subtitle.copyWith(
                            color: Colors.grey.shade600
                          )),
                        value: value
                        );
                    }).toList(), 
                    onChanged: (value) {
                      setState(() {
                        _contactOption = _contactValue.indexOf(value);
                      });
                    }),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                flex: 6,
                child: TextFormField(
                  controller: _contactOption == 0 ? _contactPhone : _contactLandline,
                  decoration: constant.form.copyWith(
                    labelText: 'Contact',
                    hintText: 'Input contact number of borrower',
                  ),
                  onChanged: (value) {
                    _contact = int.parse(value.replaceAll(RegExp(r'[^\w]'), ''));
                  }),
              ),
            ],
          ),
          SizedBox(height: 15.0),
          TextFormField(
            controller: _address,
            decoration: constant.form.copyWith(
              labelText: 'Address',
              hintText: 'Input address of borrower',
              icon: Icon(Icons.room,
                color: Colors.grey.shade600))),
          SizedBox(height: 15.0),
          TextFormField(
            controller: _comaker,
            decoration: constant.form.copyWith(
              labelText: 'Co-Borrower',
              hintText: 'Input name of co-borrower',
              icon: Icon(Icons.tag_faces,
                color: Colors.grey.shade600))),
          SizedBox(height: 15.0),
          Row(
            children: <Widget>[
              Icon(Icons.voicemail,
                color: Colors.grey.shade600),
              SizedBox(width: 15.0),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: _contactValue[_altOption],
                    items: _contactValue
                      .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem(
                        child: Text(value,
                          style: constant.subtitle.copyWith(
                            color: Colors.grey.shade600
                          )),
                        value: value
                        );
                    }).toList(), 
                    onChanged: (value) {
                      setState(() {
                        _altOption = _contactValue.indexOf(value);
                      });
                    }),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                flex: 6,
                child: TextFormField(
                  controller: _altOption == 0 ? _altPhone : _altLandline,
                  decoration: constant.form.copyWith(
                    labelText: 'Alternate Contact',
                    hintText: 'Input alternate contact number of borrower',
                  ),
                  onChanged: (value) {
                    _altcontact = int.parse(value.replaceAll(RegExp(r'[^\w]'), ''));
                    print(_altcontact);
                  }),
              ),
            ],
          ),
          SizedBox(height: 15.0),
          FlatButton(
            onPressed: () {
              if(key.currentState.validate()) {
                _debtorModel.addDebtor(
                  name: _name.text, 
                  contact: _contact,
                  address: _address.text ?? '',
                  comaker: _comaker.text ?? '',
                  altcontact: _altcontact != null ? _altcontact : null)
                .then((result) {
                  SnackBar(
                    content: Text('Successful'));
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
      ));
  }
}