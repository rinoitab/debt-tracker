import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DebtorDetails extends StatefulWidget {
  @override
  _DebtorDetailsState createState() => _DebtorDetailsState();
}

class _DebtorDetailsState extends State<DebtorDetails> {
  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context).settings.arguments;

    return StreamBuilder(
        stream:
            Firestore.instance.collection('debtor').document(id).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          }
          var debtor = snapshot.data;
          return getDetails(debtor);
        });
  }

  Widget getDetails(DocumentSnapshot debtor) {
    double height = MediaQuery.of(context).size.height / 4;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: Container(
            child: Column(children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                  width: width,
                  height: height - 20,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.green[100],
                            //blurRadius: 10,
                            offset: Offset(0, 15))],
                      color: Color(0xff99b898),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(240.0)))),
              Container(
                margin: EdgeInsets.only(left: width / 2),
                alignment: Alignment.topRight,
                padding:
                    EdgeInsets.only(right: 30, top: 0, bottom: 20, left: 30),
                width: double.infinity,
                height: height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(debtor['name'],
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.end),
                    Text(debtor['address'],
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.end),
                    Text(debtor['contact'].toString(),
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.end),
                    SizedBox(height: 30),
                    Text('secondary contact',
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        )),
                    Text(debtor['comaker'],
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        textAlign: TextAlign.end),
                    Text(debtor['cocontact'].toString(),
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.end),
                  ],
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            width: width,
            child: new Card(
              child: new Column(
                children: <Widget>[
                  new ListTile(
                    leading: new Text('iPhone XS',
                        style: new TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold)),
                    subtitle: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          new Text('Jan 5, 2010',
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal)),
                          new Text('P34,000',
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal)),
                          new Text('P20,000 / P54,000',
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal)),
                        ]),
                    onTap: () {},
                  ),
                  new ListTile(
                    leading: new Text('Macbook Air 2020',
                        style: new TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold)),
                    subtitle: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          new Text('Apr 10, 2020',
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal)),
                          new Text('P30,000',
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal)),
                          new Text('P40,000 / P70,000',
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.normal)),
                        ]),
                    onTap: () {},
                  )
                ],
              ),
            ),
          )
        ])));
  }
}
