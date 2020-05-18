import 'package:debttracker/model/payment-model.dart';
import 'package:debttracker/service/service.dart';
import 'package:flutter/foundation.dart';

class PaymentVM extends Payment {

  final FirestoreService _service = FirestoreService();

  Future addPayment(
    {@required debtorId, @required debtId, @required date, @required amount}) async {
    return await _service.addPayment(
      Payment(
        debtorId: debtorId,
        debtId: debtId,
        date: date,
        amount: amount
      )
    );
  }

  Stream<List<Payment>> streamPaymentById(String id) {
    return _service.streamPaymentById(id);
  }

  Stream<List<Payment>> getEarnings() {  
    return _service.getEarnings();
  }
}