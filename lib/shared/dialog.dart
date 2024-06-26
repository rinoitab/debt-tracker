import 'package:debttracker/ui/detail/debtor.dart';
import 'package:flutter/material.dart';
import 'package:debttracker/shared/constant.dart' as constant;
import 'package:flutter/services.dart';

successDialog(BuildContext context, String text, String id, String route) {

  String dialog;

  route == 'add' ? 
    dialog = 'Added $text successfully.' :
    dialog = 'Updated $text successfully.';

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Success',
          style: TextStyle(
            fontWeight: FontWeight.bold
          )),
        content: Text('$dialog',
          style: constant.subtitle),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)),
        actions: <Widget>[
          id.isEmpty ? Container() : FlatButton(
            child: Text('Go to Profile',
              style: constant.subtitle.copyWith(
                color: constant.torquiose
              )),
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => DebtorPage(id: id)));
            },
          ),
          route == 'update' ? Container() :
          FlatButton(
            child: Text('Add Another',
              style: constant.subtitle.copyWith(
                color: constant.torquiose
              )),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text('Close',
              style: constant.subtitle.copyWith(
                color: constant.torquiose
              )),
            onPressed: () {
              route == 'update' ? 
              Navigator.pop(context) :
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      );
    }
  );
}

errorDialog(BuildContext context, String text) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error',
          style: constant.subtitle.copyWith(
            fontWeight: FontWeight.bold
          )),
        content: Text('Unable to add $text. Please try again.',
          style: constant.subtitle),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)),
        actions: <Widget>[
          FlatButton(
            child: Text('OK',
              style: constant.subtitle.copyWith(
                color: constant.green
              )),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );
    }
  );
}

generateReceiptDialog(BuildContext context, String text, String reference) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Generated receipt',
          style: constant.subtitle.copyWith(
            fontWeight: FontWeight.bold
          )),
        content: Text('Successfully generated payment with reference no. $reference',
          style: constant.subtitle),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)),
        actions: <Widget>[
          FlatButton(
            child: Text('Copy to Clipboard',
              style: constant.subtitle.copyWith(
                color: constant.torquiose
              )),
            onPressed: () {
              Clipboard.setData(new ClipboardData(text: text));
            },
          ),
          FlatButton(
            child: Text('OK',
              style: constant.subtitle.copyWith(
                color: constant.torquiose
              )),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );
    }
  );
}