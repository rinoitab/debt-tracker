import 'package:debttracker/model/dashboard-model.dart';
import 'package:debttracker/ui/dashboard/dashboard-chart.dart';
import 'package:debttracker/ui/dashboard/dashboard-list.dart';
import 'package:flutter/material.dart';
import 'package:debttracker/shared/constant.dart' as constant;
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:intl/intl.dart';

class DashboardCard extends StatefulWidget {
  @override
  _DashboardCardState createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    Dashboard dashboard = Dashboard();

    return Column(
      children: <Widget>[
        dueToday(width, height, dashboard.dueToday, context),
        earnings(width, height, dashboard),
        Row(
          children: <Widget>[
            Column( 
              children: <Widget>[
                width < 600 ? Container() : DashboardChart()
              ],
            ),
            DashboardList()
          ],
        ),
        
      ],
    );
  }

  Container earnings(double width, double height, Dashboard dashboard) {
    final cur = new NumberFormat.simpleCurrency(name: 'PHP');

    return Container(
        height: width > 400 ? height * 0.2 : height * 0.25,
        width: width,
        child: Card(
          elevation: 0,
          color: constant.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: width > 600 ? EdgeInsets.symmetric(vertical: 20) : EdgeInsets.symmetric(vertical: 10),
                child: Sparkline(
                  pointsMode: PointsMode.all,
                  pointColor: Colors.white,
                  pointSize: 8,
                  data: dashboard.yearlyEarnings,
                  lineColor: Colors.white,
                  ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.only(bottom: 3, right: 15),
                height: height * 0.05, 
                child: RichText(
                  text: TextSpan(
                    text: 'You earned ',
                    style: constant.subtitle.copyWith(
                      fontSize: (height * 0.05) * 0.4),
                    children: <TextSpan>[
                      TextSpan(
                        text: '${cur.format(dashboard.monthlyEarnings)}',
                        style: constant.subtitle.copyWith(
                          fontWeight: FontWeight.bold),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' this month.',
                            style: constant.subtitle.copyWith(
                              fontWeight: FontWeight.normal
                            )
                          )
                        ]
                      )
                    ]
                  )),
              )
            ],
          )
        ),
      );
  }

  Container dueToday(double width, double height, int count, BuildContext context) {
    return Container(
        width: width,
        height: height * 0.1,
        child: Card(
          elevation: 0,
          color: constant.pink,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60)
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: (height * 0.1) * 0.3,
                  child: Icon(Icons.warning,
                    color: constant.pink),
                ),
              ),
              Container(
                width: width > 600 ? width * 0.78 : width * 0.6,
                child: RichText(
                  text: TextSpan(
                    text: 'You have\n',
                    style: constant.subtitle.copyWith(
                      color: Colors.white,
                      fontSize: (height * 0.1) * 0.18
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '$count',
                        style: constant.subtitle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: (height * 0.1) * 0.2
                        ),
                        children: <TextSpan>[
                        TextSpan(
                        text: count > 1 ? ' collections today.' : ' collection today.',
                        style: constant.subtitle.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: (height * 0.1) * 0.18
                        )
                        )]
                      )
                    ]
                  ))
              ),
              Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  
                  child: Icon(Icons.arrow_forward_ios,
                    color: Colors.white),
                ),
              )
            ],
          ),
        ),
      );
  }
}