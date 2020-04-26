import 'package:debttracker/model/debtor-model.dart';

class Payables {
  final String id;
  final String debtorId;
  final String debtId;
  final double amount;
  final DateTime date;
  final bool isPaid;
  final Debtor debtor;

  Payables({
    this.id,
    this.debtorId,
    this.debtId,
    this.amount,
    this.date,
    this.isPaid,
    this.debtor});

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
}
