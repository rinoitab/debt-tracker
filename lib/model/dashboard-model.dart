import 'dart:ui';
import 'package:charts_flutter/flutter.dart' as chart;

class Dashboard {
  int dueToday;
  double monthlyEarnings;
  int completed;
  int pending;

  Dashboard({
    this.dueToday, 
    this.monthlyEarnings, 
    this.completed, 
    this.pending, }){
    dueToday = 32;
    monthlyEarnings = 43000.00;
    completed = 56;
    pending = 34;
  }
}

class Earnings {
  final String month;
  final double earning;
  final chart.Color color;

  Earnings(this.month, this.earning, Color color) 
    : this.color = new chart.Color(
      r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
