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

    final debt = Provider.of<List<Debt>>(context);

    if (debt == null) {
      return Loading();
    } else {
      return ListView.builder (
      itemCount: debt.length,
      itemBuilder: (context, index) {
        if (debt == null) return Loading(); 
        return DueTodayTile(debt: debt[index]);
      });
    }
  }
}