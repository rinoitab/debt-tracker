import 'package:debttracker/model/dashboard-model.dart';
import 'package:debttracker/model/payment-model.dart';
import 'package:debttracker/service/logic.dart';
import 'package:debttracker/shared/loading.dart';
import 'package:debttracker/view-model/payment-viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as chart;
import 'package:debttracker/shared/constant.dart' as constant;
import 'package:flutter_svg/flutter_svg.dart';

class DashboardEarningsCard extends StatefulWidget {
  @override
  _DashboardEarningsCardState createState() => _DashboardEarningsCardState();
}

class _DashboardEarningsCardState extends State<DashboardEarningsCard> {

  PaymentVM _paymentModel = PaymentVM();
  Logic _logic = Logic();

  

  @override
  Widget build(BuildContext context) {

    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Stack(
      children: <Widget>[
        Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_width * 0.05),
                  topRight: Radius.circular(_width * 0.01),
                  bottomLeft: Radius.circular(_width * 0.01),
                  bottomRight: Radius.circular(_width * 0.01))),
          margin: EdgeInsets.only(top: _height * 0.1),
          color: constant.green,
          child: Container(
            width: _width,
            height: _height * 0.25,
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
                          if(!snapshot.hasData) return Container();
                          return FittedBox(
                            fit: BoxFit.contain,
                            child: RichText(
                              text: TextSpan(
                                  text: 'You have earned ',
                                  style: constant.subtitle
                                      .copyWith(color: Colors.grey.shade900),
                                  children: [
                                    TextSpan(
                                        text: '${_logic.formatCurrency(_logic.getDifference(_logic.getEarningsChart(snapshot.data)).abs())}',
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
                              width: _width * 0.3,
                              child: StreamBuilder<List<Payment>>(
                                stream: _paymentModel.getEarnings(),
                                builder: (context, snapshot) {
                                  if(!snapshot.hasData) return Loading();
                                  var earnings = _logic.getEarningsChart(snapshot.data);
                                  return DashboardChart.earningsChart(earnings);
                                }
                              )
                            ),
                            StreamBuilder<List<Payment>>(
                              stream: _paymentModel.getEarnings(),
                              builder: (context, snapshot) {
                                if(!snapshot.hasData) return Container();
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
                                        Text('${_logic.formatCurrency(_logic.getEarningsChart(snapshot.data)[0])}',
                                            style: constant.subtitle
                                                .copyWith(fontSize: 15.0)),
                                        SizedBox(height: 10.0),
                                        Text('${_logic.formatCurrency(_logic.getEarningsChart(snapshot.data)[1])}',
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
          height: _height * 0.35,
          child: Container(
              width: _width * 0.4,
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
