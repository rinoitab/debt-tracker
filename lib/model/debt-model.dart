import 'package:cloud_firestore/cloud_firestore.dart';
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

  static Debt fromMap(DocumentSnapshot map) {
    if (map == null) return null;

    return Debt(
      debtorId: map.data['debtorId'],
      date: map.data['date'].toDate(),
      amount: map.data['amount'].toDouble(),
      balance: map.data['balance'].toDouble(),
      adjustedAmount: map.data['adjustedAmount'],
      installmentAmount: map.data['installmentAmount'],
      desc: map.data['desc'],
      term: map.data['term'].toDouble(),
      type: map.data['type'],
      markup: map.data['markup'],
      isCompleted: map.data['isCompleted'],
      id: map.documentID
    );
  }

  static List<Debt> fromSnap(QuerySnapshot snap) {
    return snap.documents.map((map) {
      return Debt(
      debtorId: map.data['debtorId'],
      date: map.data['date'].toDate(),
      amount: map.data['amount'].toDouble(),
      balance: map.data['balance'].toDouble(),
      adjustedAmount: map.data['adjustedAmount'].toDouble(),
      installmentAmount: map.data['installmentAmount'].toDouble(),
      desc: map.data['desc'],
      term: map.data['term'].toDouble(),
      type: map.data['type'],
      markup: map.data['markup'],
      isCompleted: map.data['isCompleted'],
      id: map.documentID
    );
    }).toList();
  }
}
