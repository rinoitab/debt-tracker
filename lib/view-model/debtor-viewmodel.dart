import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<Debtor> getDebtorById(String id) async {
    return _service.getDebtorById(id);
  }

  Future<List<Debtor>> getAllDebtors() async {
    return _service.getAllDebtors();
  }

  Stream<QuerySnapshot> streamAllDebtors() {
    return _service.streamAllDebtors();
  }

}