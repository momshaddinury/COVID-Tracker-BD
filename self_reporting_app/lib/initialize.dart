import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:selfreportingapp/screens/loading_screen.dart';
import 'package:selfreportingapp/screens/onboarding_screen.dart';
import 'package:selfreportingapp/services/geo_locator.dart';
import 'package:selfreportingapp/widgets/check_connection.dart';
import 'services/connectivity.dart';

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
  @override
  void initState() {
    super.initState();
    dataConnectionService.networkCheck();

    /// Connectivity.dart - Check if network is available
  }

  /// StreamBuilder checks if the Stream has data and builds accordingly
  /// Listening to Connectivity and checking if connection is available
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      //body: getLoadingScreen()
      body: StreamBuilder(
        stream: streamController.stream,
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.waiting) {
            /// While Stream is waiting for data
            return LoadingScreen();
          } else if (snapShot.data == DataConnectionStatus.connected) {
            return OnBoardingScreen();

            /// When connection is available
          } else if (snapShot.data == DataConnectionStatus.disconnected) {
            WidgetsBinding.instance.addPostFrameCallback(
                (_) => buildShowCheckConnectionDialog(context));
          }
          return Container();
        },
      ),
    );
  }
}
