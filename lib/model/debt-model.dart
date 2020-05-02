import 'package:debttracker/model/debtor-model.dart';

class Debt {
  final String id;
  final String debtorId;
  final DateTime date;
  final double amount;
  final double balance;
  final double adjustedAmount;
  final double installmentAmount;
  final String desc;
  final double term;
  final int type;
  final int markup;
  final bool isCompleted;
  final Debtor debtor;

  Debt({
    this.id,
    this.debtorId,
    this.date,
    this.amount,
    this.balance,
    this.adjustedAmount,
    this.installmentAmount,
    this.desc,
    this.term,
    this.type,
    this.markup,
    this.isCompleted,
    this.debtor});

    Map<String, dynamic> toMap() {
    return {
      'debtorId': debtorId,
      'date': date,
      'amount': amount,
      'balance': balance,
      'adjustedAmount': adjustedAmount,
      'installmentAmount': installmentAmount,
      'desc': desc,
      'term': term,
      'type': type,
      'markup': markup,
      'isCompleted': isCompleted,
    };
  }

  static Debt fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) return null;

    return Debt(
      debtorId: map['debtorId'],
      date: map['date'].toDate(),
      amount: map['amount'].toDouble(),
      balance: map['balance'].toDouble(),
      adjustedAmount: map['adjustedAmount'],
      installmentAmount: map['installmentAmount'],
      desc: map['desc'],
      term: map['term'].toDouble(),
      type: map['type'],
      markup: map['markup'],
      isCompleted: map['isCompleted'],
      id: documentId
    );
  }
}
