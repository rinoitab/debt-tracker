import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:debttracker/shared/constant.dart' as constant;
import 'package:debttracker/ui/dashboard/dashboard-card.dart';
import 'package:debttracker/ui/form/debt/add-debt.dart';
import 'package:debttracker/ui/form/debtor/add-debtor.dart';
import 'package:debttracker/ui/form/payment/add-payment.dart';


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: new IconThemeData(color: constant.green),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: DashboardCard()
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 10.0, bottom: 10.0),
        child: floatingMenu(context),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.warning,
                color: constant.green),
              title: Text('Pending'),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              leading: Icon(Icons.done,
                color: constant.green),
              title: Text('Completed'),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              leading: Icon(Icons.person,
                color: constant.green),
              title: Text('All Debtors'),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              leading: Icon(Icons.monetization_on,
                color: constant.green),
              title: Text('All Debts'),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        )
      ),
    );
  }
}

// * Floating Menu for add functionality
Widget floatingMenu (BuildContext context) {
  return SpeedDial(
    elevation: 0,
    animatedIcon: AnimatedIcons.menu_close,
    backgroundColor: Color(0xff99b898),
    children: [

      // * Add New Debtor
      SpeedDialChild(
        child: Icon(Icons.person_add),
        label: 'Add Debtor',
        backgroundColor: Color(0xff99b898),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddDebtor()
            ));
        }
      ),

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