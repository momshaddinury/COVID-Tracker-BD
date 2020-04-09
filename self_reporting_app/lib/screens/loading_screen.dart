import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:auto_size_text/auto_size_text.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Expanded(
                  flex: 2,
                  child: Image.asset(
                    'assets/bd.jpg',
                    height: 200,
                  ),
                ),
                Spacer(),
                Column(
                  children: <Widget>[
                    AutoSizeText(
                      'সংক্রমণ প্রতিরোধের উপায়',
                      textScaleFactor: 1,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: data.size.width * 0.01,
                      ),
                    ),
                    SizedBox(height: 10),
                    AutoSizeText(
                      'সাবান পানি দিয়ে অন্তত ২০ সেকেন্ড ধরে হাত ধোবেন',
                      textScaleFactor: 1,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        fontWeight: FontWeight.w400,
                        letterSpacing: data.size.width * 0.01,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                SpinKitPulse(
                  color: Colors.blue,
                  size: 60.0,
                ),
                SizedBox(height: 20),
                AutoSizeText(
                  "ডাটা কানেকশন এবং লোকেশন এক্সেস আব্যশক\nকারিগরি সহযোগিতায় টিম Zeroth Index, ইইই, চট্টগ্রাম বিশ্ববিদ্যালয়\nVisit: https://www.facebook.com/zeroth.index/",
                  textScaleFactor: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  flex: 2,
                  child: Image.asset('assets/0th-I.png'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
