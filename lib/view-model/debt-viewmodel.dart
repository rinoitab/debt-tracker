import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debttracker/model/debt-model.dart';
import 'package:debttracker/service/service.dart';
import 'package:flutter/foundation.dart';

class DebtVM extends Debt{

  final FirestoreService _service = FirestoreService();

  Future<List<Debt>> fetchDebts(String id) async {
    return await _service.getDebtsById(id);
  }

  Future addDebt({@required String debtorId, @required DateTime date, double amount, String desc, double term, int type, int markup, double adjustedAmount, double installmentAmount}) async {
    return await _service.addDebt(
      Debt(
        debtorId: debtorId,
        date: date,
        amount: amount,
        balance: amount,
        desc: desc,
        term: term,
        type: type,
        markup: markup,
        adjustedAmount: adjustedAmount,
        installmentAmount: installmentAmount,
        isCompleted: false
      )
    );
  }

  Stream<QuerySnapshot> streamDebtsById(String id) {
    return _service.streamDebtsById(id);
  }
}