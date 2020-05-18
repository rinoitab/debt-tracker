import 'dart:ui';
import 'package:charts_flutter/flutter.dart' as chart;
class Earnings {
  final String month;
  final double earning;
  final chart.Color color;

  Earnings(this.month, this.earning, Color color) 
    : this.color = new chart.Color(
      r: color.red, g: color.green, b: color.blue, a: color.alpha);
}
