import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debttracker/model/debt.dart';

class AccessLayer {

  // * collection reference for debt
  final CollectionReference debtCollection = Firestore.instance.collection('debt');

  // * get debt list from snapshot
  List<Debt> _debtListFromSnapshot (QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return Debt(
        id: doc.documentID,
        debtor: doc.data['debtor'],
        date: doc.data['date'],
        amount: doc.data['amount'],
        desc: doc.data['desc'],
        term: doc.data['term'],
        type: doc.data['type'],
        markup: doc.data['markup'],
        isCompleted: doc.data['isCompleted']
      );
    }).toList();
  }

  // * get debt stream
  Stream<List<Debt>> get debts {
    return debtCollection.snapshots()
    .map(_debtListFromSnapshot);
  }
}