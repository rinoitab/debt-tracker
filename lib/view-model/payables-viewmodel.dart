import 'package:debttracker/model/payables-model.dart';
import 'package:debttracker/service/service.dart';
import 'package:flutter/foundation.dart';

class PayablesVM extends Payables {

  final FirestoreService _service = FirestoreService();

  Future<List<Payables>> fetchOverdue() async {
    return await _service.getOverdue();
  }

  Future addPayable({@required String debtorId, @required String debtId, DateTime date, double amount}) async {
    await _service.addPayable(
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