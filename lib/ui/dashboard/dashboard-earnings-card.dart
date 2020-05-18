import 'package:debttracker/model/dashboard-model.dart';
import 'package:debttracker/model/payment-model.dart';
import 'package:debttracker/service/logic.dart';
import 'package:debttracker/view-model/payment-viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as chart;
import 'package:debttracker/shared/constant.dart' as constant;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class DashboardEarningsCard extends StatefulWidget {
  @override
  _DashboardEarningsCardState createState() => _DashboardEarningsCardState();
}

class _DashboardEarningsCardState extends State<DashboardEarningsCard> {

  PaymentVM _paymentModel = PaymentVM();
  Logic _logic = Logic();

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final cur = new NumberFormat.simpleCurrency(name: 'PHP');

    return Stack(
      children: <Widget>[
        Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          margin: EdgeInsets.only(top: height * 0.1),
          color: constant.green,
          child: Container(
            width: width,
            height: height * 0.25,
            margin: EdgeInsets.all(30.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text('Welcome back, Ellen!',
                          style: constant.subtitle.copyWith(
                              color: constant.bluegreen,
                              fontWeight: FontWeight.bold)),
                    )),
                    Expanded(
                      child: StreamBuilder<List<Payment>>(
                        stream: _paymentModel.getEarnings(),
                        builder: (context, snapshot) {
                          return FittedBox(
                            fit: BoxFit.contain,
                            child: RichText(
                              text: TextSpan(
                                  text: 'You have earned ',
                                  style: constant.subtitle
                                      .copyWith(color: Colors.grey.shade900),
                                  children: [
                                    TextSpan(
                                        text: '${cur.format(_logic.getDifference(_logic.getEarningsChart(snapshot.data)).abs())}',
                                        style: constant.subtitle
                                            .copyWith(fontWeight: FontWeight.bold)),
                                    _logic.getDifference(_logic.getEarningsChart(snapshot.data)).isNegative == true ?
                                    TextSpan(text: ' less than last month.') :
                                    TextSpan(text: ' more than last month.')
                                  ]),
                            ),
                          );
                        }
                      )),
                    Expanded(
                        flex: 5,
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: width * 0.3,
                              child: StreamBuilder<List<Payment>>(
                                stream: _paymentModel.getEarnings(),
                                builder: (context, snapshot) {
                                  var earnings = _logic.getEarningsChart(snapshot.data);
                                  return DashboardChart.earningsChart(earnings);
                                }
                              )
                            ),
                            StreamBuilder<List<Payment>>(
                              stream: _paymentModel.getEarnings(),
                              builder: (context, snapshot) {
                                return Row(
                                  children: <Widget>[
                                    SizedBox(width: 20.0),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        CircleAvatar(
                                            backgroundColor: constant.bluegreen,
                                            radius: 10.0),
                                        SizedBox(height: 10.0),
                                        CircleAvatar(
                                            backgroundColor: constant.pink,
                                            radius: 10.0),
                                      ],
                                    ),
                                    SizedBox(width: 10.0),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('${cur.format(_logic.getEarningsChart(snapshot.data)[0])}',
                                            style: constant.subtitle
                                                .copyWith(fontSize: 15.0)),
                                        SizedBox(height: 10.0),
                                        Text('${cur.format(_logic.getEarningsChart(snapshot.data)[1])}',
                                            style: constant.subtitle
                                                .copyWith(fontSize: 15.0))
                                      ],
                                    ),
                                  ],
                                );
                              }
                            )
                          ],
                        ))
                  ],
                )),
              ],
            ),
          ),
        ),
        Positioned(
          right: 20,
          height: height * 0.35,
          child: Container(
              width: width * 0.4,
              child: SvgPicture.asset('images/services.svg')),
        )
      ],
    );
  }
}

class DashboardChart extends StatelessWidget {
  final List<chart.Series> seriesList;
  DashboardChart(this.seriesList);

  factory DashboardChart.earningsChart(List<double> data) {
    return new DashboardChart(_displayChart(data[0], data[1]));
  }

  @override
  Widget build(BuildContext context) {
    return new chart.BarChart(seriesList,
        animate: false,
        defaultRenderer: new chart.BarRendererConfig(
            cornerStrategy: const chart.ConstCornerStrategy(30)));
  }

  static List<chart.Series<Earnings, String>> _displayChart(double prev, double current) {
    final data = [
      new Earnings('Previous', prev, constant.bluegreen),
      new Earnings('Current', current, constant.pink)
    ];

    return [
      new chart.Series<Earnings, String>(
          id: 'Earning',
          domainFn: (Earnings earn, _) => earn.month,
          measureFn: (Earnings earn, _) => earn.earning,
          colorFn: (Earnings earn, _) => earn.color,
          data: data)
    ];
  }
}
