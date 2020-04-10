import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

String appStoreUrl = "https://zerothindex.org/downloader";

Future buildShowDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return Container(
        child: AlertDialog(
          title: new Text("নতুন আপডেট এসেছে"),
          content: new Text("নতুন আপডেট টি ডাউনলোড করে নিন"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("ডাউনলোড"),
              onPressed: () {
                launchURL(appStoreUrl);
              },
            ),
          ],
        ),
      );
    },
  );
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
