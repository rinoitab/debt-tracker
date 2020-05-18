import 'package:debttracker/model/debt-model.dart';
import 'package:debttracker/model/debtor-model.dart';
import 'package:debttracker/model/payables-model.dart';
import 'package:debttracker/model/payment-model.dart';

class CombineStream {
  final Debtor debtor;
  final Debt debt;
  final Payables payables;
  final Payment payment;

  CombineStream({this.debtor, this.debt, this.payables, this.payment});
}