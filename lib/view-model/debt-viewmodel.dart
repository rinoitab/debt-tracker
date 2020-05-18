import 'package:debttracker/model/debt-model.dart';
import 'package:debttracker/service/service.dart';
import 'package:flutter/foundation.dart';

class DebtVM extends Debt{

  final FirestoreService _service = FirestoreService();

  Stream<List<Debt>> streamDebtById(String id) {
    return _service.streamDebtById(id);
  }

  Future<Debt> getDebtById(String id) {
    return _service.getDebtById(id);
  }

  Future addDebt({@required String debtorId, @required DateTime date, double amount, String desc, double term, int type, int markup, double adjustedAmount, double installmentAmount}) async {
    return await _service.addDebt(
      Debt(
        debtorId: debtorId,
        date: date,
        amount: amount,
        balance: adjustedAmount,
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

  Future updateDebt({@required String id, @required String debtorId, @required DateTime date, double amount, String desc, double term, int type, int markup, double adjustedAmount, double installmentAmount, double balance, bool isCompleted}) async {
    return await _service.updateDebt(
      Debt(
        id: id,
        debtorId: debtorId,
        date: date,
        amount: amount,
        balance: balance,
        desc: desc,
        term: term,
        type: type,
        markup: markup,
        adjustedAmount: adjustedAmount,
        installmentAmount: installmentAmount,
        isCompleted: isCompleted
      )
    );
  }
}