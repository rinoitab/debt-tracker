import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debttracker/model/combine-stream.dart';
import 'package:debttracker/model/debt-model.dart';
import 'package:debttracker/model/debtor-model.dart';
import 'package:debttracker/model/payables-model.dart';
import 'package:debttracker/model/payment-model.dart';
import 'package:rxdart/rxdart.dart';


class FirestoreService {

  final CollectionReference _debtorReference = Firestore.instance.collection('debtor');
  final CollectionReference _payableReference = Firestore.instance.collection('payables');
  final CollectionReference _debtReference = Firestore.instance.collection('debt');
  final CollectionReference _paymentReference = Firestore.instance.collection('payment');


  // * Debtor-related Queries
  Future addDebtor(Debtor debtor) async {
    return await _debtorReference.add(debtor.toMap());
  }

  Future updateDebtor(Debtor debtor) async {
    return await _debtorReference.document(debtor.id).updateData(debtor.toMap());
  }

  Stream<Debtor> streamDebtorById(String id) {
    var _debtor = _debtorReference.document(id).snapshots();
    return _debtor.map((snap) => Debtor.fromMap(snap));
  }

  Stream<List<Debtor>> streamAllDebtors(String search) {
    var _debtors = _debtorReference
      .where('name', isGreaterThanOrEqualTo: search)
      .snapshots();
    return _debtors.map((snap) => Debtor.fromSnap(snap));
  }

  // * Debt-related Queries
  Future addDebt(Debt debt) async {
    return await _debtReference.add(debt.toMap());
  }

  Future updateDebt(Debt debt) async {
    return await _debtReference.document(debt.id).updateData(debt.toMap());
  }

  Future<Debt> getDebtById(String id) {
    return _debtReference
      .document(id)
      .get()
      .then((map) => Debt.fromMap(map));
  }

  Stream<List<Debt>> streamDebtById(String id) {
    var _debt = _debtReference
      .where('debtorId', isEqualTo: id)
      .snapshots();
    return _debt.map((snap) => Debt.fromSnap(snap));
  }

  // * Payable-related Queries

  Future addPayable(Payables payables) async {
    return await _payableReference.add(payables.toMap());
  }

  Future updatePayable(Payables payable) async {
    return await _payableReference.document(payable.id).updateData(payable.toMap());
  }

  Future<List<Payables>> getPayablesById(String id) {
    return _payableReference
      .where('debtId', isEqualTo: id)
      .getDocuments()
      .then((map) => Payables.fromSnap(map));
  }

  // * Payment-related Queries
  Future addPayment(Payment payment) async {
    return await _paymentReference.add(payment.toMap());
  }

  Stream<List<Payment>> streamPaymentById(String id) {
    var _payment = _paymentReference
      .where('debtId', isEqualTo: id)
      .snapshots();
    return _payment.map((snap) => Payment.fromSnap(snap));
  }

  Stream<List<Payment>> getEarnings() {
    var _payment = _paymentReference
      .snapshots();

    return _payment.map((event) => Payment.fromSnap(event));
  }

  // * Combined Streams
  Stream<List<CombineStream>> streamDueToday() {
    var _due = _payableReference
      .where('date', isGreaterThanOrEqualTo: DateTime.now().subtract(Duration(days: 1)))
      .where('date',isLessThanOrEqualTo: DateTime.now().add(Duration(days: 1)))
      .snapshots()
      .map((convert) {
        return convert.documents.map((f) {
          Stream<Payables> payables = Stream.value(f)
            .map<Payables>((_payableDocument) => Payables.fromMap(_payableDocument));

          Stream<Debtor> debtor = _debtorReference
            .document(f.data['debtorId'])
            .snapshots()
            .map<Debtor>((_debtorDocument) => Debtor.fromMap(_debtorDocument));

          Stream<Debt> debt = _debtReference
            .document(f.data['debtId'])
            .snapshots()
            .map<Debt>((_debtDocument) => Debt.fromMap(_debtDocument));

          return Rx.combineLatest3(payables, debtor, debt, (payables, debtor, debt) =>
            CombineStream(payables: payables, debtor: debtor, debt: debt));
        });
      });

    return _due.switchMap((observables) {
        return observables.length > 0
          ? Rx.combineLatestList(observables)
          : Stream.value([]);
      });
  }

  Stream<List<CombineStream>> streamOverdue() {
    var _overdue = _payableReference
      .where('date', isLessThan: Timestamp.now())      
      .snapshots()
      .map((convert) {
        return convert.documents.map((f) {
          Stream<Payables> payables = Stream.value(f)
            .map<Payables>((_payableDocument) => Payables.fromMap(_payableDocument));

          Stream<Debtor> debtor = _debtorReference
            .document(f.data['debtorId'])
            .snapshots()
            .map<Debtor>((_debtorDocument) => Debtor.fromMap(_debtorDocument));

          Stream<Debt> debt = _debtReference
            .document(f.data['debtId'])
            .snapshots()
            .map<Debt>((_debtDocument) => Debt.fromMap(_debtDocument));

          return Rx.combineLatest3(payables, debtor, debt, (payables, debtor, debt) =>
            CombineStream(payables: payables, debtor: debtor, debt: debt));
        });
      });

    return _overdue.switchMap((observables) {
        return observables.length > 0
          ? Rx.combineLatestList(observables)
          : Stream.value([]);
      });
  }

  Stream<List<CombineStream>> streamPendingDebts() {
    var _pending = _debtReference
      .where('isCompleted', isEqualTo: false)    
      .snapshots()
      .map((convert) {
        return convert.documents.map((f) {
          Stream<Debt> debt = Stream.value(f)
            .map<Debt>((_debtDocument) => Debt.fromMap(_debtDocument));

          Stream<Debtor> debtor = _debtorReference
            .document(f.data['debtorId'])
            .snapshots()
            .map<Debtor>((_debtorDocument) => Debtor.fromMap(_debtorDocument));

          return Rx.combineLatest2(debt, debtor, (debt, debtor) =>
            CombineStream(debtor: debtor, debt: debt));
        });
      });

    return _pending.switchMap((observables) {
        return observables.length > 0
          ? Rx.combineLatestList(observables)
          : Stream.value([]);
      });
  }

  Stream<List<CombineStream>> streamAllDebts() {
    var _pending = _debtReference
      .snapshots()
      .map((convert) {
        return convert.documents.map((f) {
          Stream<Debt> debt = Stream.value(f)
            .map<Debt>((_debtDocument) => Debt.fromMap(_debtDocument));

          Stream<Debtor> debtor = _debtorReference
            .document(f.data['debtorId'])
            .snapshots()
            .map<Debtor>((_debtorDocument) => Debtor.fromMap(_debtorDocument));

          return Rx.combineLatest2(debt, debtor, (debt, debtor) =>
            CombineStream(debtor: debtor, debt: debt));
        });
      });

    return _pending.switchMap((observables) {
        return observables.length > 0
          ? Rx.combineLatestList(observables)
          : Stream.value([]);
      });
  }
}



