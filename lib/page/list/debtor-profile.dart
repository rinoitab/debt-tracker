import 'package:debttracker/model/debtor.dart';
import 'package:debttracker/shared/loading.dart';
import 'package:flutter/material.dart';

class DebtorProfile extends StatefulWidget {

  final Debtor debtor;
  DebtorProfile({this.debtor});

  @override
  _DebtorProfileState createState() => _DebtorProfileState();
}

class _DebtorProfileState extends State<DebtorProfile> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 4;
    double width = MediaQuery.of(context).size.width;

    if (Debtor() == null ) {
      return Loading();
    } else

    return Column(children: <Widget>[
      Stack(
        children: <Widget>[
          Container(
              width: width,
              height: height - 20,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.green[100],
                        offset: Offset(0, 15))
                  ],
                  color: Color(0xff99b898),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(240.0)))),
          Container(
            margin: EdgeInsets.only(left: width / 2),
            alignment: Alignment.topRight,
            padding: EdgeInsets.only(right: 30, top: 0, bottom: 20, left: 30),
            width: double.infinity,
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text('Debtor Name',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.end),
                Text('Debtor Address',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    textAlign: TextAlign.end),
                Text(123.toString(),
                    style: TextStyle(fontSize: 16, color: Colors.white),
                    textAlign: TextAlign.end),
                SizedBox(height: 30),
                Text('secondary contact',
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    )),
                Text('Comaker',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.end),
                Text(123.toString(),
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
                              fontSize: 15.0, fontWeight: FontWeight.normal)),
                      new Text('P34,000',
                          style: new TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.normal)),
                      new Text('P20,000 / P54,000',
                          style: new TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.normal)),
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
                              fontSize: 15.0, fontWeight: FontWeight.normal)),
                      new Text('P30,000',
                          style: new TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.normal)),
                      new Text('P40,000 / P70,000',
                          style: new TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.normal)),
                    ]),
                onTap: () {},
              )
            ],
          ),
        ),
      )
    ]);
  }
}
