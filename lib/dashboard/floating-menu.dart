import 'package:debttracker/page/main/new-debt.dart';
import 'package:debttracker/page/main/new-debtor.dart';
import 'package:debttracker/page/main/new-payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

Widget floatingMenu (BuildContext context) {
  return SpeedDial(
    elevation: 4,
    animatedIcon: AnimatedIcons.menu_close,
    backgroundColor: Color(0xff99b898),
    children: [

      // * floating action button for adding new debtor
      SpeedDialChild(
        child: Icon(Icons.person_add),
        label: 'Add Debtor',
        backgroundColor: Color(0xff99b898),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewDebtor()
            )
          );
        }
      ),

      // * floating action button for adding new debt
      SpeedDialChild(
        child: Icon(Icons.note_add),
        label: 'Add Debt',
        backgroundColor: Color(0xff99b898),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewDebt()
            )
          );
        }
      ),

      // * floating action button for adding new payment
      SpeedDialChild(
        child: Icon(Icons.payment),
        label: 'Add Payment',
        backgroundColor: Color(0xff99b898),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewPayment(),
            )
          );
        }
      )
    ],
  );
}
