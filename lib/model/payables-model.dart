import 'package:cloud_firestore/cloud_firestore.dart';

class Payables {
  final String id;
  final String debtorId;
  final String debtId;
  final double amount;
  final double balance;
  final DateTime date;
  final bool isPaid;


  Payables({
    this.id,
    this.debtorId,
    this.debtId,
    this.amount,
    this.balance,
    this.date,
    this.isPaid});

  Map<String, dynamic> toMap() {
    return {
      'debtorId': debtorId,
      'debtId': debtId,
      'amount': amount,
      'balance': balance,
      'date': date,
      'isPaid': isPaid
    };
  }

  static Payables fromMap(DocumentSnapshot map) {
    if (map == null) return null;

    return Payables(
      debtorId: map.data['debtorId'],
      debtId: map.data['debtId'] ?? '',
      amount: map.data['amount'].toDouble(),
      balance: map.data['balance'].toDouble(),
      date: map.data['date'].toDate(),
      isPaid: map.data['isPaid'],
      id: map.documentID
    );
  }

  static List<Payables> fromSnap(QuerySnapshot snap) {
    return snap.documents.map((map) {
      return Payables(
        debtorId: map.data['debtorId'],
        debtId: map.data['debtId'],
        amount: map.data['amount'].toDouble(),
        balance: map.data['balance'].toDouble(),
        date: map.data['date'].toDate(),
        isPaid: map.data['isPaid'],
        id: map.documentID
      );
    }).toList();
  }
}
