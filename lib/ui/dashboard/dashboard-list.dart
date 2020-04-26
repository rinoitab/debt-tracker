import 'package:debttracker/model/dashboard-model.dart';
import 'package:debttracker/model/payables-model.dart';
import 'package:debttracker/shared/loading.dart';
import 'package:debttracker/ui/detail/debtor.dart';
import 'package:debttracker/view-model/payables-viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:debttracker/shared/constant.dart' as constant;
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DashboardList extends StatefulWidget {
  @override
  _DashboardListState createState() => _DashboardListState();
}

class _DashboardListState extends State<DashboardList> {
  
  Dashboard dashboard = Dashboard();
  PayablesVM overdue = PayablesVM();
  Future<List<Payables>> payable;

  @override
  void initState() {
    super.initState();
    payable = overdue.fetchOverdue();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;


    Map<String, double> dashChart2 = new Map();
    dashChart2.putIfAbsent("Overdue", () => dashboard.overdue.toDouble());
    dashChart2.putIfAbsent("Pending", () => dashboard.pending.toDouble());


    return Container(
        width: width > 600
            ? width * .5
            : width > 400 ? width * 0.95 : width * 0.94,
        height: width > 600
            ? height * 0.58
            : width > 400 ? height * 0.55 : height * 0.5,
        child: Column(children: <Widget>[
          Container(
            height: width > 600 ? height * 0.08 : height * 0.07,
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 10),
                  child: Text('Overdue Debts',
                    style: constant.subtitle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 28)),
                ),
                GestureDetector(
                  child: Card(
                    margin: EdgeInsets.only(top: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: Text('Refresh',
                        style: constant.subtitle.copyWith(
                          color: Colors.white,
                          fontSize: 15
                        )),
                    ),
                    color: constant.green,
                  ),
                  onTap: () async {
                    setState(() {
                      payable = overdue.fetchOverdue();
                    });
                  },
                )
              ],
            )
            
          ),
          SingleChildScrollView(
          child: Container(
            width: width,
            height: width > 600 ? height * 0.5 : width > 400 ? height * 0.48 : height * 0.42,
            child: FutureBuilder<List<Payables>>(
              future: payable,
              builder: (BuildContext context, AsyncSnapshot<List<Payables>> snap) {
                if (!snap.hasData) return Loading();
                return ListView.builder(
                  itemCount: snap.data.length,
                  itemBuilder: (context, index) {
                    if(snap.data[index].isPaid == false) {
                      return DashboardListTile(overdue: snap.data[index]);
                    } 
                  });
              })
          ))
        ]));
  }
}

class DashboardListTile extends StatelessWidget {

  final Payables overdue;
  const DashboardListTile({Key key, this.overdue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cur = new NumberFormat.simpleCurrency(name: 'PHP');
    double width = MediaQuery.of(context).size.width;

    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      elevation: 0,
      child: ListTile(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DebtorPage(id: overdue.debtorId)));
        },
        leading: CircleAvatar(
            radius: 25,
            backgroundColor: constant.red,
            child: Text('-45',
                style:
                    constant.subtitle.copyWith(color: Colors.white))),
        title: Text('${overdue.debtorId}',
            style: constant.subtitle
                .copyWith(fontSize: width > 600 ? 18 : 15)),
        subtitle: Text('Balance: ' + cur.format(overdue.amount), 
          style: constant.subtitle),
        trailing: CircularPercentIndicator(
          radius: 40,
          percent: 0.3,
          backgroundColor: Colors.grey[200],
          progressColor: constant.red,
          center: Text('34'),
        ),
      )
    );
  }
}
