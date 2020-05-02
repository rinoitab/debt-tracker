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
    return await _debtorReference.add(debtor.toMap());
  }

  Future<Debtor> getDebtorById(String id) async {
    return await _debtorReference.document(id).get().then((doc) { 
      return Debtor.fromMap(doc.data, doc.documentID);
      });
  }

  Stream<QuerySnapshot> streamAllDebtors() {
    return _debtorReference
      .orderBy('name')
      .snapshots();
  }

  Future<List<Debtor>> getAllDebtors() async {
    var _debtor = await _debtorReference
      .getDocuments();

    return _debtor.documents
      .map((snap) => Debtor.fromMap(snap.data, snap.documentID))
      .toList();
  }

  // * Debt-related Queries

  Future<List<Debt>> getDebtsById(String id) async {
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

  Stream<QuerySnapshot> streamDebtsById(String id) {
    return _debtReference
      .where('debtorId', isEqualTo: id)
      .snapshots();
  }

  // * Payable-related Queries

  Future<List<Payables>> getDueToda1y() async {
    var _due = await _payableReference
      .where('date', isGreaterThanOrEqualTo: DateTime.now().subtract(Duration(days: 1)))
      .where('date',isLessThanOrEqualTo: DateTime.now().add(Duration(days: 1)))
      .getDocuments();
    
    return _due.documents
      .map((snap) => Payables.fromMap(snap.data, snap.documentID))
      .toList();
  }

  Stream<List<Payables>> getDueToday() {
    var _due = _payableReference
      .where('date', isGreaterThanOrEqualTo: DateTime.now().subtract(Duration(days: 1)))
      .where('date',isLessThanOrEqualTo: DateTime.now().add(Duration(days: 1)))
      .snapshots();

    return _due.map((snap) => Payables.fromSnap(snap));
    
  }

  Future<List<Payables>> getOverduePayables() async {
    var _overdue = await _payableReference
      .where('date', isLessThan: Timestamp.now())
      .getDocuments();
    
    return _overdue.documents
      .map((snap) => Payables.fromMap(snap.data, snap.documentID))
      .toList();
  }

  Future addPayable(Payables payables) async {
    return await _payableReference.add(payables.toMap());
  }
}