import 'package:debttracker/model/payables/payables-model.dart';

class PayablesList {
  final List<Payables> payable;

  PayablesList({this.payable});

  factory PayablesList.fromJson(List<dynamic> json) {
    List<Payables> payable = new List<Payables>();
    payable = json.map((f)=>Payables.fromJson(f)).toList();
    return new PayablesList(
      payable: payable
    );
  }
}