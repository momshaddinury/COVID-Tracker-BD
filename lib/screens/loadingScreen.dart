import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

LoadingScreen loadingScreen = LoadingScreen();

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/covid.jpg'), fit: BoxFit.fitHeight),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'BANGLADESH',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 60.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: data.size.width * 0.01,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'COVID-19',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 50.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: data.size.width * 0.01,
                ),
              ),
              SizedBox(height: 20),
              SpinKitPulse(
                color: Colors.redAccent,
                size: 60.0,
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "This App Requires Internet Connection & Location Access",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15.0,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "Developed by Students of EEE | CU",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
