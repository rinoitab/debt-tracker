import 'package:cloud_firestore/cloud_firestore.dart';

class Debt {

  final String id;
  final String debtorId;
  final String name;
  final String address;
  final int contact;
  final DateTime date;
  final double amount;
  final double adjustedAmount;
  final double installment;
  final String desc;
  final double term;
  final int type;
  final int markup;
  final bool isCompleted;

  Debt({this.id, this.debtorId, this.name, this.address, this.contact, this.date, this.amount, this.adjustedAmount, this.installment, this.desc, this.term, this.type, this.markup, this.isCompleted});

  
}