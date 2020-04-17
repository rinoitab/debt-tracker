import 'dart:convert';
import 'package:debttracker/model/payables/payables-viewmodel.dart';
import 'package:flutter/services.dart' show rootBundle;

Future<String> _loadPayableAsset() async {
  return await rootBundle.loadString('assets/payables.json');
}

Future<PayablesList> loadPayable() async {
  String json = await _loadPayableAsset();
  final response = jsonDecode(json);
  return new PayablesList.fromJson(response);
}
