import 'package:debttracker/model/payables-model.dart';
import 'package:debttracker/service/service.dart';
import 'package:flutter/foundation.dart';

class PayablesVM extends Payables {

  final FirestoreService _service = FirestoreService();

  Future addPayable({@required String debtorId, @required String debtId, DateTime date, double amount}) async {
    return await _service.addPayable(
      Payables(
        debtorId: debtorId,
        debtId: debtId,
        date: date,
        amount: amount,
        balance: amount,
        isPaid: false
      )
    );
  }

  Future updatePayable({@required String id, @required String debtorId, @required String debtId, DateTime date, double amount, double balance, bool isPaid}) async {
    return await _service.updatePayable(
      Payables(
        id: id,
        debtorId: debtorId,
        debtId: debtId,
        date: date,
        amount: amount,
        balance: balance,
        isPaid: isPaid
      )
    );
  }

  Future<List<Payables>> getPayablesById(String id) {
    return _service.getPayablesById(id);
  }
}