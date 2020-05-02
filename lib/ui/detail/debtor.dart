import 'package:debttracker/model/debtor-model.dart';
import 'package:debttracker/shared/loading.dart';
import 'package:debttracker/ui/detail/debt-list.dart';
import 'package:debttracker/ui/form/debt/add-debt.dart';
import 'package:debttracker/ui/form/debtor/add-debtor.dart';
import 'package:debttracker/ui/form/payment/add-payment.dart';
import 'package:debttracker/view-model/debtor-viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class DebtorPage extends StatefulWidget {
  final String id;
  DebtorPage({this.id});

  @override
  _DebtorPageState createState() => _DebtorPageState();
}

class _DebtorPageState extends State<DebtorPage> {

  DebtorVM _debtorModel = DebtorVM();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddDebtor()
                  ));
              },
            ),
          ),
        ],
        elevation: 0),
        body: FutureBuilder<Debtor>(
          future: _debtorModel.getDebtorById(widget.id),
          builder: (BuildContext context, AsyncSnapshot<Debtor> snapshot) {
          if (!snapshot.hasData) return Loading();
            return Column(
              children: <Widget>[
                debtorDetail(context, snapshot.data),
                SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return DebtList(debtor: snapshot.data);
                    },
                  ),
                ),
              ],
            );
          }
        ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 10.0, bottom: 15.0),
        child: floatingMenu(context),
      )
    );
  }

  Widget debtorDetail(BuildContext context, Debtor debtor) {

    double height = MediaQuery.of(context).size.height / 4;
    double width = MediaQuery.of(context).size.width;

    return Stack(
      children: <Widget>[
        Container(
          width: width,
          height: height - 20,
          decoration: BoxDecoration(
            color: Color(0xff99b898),
            borderRadius:
                BorderRadius.only(bottomLeft: Radius.circular(240.0)))),
        Positioned(
          top: height * 0.55,
          left: 40,
          child: GestureDetector(
            onTap: () {

            },
            child: CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: 25,
              child: Icon(Icons.phone,
                color: Color(0xff99b898))
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: width * 0.3),
          alignment: Alignment.topRight,
          padding: EdgeInsets.only(right: 30, top: 0, bottom: 20, left: 0),
          width: width,
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text('${debtor.name}',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.end),
              Text('${debtor.address}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.end),
              Text('${debtor.contact}',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.end),
              SizedBox(height: 30),
              Text(debtor.comaker.isEmpty && debtor.altcontact == 0 ? 'No secondary contact added' : 'Secondary contact',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  )),
              Text('${debtor.comaker}',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.end),
              Text(debtor.altcontact != 0 ? '${debtor.altcontact}' : '',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.end),
            ],
          ),
        )
      ]
    );
  }

  Widget floatingMenu(BuildContext context) {
    return SpeedDial(
      elevation: 0,
      animatedIcon: AnimatedIcons.menu_close,
      backgroundColor: Color(0xff99b898),
      children: [

        // * Add New Debt
        // todo: Add in Debtor profile and automatically set Debtor field to Debtor
        SpeedDialChild(
          child: Icon(Icons.note_add),
          label: 'Add Debt',
          backgroundColor: Color(0xff99b898),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddDebt()
              ));
          }
        ),

        // * Add New Payment
        // todo: Add in Debtor Profile and automatically set Debtor field to Debtor
        // todo: Add in Debt details and automatically set Debtor and Debt field
        SpeedDialChild(
          child: Icon(Icons.payment),
          label: 'Add Payment',
          backgroundColor: Color(0xff99b898),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddPayment()
              ));
          }
        )
      ],
    );
  }
}