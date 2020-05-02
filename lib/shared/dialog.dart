import 'package:debttracker/ui/detail/debtor.dart';
import 'package:flutter/material.dart';
import 'package:debttracker/shared/constant.dart' as constant;
import 'package:flutter/services.dart';

successDialog(BuildContext context, String text, String id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Success',
          style: TextStyle(
            fontWeight: FontWeight.bold
          )),
        content: Text('Added $text successfully.',
          style: constant.subtitle),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)),
        actions: <Widget>[
          id.isEmpty ? Container() : FlatButton(
            child: Text('Go to Profile',
              style: constant.subtitle.copyWith(
                color: constant.green
              )),
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => DebtorPage(id: id)));
            },
          ),
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

errorDialog(BuildContext context, String text) {
  showDialog(
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