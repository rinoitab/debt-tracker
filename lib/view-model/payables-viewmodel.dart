import 'package:debttracker/model/payables-model.dart';
import 'package:debttracker/service/service.dart';
import 'package:flutter/foundation.dart';

class PayablesVM extends Payables {

  final FirestoreService _service = FirestoreService();

  Future<List<Payables>> getOverduePayables() async {
    return await _service.getOverduePayables();
  }

  Stream<List<Payables>> getDueToday() {
    return _service.getDueToday();
  }

  Future addPayable({@required String debtorId, @required String debtId, DateTime date, double amount}) async {
    return await _service.addPayable(
      Payables(
        debtorId: debtorId,
        debtId: debtorId,
        date: date,
        amount: amount,
        isPaid: false
      )
    );
  }
}