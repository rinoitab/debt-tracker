
import 'package:cloud_firestore/cloud_firestore.dart';

class Payment {

  final String id;
  final String debtorId;
  final String debtId;
  final String payableId;
  final DateTime date;
  final double amount;

  Payment({this.id, this.debtorId, this.debtId, this.payableId, this.date, this.amount});

  Map<String, dynamic> toMap() {
    return {
      'debtorId': debtorId,
      'debtId': debtId,
      'date': date,
      'amount': amount
    };
  }

  static List<Payment> fromSnap(QuerySnapshot snap) {
    return snap.documents.map((map) {
      return Payment(
      debtorId: map.data['debtorId'],
      debtId: map['debtId'],
      amount: map.data['amount']?.toDouble() ?? 0.0,
      date: map.data['date']?.toDate() ?? DateTime.now(),
      id: map.documentID
    );
    }).toList();
  }

}

