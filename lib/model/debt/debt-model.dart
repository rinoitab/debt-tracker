class Debt {

  final String id;
  final String debtorId;
  final DateTime date;
  final double amount;
  final double adjustedAmount;
  final double installmentAmount;
  final String desc;
  final double term;
  final int type;
  final int markup;
  final bool isCompleted;

  Debt({this.id, this.debtorId, this.date, this.amount, this.adjustedAmount, this.installmentAmount, this.desc, this.term, this.type, this.markup, this.isCompleted});

}