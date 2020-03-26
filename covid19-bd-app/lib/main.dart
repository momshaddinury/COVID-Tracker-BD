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

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'initialize.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

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
  // Set `enableInDevMode` to true to see reports while in debug mode
  // This is only to be used for confirming that reports are being
  // submitted as expected. It is not intended to be used for everyday
  // development.
  // Crashlytics.instance.enableInDevMode = true;

  // Pass all uncaught errors to Crashlytics.
  // FlutterError.onError = Crashlytics.instance.recordFlutterError;

  // runZoned(() {
    runApp(App());
  // }, onError: Crashlytics.instance.recordError);
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
