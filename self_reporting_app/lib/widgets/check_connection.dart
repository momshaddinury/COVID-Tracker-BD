import 'package:flutter/material.dart';

Future buildShowCheckConnectionDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      // return object of type Dialog
      return Container(
        child: AlertDialog(
          title: new Text("ইন্টারনেট সংযোগ চেক করুন"),
          content: new Text("আপনার ইন্টারনেট সংযোগ চেক করুন"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("ওকে"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}
