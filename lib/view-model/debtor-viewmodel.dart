import 'package:debttracker/model/debtor-model.dart';
import 'package:debttracker/service/service.dart';
import 'package:flutter/foundation.dart';

class DebtorVM extends Debtor {
 
  final FirestoreService _service = FirestoreService();

  Future addDebtor({@required String name, @required int contact, String address, String comaker, int altcontact}) async {
    return await _service.addDebtor(
      Debtor(
        name: name, 
        contact: contact,
        address: address,
        comaker: comaker,
        altcontact: altcontact
      )
    );
  }

  Future updateDebtor({String id, @required String name, @required int contact, String address, String comaker, int altcontact}) async {
    return await _service.updateDebtor(
      Debtor(
        id: id,
        name: name, 
        contact: contact,
        address: address,
        comaker: comaker,
        altcontact: altcontact
      )
    );
  }

  Stream<Debtor> streamDebtorById(String id) {
    return _service.streamDebtorById(id);
  }

  Stream<List<Debtor>> streamAllDebtors(String search) {
    return _service.streamAllDebtors(search);
  }

}