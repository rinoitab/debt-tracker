import 'package:cloud_firestore/cloud_firestore.dart';

class Debt {

  final String id;
  final String debtor;
  final Timestamp date;
  final int amount;
  final String desc;
  final int term;
  final int type;
  final int markup;
  final bool isCompleted;

  Debt({this.id, this.debtor, this.date, this.amount, this.desc, this.term, this.type, this.markup, this.isCompleted});

}