import 'package:flutter/material.dart';

class DeveloperStory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "This app is developed by Students of EEE, CU. This was a team effort. Members are Momshad Dinury (2015-16), Mahbubur Rahman(2014-15), Ibrahim Ullah(2015-16)",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "App Development - Momshad Dinury",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            Text(
              "Server Mangement - Mahbubur Rahman",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            Text(
              "Data Modeling and Analysis - Ibrahim Ullah",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
