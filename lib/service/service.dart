import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debttracker/model/debt-model.dart';
import 'package:debttracker/model/debtor-model.dart';
import 'package:debttracker/model/payables-model.dart';


class FirestoreService {

  final CollectionReference _debtorReference = Firestore.instance.collection('debtor');
  final CollectionReference _payableReference = Firestore.instance.collection('payables');
  final CollectionReference _debtReference = Firestore.instance.collection('debt');

  // * Debtor-related Queries
  Future addDebtor(Debtor debtor) async {
    await _debtorReference.add(debtor.toMap());
  }

  Future<Debtor> getDebtor(String id) async {
    return await _debtorReference.document(id).get().then((doc) { 
      return Debtor.fromMap(doc.data, doc.documentID);
      });
  }

  Stream<QuerySnapshot> debtorForDropdown() {
    return _debtorReference
      .orderBy('name')
      .snapshots();
  }

  // * Debt-related Queries
  Future<List<Debt>> getDebt(String id) async {
    var _debt = await _debtReference
      .where('debtorId', isEqualTo: id)
      .getDocuments();

    return _debt.documents
      .map((snap) => Debt.fromMap(snap.data, snap.documentID))
      .toList();
  }

  Future addDebt(Debt debt) async {
    return await _debtReference.add(debt.toMap());
  }

  // * Payable-related Queries
  Future<List<Payables>> getOverdue() async {
    var _overdue = await _payableReference
      .where('date', isLessThan: Timestamp.now())
      .getDocuments();
    
    return _overdue.documents
      .map((snap) => Payables.fromMap(snap.data, snap.documentID))
      .toList();
  }

  Future addPayable(Payables payables) async {
    await _payableReference.add(payables.toMap());
  }
}