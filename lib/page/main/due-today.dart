import 'package:debttracker/page/list/due-today-list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:debttracker/database/access.dart';
import 'package:debttracker/model/debt.dart';

class DueToday extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Debt>>.value(
        value: AccessLayer().duetoday,
        child: Scaffold(
        appBar: AppBar(title: Text('Due Today')),
        body: DueTodayList(),
      ),
    );
  }
}