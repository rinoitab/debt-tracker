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

  static Debtor fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) return null;

    return Debtor(
      name: map['name'],
      address: map['address'] ?? '',
      contact: map['contact'],
      comaker: map['comaker'] ?? '',
      altcontact: map['altcontact'] ?? 0,
      id: documentId
    );
  }
}