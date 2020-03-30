import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location>  with AutomaticKeepAliveClientMixin<Location> {
  bool isLoading;

  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    isLoading = true;
    super.initState();
  }

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(
            color: Colors.black87
        ),
      ),
      body: Stack(
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
      ),
    );
  }
}
