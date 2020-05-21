import 'package:debttracker/model/debtor-model.dart';
import 'package:debttracker/service/logic.dart';
import 'package:debttracker/shared/loading.dart';
import 'package:debttracker/ui/detail/debt-list.dart';
import 'package:debttracker/ui/form/debt/add-debt.dart';
import 'package:debttracker/ui/form/debtor/add-debtor.dart';
import 'package:debttracker/ui/form/payment/add-payment.dart';
import 'package:debttracker/view-model/debtor-viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:debttracker/shared/constant.dart' as constant;
import 'package:flutter_svg/flutter_svg.dart';

class DebtorPage extends StatefulWidget {
  final String id;
  DebtorPage({this.id});

  @override
  _DebtorPageState createState() => _DebtorPageState();
}

class _DebtorPageState extends State<DebtorPage> {

  DebtorVM _debtorModel = DebtorVM();
  Debtor _debtor = Debtor();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: constant.green,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                showModalBottomSheet(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40.0),
                    topLeft: Radius.circular(40.0))),
                context: context, 
                builder: (context) => 
                  AddDebtor(debtor: _debtor));
              },
            ),
          ),
        ],
        elevation: 0),
      body: StreamBuilder<Debtor>(
        stream: _debtorModel.streamDebtorById(widget.id),
        builder: (context, snapshot) {
        if (!snapshot.hasData) return Loading();
          _debtor = snapshot.data;
          return Column(
            children: <Widget>[
              Expanded(
                child: DebtorDetail(debtor: snapshot.data)),
              SizedBox(height: 20),
              Expanded(
                flex: 3,
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

  Widget floatingMenu(BuildContext context) {
    return SpeedDial(
      elevation: 0,
      animatedIcon: AnimatedIcons.menu_close,
      backgroundColor: constant.pink,
      children: [

        SpeedDialChild(
          child: Icon(Icons.shopping_cart),
          label: 'Add Debt',
          backgroundColor: constant.green,
          onTap: () {
            showModalBottomSheet(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0))),
              context: context, 
              builder: (context) => 
                AddDebt(debtor: _debtor));
          }
        ),

        SpeedDialChild(
          child: Icon(Icons.payment),
          label: 'Add Payment',
          backgroundColor: constant.peach,
          onTap: () {
            showModalBottomSheet(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(240.0),
                  topLeft: Radius.circular(40.0))),
              context: context, 
              builder: (context) => 
                AddPayment(debtor: _debtor));
          }
        )
      ],
    );
  }
}

class DebtorDetail extends StatefulWidget {

  final Debtor debtor;
  DebtorDetail({this.debtor});

  @override
  _DebtorDetailState createState() => _DebtorDetailState();
}

class _DebtorDetailState extends State<DebtorDetail> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    Logic _logic = Logic();

    return Stack(
      children: <Widget>[
        Container(
          width: width,
          decoration: BoxDecoration(
            color: constant.green,
            borderRadius:
                BorderRadius.only(bottomLeft: Radius.circular(80.0)))),
        Positioned(
          top: height * 0.001,
          left: width * 0.001,
          child: Container(
            width: width * 0.4,
            height: height * 0.2,
            child: SvgPicture.asset('images/collaboration.svg'))
        ),
        Container(
          margin: EdgeInsets.only(
            left: width * 0.4,
            top: height * 0.01),
          padding: EdgeInsets.only(right: 30.0),
          width: width * 0.7,
          height: height * 0.2,
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: (height * 0.2) * 0.2,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(widget.debtor.name,
                    style: constant.subtitle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: constant.bluegreen
                    )),
                ),
              ),
              Container(
                width: double.infinity,
                height: (height * 0.2) * 0.15,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: 
                  widget.debtor.comaker == '' || widget.debtor.comaker == null ? 
                  Text('No co-borrower inputted.',
                    style: constant.subtitle.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey.shade800)) :
                  RichText(
                    text: TextSpan(
                      text: 'Co-Borrower: ',
                      style: constant.subtitle.copyWith(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey.shade800),
                      children: [
                        TextSpan(
                          text: widget.debtor.comaker,
                          style: constant.subtitle.copyWith(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold
                          )
                        )
                      ]
                    )
                  ),
                )
              ),
              SizedBox(
                height: (height * 0.2) * 0.2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            Clipboard.setData(new ClipboardData(text: '${widget.debtor.contact}'));
                            Scaffold.of(context).showSnackBar(
                              new SnackBar(
                                backgroundColor: constant.pink,
                                duration: Duration(seconds: 3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0)
                                  )
                                ),
                                content: Text('Copied ${_logic.formatContact(widget.debtor.contact)} to Clipboard.'))
                            );
                          },
                          child: CircleAvatar(
                            backgroundColor: constant.pink,
                            radius: 25.0,
                            child: Icon(Icons.phone,
                                color: Colors.white), 
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          height: (height * 0.2) * 0.1,
                          child: 
                            Text('${_logic.formatContact(widget.debtor.contact)}',
                              style: constant.subtitle),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: constant.pink,
                          radius: 25.0,
                          child: Icon(Icons.room,
                              color: Colors.white), 
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          height: (height * 0.2) * 0.1,
                          child: Text('${widget.debtor.address}',
                              style: constant.subtitle),
                        )
                      ],
                    ),
                  ),
                  
                  Expanded(
                    child: widget.debtor.altcontact == 0 || widget.debtor.altcontact == null ? 
                    Container() :
                    Column(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: constant.pink,
                          radius: 25.0,
                          child: Icon(Icons.voicemail,
                              color: Colors.white), 
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          height: (height * 0.2) * 0.1,
                          child: 
                            Text('${_logic.formatContact(widget.debtor.altcontact)}',
                              style: constant.subtitle),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )
        )
      ]
    );
  }
}