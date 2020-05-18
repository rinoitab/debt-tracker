import 'package:debttracker/model/debtor-model.dart';
import 'package:debttracker/service/logic.dart';
import 'package:debttracker/shared/loading.dart';
import 'package:debttracker/ui/detail/debtor.dart';
import 'package:debttracker/view-model/debtor-viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:debttracker/shared/constant.dart' as constant;

class DebtorsList extends StatefulWidget {
  @override
  _DebtorsListState createState() => _DebtorsListState();
}

class _DebtorsListState extends State<DebtorsList> {
  DebtorVM _debtorModel = DebtorVM();
  String search = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: constant.green,
            elevation: 0,
            title: Text('All Debtors')),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: TextFormField(
                  decoration: constant.form.copyWith(
                      suffixIcon: Icon(Icons.search, color: constant.pink)),
                  onChanged: (value) {
                    setState(() {
                      search = value;
                      _debtorModel.streamAllDebtors(search).drain();
                    });
                  },
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: StreamBuilder<List<Debtor>>(
                stream: _debtorModel.streamAllDebtors(search),
                builder: (context, snap) {
                  if (!snap.hasData) return Loading();
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snap.data.length,
                      itemBuilder: (context, index) {
                        if (snap.data[index].name
                              .toLowerCase()
                              .contains(search.toLowerCase()))
                          return DebtorsListTile(debtor: snap.data[index]);
                      });
              }
            )),
          ],
        ));
  }
}

class DebtorsListTile extends StatefulWidget {
  final Debtor debtor;
  DebtorsListTile({this.debtor});

  @override
  _DebtorsListTileState createState() => _DebtorsListTileState();
}

class _DebtorsListTileState extends State<DebtorsListTile> {
  @override
  Widget build(BuildContext context) {

    Logic _logic = Logic();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: ListTile(
        isThreeLine: true,
        onTap: () {
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => DebtorPage(debtor: widget.debtor, id: widget.debtor.id)));
        },
        title: Text(widget.debtor.name,
            style: constant.subtitle.copyWith(
                color: constant.bluegreen,
                fontSize: 25.0,
                fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            widget.debtor.address.isNotEmpty ?
            Text(widget.debtor.address,
                style: constant.subtitle
                    .copyWith(fontSize: 18.0, fontWeight: FontWeight.bold)) :
            Container(),
            Text(_logic.formatContact(widget.debtor.contact),
                style: constant.subtitle
                    .copyWith(fontSize: 18.0))
          ],
        ),
      ),
    );
  }
}
