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

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'initialize.dart';

// Sets a platform override for desktop to avoid exceptions. See
// https://flutter.dev/desktop#target-platform-override for more info.
void _enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() {
  /*WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);*/
  //runApp(DevicePreview(builder: (context) => App()));
  _enablePlatformOverrideForDesktop();
  runApp(App());
}

/// App starts from here
/// Go to Initialize.dart file
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      locale: DevicePreview.of(context).locale, // <--- Add the locale
//      builder: DevicePreview.appBuilder,
      title: 'Corona',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Quicksand'),
      home: Scaffold(
        body: Initialize(),
      ),
    );
  }
}
