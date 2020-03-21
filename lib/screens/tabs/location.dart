import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  bool isLoading;

  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        WebView(
          initialUrl:
              "https://perceptronlab.com/project/covidtrackerbd/heatmap",
          //initialUrl: "https://coronavirus.app/map",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
            setState(() {
              isLoading = false;
            });
          },
        ),
        isLoading
            ? Center(
                child: SpinKitPulse(
                  color: Colors.redAccent,
                  size: 60.0,
                ),
              )
            : Container(),
      ],
    );
  }
}
