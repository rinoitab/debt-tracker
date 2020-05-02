import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debttracker/model/debt-model.dart';
import 'package:debttracker/model/debtor-model.dart';

class Payables {
  final String id;
  final String debtorId;
  final String debtId;
  final double amount;
  final DateTime date;
  final bool isPaid;
  final Debtor debtor;
  final Debt debt;

  Payables({
    this.id,
    this.debtorId,
    this.debtId,
    this.amount,
    this.date,
    this.isPaid,
    this.debtor,
    this.debt});

  Map<String, dynamic> toMap() {
    return {
      'debtorId': debtorId,
      'debtId': debtId,
      'amount': amount,
      'date': date,
      'isPaid': isPaid
    };
  }

  static Payables fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) return null;

    return Payables(
      debtorId: map['debtorId'],
      debtId: map['debtId'],
      amount: map['amount'].toDouble(),
      date: map['date'].toDate(),
      isPaid: map['isPaid'],
      id: documentId
    );
  }

  static List<Payables> fromSnap(QuerySnapshot snap) {
    return snap.documents.map((map) {
      return Payables(
      debtorId: map.data['debtorId'],
      debtId: map['debtId'],
      amount: map['amount'].toDouble(),
      date: map['date'].toDate(),
      isPaid: map['isPaid'],
      id: map.documentID
    );
    }).toList();
  }
}
