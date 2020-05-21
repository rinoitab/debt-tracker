import 'package:cloud_firestore/cloud_firestore.dart';

class Debtor {
  final String id;
  final String name;
  final String address;
  final int contact;
  final String comaker;
  final int altcontact;


  Debtor({
      this.id,
      this.name,
      this.address,
      this.contact,
      this.comaker,
      this.altcontact});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'contact': contact,
      'comaker': comaker,
      'altcontact': altcontact
    };
  }

  static Debtor fromMap(DocumentSnapshot map) {
    if (map == null) return null;

    return Debtor(
      name: map.data['name'] ?? '',
      address: map.data['address'] ?? '',
      contact: map.data['contact'] ?? 0,
      comaker: map.data['comaker'] ?? '',
      altcontact: map.data['altcontact'] ?? 0,
      id: map.documentID
    );
  }

  static List<Debtor> fromSnap(QuerySnapshot snap) {
    return snap.documents.map((map) {
      return Debtor(
      name: map.data['name'],
      address: map.data['address'] ?? '',
      contact: map.data['contact'],
      altcontact: map.data['altcontact'] ?? 0,
      comaker: map.data['comaker'] ?? '',
      id: map.documentID
    );
    }).toList();
  }
}