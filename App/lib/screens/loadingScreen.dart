import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:auto_size_text/auto_size_text.dart';


class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
      body:  AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          color: Color(0xFFF7F7F7),
/*          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Color(0xFF3594DD),
                Color(0xFF4563DB),
                Color(0xFF5036D5),
                Color(0xFF5B16D0),
              ],
            ),
          ),*/
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/coronaInfo.png'),
              SizedBox(height: 100,),
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
                'সাবান পানি দিয়ে অন্তত ২০ সেকেন্ড ধরে হাত ধোবেন',
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
    );
  }
}


