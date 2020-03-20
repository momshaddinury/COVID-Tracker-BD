import 'package:flutter/material.dart';

LoadingScreen loadingScreen = LoadingScreen();
//String bgImageURL =
//    "https://ei.marketwatch.com/Multimedia/2020/01/29/Photos/ZG/MW-HZ220_Corona_20200129092723_ZG.jpg?uuid=7777a274-42a3-11ea-a4c4-9c8e992d421e";
String bgImageURL = "https://www.propertyreporter.co.uk/images/660x350/covid-19-13868.jpg";
class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/covid.jpg'),
              fit: BoxFit.fitHeight
          ),
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
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white30),
              backgroundColor: Colors.redAccent,
              semanticsLabel: "Fetching Data",
            ),
          ],
        ),
      ),
    );
  }
}
