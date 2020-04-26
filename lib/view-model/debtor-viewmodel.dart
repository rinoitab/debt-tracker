import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debttracker/model/debtor-model.dart';
import 'package:debttracker/service/service.dart';
import 'package:flutter/foundation.dart';

class DebtorVM extends Debtor {
 
  final FirestoreService _service = FirestoreService();

  Future addDebtor({@required String name, @required int contact, String address, String comaker, int altcontact}) async {
    await _service.addDebtor(
      Debtor(
        name: name, 
        contact: contact,
        address: address,
        comaker: comaker,
        altcontact: altcontact
      )
    );
  }

  Future<Debtor> getDebtor(String id) async {
    return _service.getDebtor(id);
  }

  Stream<QuerySnapshot> fetchDebtorForDropdown() {
    return _service.debtorForDropdown();
  }

}