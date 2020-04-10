import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:selfreportingapp/screens/homepage.dart';
import 'package:selfreportingapp/screens/loading_screen.dart';
import 'package:selfreportingapp/screens/onboarding_screen.dart';
import 'initialize.dart';

void main() {
  /// Device Preview
  //runApp(DevicePreview(builder: (context) => App()));

  /// Flutter Crashlytics
  /*Crashlytics.instance.enableInDevMode = true;

  /// Pass all uncaught errors to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  runZoned(() {
    runApp(App());
  }, onError: Crashlytics.instance.recordError);*/

  /// Default runApp()
  runApp(App());
}

/// App starts from here
/// Go to Initialize.dart file
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      // locale: DevicePreview.of(context).locale, // <--- Add the locale
      // builder: DevicePreview.appBuilder,
      title: 'Corona',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Quicksand'),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Initialize(),
      ),
      routes: <String, WidgetBuilder>{
        '/LoadingScreen': (BuildContext context) => new LoadingScreen(),
        '/OnBoardingScreen': (BuildContext context) => new OnBoardingScreen(),
        '/HomePage': (BuildContext context) => new HomePage(),
      },
    );
  }
}
