import 'package:debttracker/ui/dashboard/dashboard-card.dart';
import 'package:debttracker/ui/form/debt/add-debt.dart';
import 'package:debttracker/ui/form/debtor/add-debtor.dart';
import 'package:debttracker/ui/form/payment/add-payment.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              searchBox(),

              Container(
                padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                child: Wrap(
                  children: <Widget>[
                    dueToday(context),
                    overdue(context),
                    monthlyEarnings(context), 
                    yearlyEarnings(context),
                    pending(context),
                    completed(context)
                  ],
                ),
              ),
            ],
          )
        ),
      ),

      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 10.0, bottom: 15.0),
        child: floatingMenu(context),
      ),
    );
  }
}


// * Search Box
// todo: Add search functionality to be able to search Debtor name
// todo: once suggested result is clicked, it should redirect to Debtor profile
Widget searchBox() {
  return Container(
    height: 80.0,
    width: double.maxFinite,
    child: SearchBar(
      onSearch: null,
      onItemFound: null,
      searchBarPadding: EdgeInsets.symmetric(horizontal: 10.0),
      iconActiveColor: Colors.green[400],
      searchBarStyle: SearchBarStyle(
        borderRadius: BorderRadius.circular(30.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0),
      ),
    ),
  );
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