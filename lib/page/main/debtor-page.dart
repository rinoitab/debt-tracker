import 'package:debttracker/database/access.dart';
import 'package:debttracker/model/debtor.dart';
import 'package:debttracker/page/list/debtor-profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DebtorDetails extends StatefulWidget {
  @override
  _DebtorDetailsState createState() => _DebtorDetailsState();
}

class _DebtorDetailsState extends State<DebtorDetails> {

  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context).settings.arguments;
    
    setState(() {
      AccessLayer().setDebtor(id);
      AccessLayer().debtor;
    });

    return Scaffold(
        appBar: AppBar(
          elevation: 0),
          body: DebtorProfile(),
    );
  }
}