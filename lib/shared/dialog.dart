import 'package:flutter/material.dart';
import 'package:debttracker/shared/constant.dart' as constant;

successDialog(BuildContext context, String text) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Success',
          style: constant.subtitle.copyWith(
            fontWeight: FontWeight.bold
          )),
        content: Text('Added $text successfully.',
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