/*
Project: COVID-19 Live Tracker (BETA)
Lead Author: Momshad Dinury
Team members:
  Mahbubur Rahman (Server and API)
  Ibrahim Ullah (Data Logging and Model Analysis)

App Features:
  1. User can check COVID19 Stat update of Bangladesh
  2. User can see other infected people in the location tab
  3. User can check global COVID19 update
  4. User can participate in a survey to collect data
 */

import 'package:flutter/material.dart';
import 'initialize.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Corona',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Quicksand'),
      home: /*HomePage()*/ Initialize(),
    );
  }
}
