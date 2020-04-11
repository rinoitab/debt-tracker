import 'package:debttracker/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'due-today-tile.dart';
import 'package:debttracker/model/debt.dart';

class DueTodayList extends StatefulWidget {
  @override
  _DueTodayListState createState() => _DueTodayListState();
}

class _DueTodayListState extends State<DueTodayList> {
  @override
  Widget build(BuildContext context) {

    final debts = Provider.of<List<Debt>>(context);

    if (debts == null) {
      return Loading();
    } else {
      return ListView.builder (
      itemCount: debts.length,
      itemBuilder: (context, index) {
        if (debts == null) return Loading(); 
        return DueTodayTile(debt: debts[index]);
      });
    }
  }
}