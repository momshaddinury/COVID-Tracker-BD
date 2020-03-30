import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:auto_size_text/auto_size_text.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/bd.jpg',
                  height: 200,
                ),
                SizedBox(
                  height: 100,
                ),
                AutoSizeText(
                  'সংক্রমন প্রতিরোধের উপায়',
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: data.size.width * 0.01,
                  ),
                ),
                SizedBox(height: 10),
                AutoSizeText(
                  'সাবান পানি দিয়ে অন্তত ২০ সেকেন্ড ধরে হাত ধুবেন',
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                    fontWeight: FontWeight.w400,
                    letterSpacing: data.size.width * 0.01,
                  ),
                ),
                SizedBox(height: 20),
                SpinKitPulse(
                  color: Colors.blue,
                  size: 60.0,
                ),
                SizedBox(height: 20),
                AutoSizeText(
                  "ডাটা কানেকশন এবং লোকেশন এক্সেস আব্যশক",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(height: 20),
                AutoSizeText(
                  "কারিগরি সহযোগিতায় টিম রেড । সিউ",
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
