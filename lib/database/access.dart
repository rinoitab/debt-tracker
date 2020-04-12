import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:debttracker/model/debt.dart';
import 'package:debttracker/model/debtor.dart';

class AccessLayer {

  String id;
  AccessLayer({this.id});

  // * collection references
  final CollectionReference debtCollection = Firestore.instance.collection('debt');
  final CollectionReference debtorCollection = Firestore.instance.collection('debtor');

  // * get debt list from snapshot
  List<Debt> _debtListFromSnapshot (QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      return Debt(
        id: doc.documentID,
        debtorId: doc.data['debtor-id'],
        name: doc.data['debtor-name'],
        address: doc.data['debtor-address'],
        contact: doc.data['debtor-contact'],
        date: doc.data['date'].toDate(),
        amount: doc.data['amount'].toDouble(),
        adjustedAmount: doc.data['adjusted-amount'].toDouble(),
        installment: doc.data['installment-amount'].toDouble(),
        desc: doc.data['desc'],
        term: doc.data['term'].toDouble(),
        type: doc.data['type'],
        markup: doc.data['markup'],
        isCompleted: doc.data['is-completed'],
      );
    }).toList();
  }

 Debtor _debtorProfile (DocumentSnapshot doc) {
    return Debtor(
      id: doc.documentID,
      name: doc.data['name'],
      address: doc.data['address'],
      contact: doc.data['contact'],
      comaker: doc.data['comaker'],
      cocontact: doc.data['altcontact']
    );
  }

  void setDebtor (String id) {
    id = id;
    debtor;
  }

  // * get debtor
  Stream<Debtor> get debtor {
    return debtorCollection.document(id).snapshots()
      .map(_debtorProfile);
  }

  // * get due today stream
  Stream<List<Debt>> get duetoday {
    return debtCollection.where('date', isGreaterThan: DateTime.now().add(Duration(days: -1)))
                      .where('date', isLessThan: DateTime.now().add(Duration(days: 1)))
                      .snapshots()
                      .map(_debtListFromSnapshot);
  }

}