class Payment {

  final String id;
  final String debtorId;
  final String debtId;
  final String payableId;
  final DateTime date;
  final double amount;

  Payment({this.id, this.debtorId, this.debtId, this.payableId, this.date, this.amount});

}