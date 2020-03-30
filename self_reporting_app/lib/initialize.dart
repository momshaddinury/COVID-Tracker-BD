import 'dart:async';

import 'package:flutter/material.dart';
import 'package:selfreportingapp/screens/dashboard.dart';
import 'package:selfreportingapp/screens/loading_screen.dart';
import 'package:selfreportingapp/services/geo_locator.dart';
import 'services/connectivity.dart';

/// Initializes fetchData() to fetch data, to  show in Home Tab
/// Starts Scheduler to periodically call fetchData()

/// Calls two process
tasks() async {
  //await jsonHandler.fetchData();
  await getLocation();
  //await scheduler();
}

///Periodically calls fetchData()
/*scheduler() async {
  // Create a periodic task that prints 'Hello World' every 30s
  final scheduler = NeatPeriodicTaskScheduler(
    interval: Duration(seconds: 15),
    name: 'Fetch Data',
    timeout: Duration(seconds: 5),
    task: () async => jsonHandler.fetchData(),
    minCycle: Duration(seconds: 5),
  );

  scheduler.start();
  await ProcessSignal.sigterm.watch().first;
  await scheduler.stop();
}*/

final StreamController streamController = StreamController();

class Initialize extends StatefulWidget {
  @override
  _InitializeState createState() => _InitializeState();
}

class _InitializeState extends State<Initialize> {
  /// When the widget initiates calls tasks()
  @override
  void initState() {
    super.initState();
    dataConnectionService.networkCheck(); //Connectivity.dart
  }

  /// StreamBuilder checks if the Stream has data and builds accordingly
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      //body: getLoadingScreen()
      body: StreamBuilder(
        stream: streamController.stream,
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            ///if fetch data is working to fetch data
            return LoadingScreen();
          }

          ///If fetchData() successfully fetched data
          return HomePage();
        },
      ),
    );
  }
}
