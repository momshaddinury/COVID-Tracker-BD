import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'initialize.dart';

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
