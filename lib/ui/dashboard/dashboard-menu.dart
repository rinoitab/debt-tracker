import 'package:flutter/material.dart';
import 'package:debttracker/shared/constant.dart' as constant;
import 'package:flutter_svg/flutter_svg.dart';

class DashboardMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Card(
                elevation: 1,
                color: constant.bluegreen,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                        topRight: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0))),
                child: ListTile(
                  leading: CircleAvatar(
                    child: SvgPicture.asset('images/avatar.svg'),
                  ),
                  title: Container(
                    padding: EdgeInsets.fromLTRB(0.0, 15.0, 20.0, 20.0),
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: RichText(
                          text: TextSpan(
                              text: 'You have ',
                              style: constant.subtitle
                                  .copyWith(color: Colors.white),
                              children: [
                            TextSpan(
                                text: '30',
                                style: constant.subtitle
                                    .copyWith(fontWeight: FontWeight.bold)),
                            TextSpan(text: ' collections today.')
                          ])),
                    ),
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Image.network(
                        'https://img.icons8.com/pastel-glyph/64/000000/like--v2.png',
                        color: Colors.white),
                  ),
                )),
          ),
          Expanded(
            flex: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(width: 10.0),
                FlatButton(
                  padding: EdgeInsets.all(0.0),
                  onPressed: () {
                    print('Overdue');
                  },
                  child: DashboardMenuButton(
                    url: 'https://img.icons8.com/pastel-glyph/64/000000/error.png',
                    color: constant.pink)
                ),
                FlatButton(
                  padding: EdgeInsets.all(0.0),
                  onPressed: () {
                    print('Pending');
                  },
                  child: DashboardMenuButton(
                    url: 'https://img.icons8.com/pastel-glyph/64/000000/time.png',
                    color: constant.torquiose
                  )
                ),
                FlatButton(
                  padding: EdgeInsets.all(0.0),
                  onPressed: () {
                    print('All debtors');
                  },
                  child: DashboardMenuButton(
                    url: 'https://img.icons8.com/pastel-glyph/64/000000/user-female--v3.png',
                    color: constant.peach
                  )
                ),
                FlatButton(
                  padding: EdgeInsets.all(0.0),
                  onPressed: () {
                    print('All debts');
                  },
                  child: DashboardMenuButton(
                    url: 'https://img.icons8.com/pastel-glyph/64/000000/money-box.png',
                    color: constant.orange
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DashboardMenuButton extends StatelessWidget {
  final String url;
  final Color color;
  DashboardMenuButton({this.url, this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      color: color,
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Image.network(
          url,
          color: Colors.white),
      ),
    );
  }
}