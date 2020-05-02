import 'package:debttracker/model/debtor-model.dart';
import 'package:debttracker/shared/loading.dart';
import 'package:debttracker/ui/detail/debtor.dart';
import 'package:debttracker/view-model/debtor-viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:debttracker/shared/constant.dart' as constant;

class ListPage extends StatelessWidget {
  final int index;
  const ListPage({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    DebtorVM _debtorModel = DebtorVM();

    return Scaffold(
      appBar: AppBar(
        title: Text('All Debtors')
      ),
      body: FutureBuilder<List<Debtor>>(
        future: _debtorModel.getAllDebtors(),
        builder: (BuildContext context, AsyncSnapshot<List<Debtor>> snap) {
          if(!snap.hasData) return Loading();
          return ListView.builder(
            itemCount: snap.data.length,
            itemBuilder: (context, index) {
              return DebtorList(debtor: snap.data[index], index: index);
            });
        })
    );
  }
}

class DebtorList extends StatelessWidget {
  final Debtor debtor;
  final int index;
  const DebtorList({Key key, this.debtor, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => DebtorPage(id: debtor.id)));
      },
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: constant.green,
            radius: 25,
            child: (index % 2) == 0 ? 
              Icon(Icons.person,
                color: Colors.white,
                size: 35) : 
              Icon(Icons.person_outline,
                color: Colors.white,
                size: 35),
              
          ),
          title: Text(debtor.name,
            style: constant.subtitle.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold
            )),
          subtitle: Row(
            children: <Widget>[
              Icon(Icons.phone,
                color: constant.green),
              SizedBox(width: 8),
              Container(
                width: width * 0.25,
                child: Text('${debtor.contact}',
                  style: constant.subtitle.copyWith(
                    fontSize: 18
                  )),
              ),
              SizedBox(width: 15),
              debtor.address.isEmpty ? Container() : 
              Icon(Icons.location_on,
                color: constant.green),
              SizedBox(width: 8),
              Text('${debtor.address}',
                style: constant.subtitle.copyWith(
                  fontSize: 18
                ))
            ],
          )
        ),
      ),
    );
  }
}