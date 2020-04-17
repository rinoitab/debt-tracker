class Payables {

  final String id;
  final String debtorId;
  final String debtId;
  final double amount;
  final String date;
  final bool isPaid;

  Payables({this.id, this.debtorId, this.debtId, this.amount, this.date, this.isPaid});

  factory Payables.fromJson(Map<String, dynamic> json) {
    return new Payables(
      id: json['id'],
      debtorId: json['debtorId'],
      debtId: json['debtId'],
      amount: json['amount'].toDouble(),
      date: json['date'],
      isPaid: json['isPaid']
    );
  }
  
}