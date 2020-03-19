import 'dart:async';
import 'package:covidtrackerbd/Screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:covidtrackerbd/services/JSONHandler.dart';
import 'Screens/loadingScreen.dart';
import 'package:neat_periodic_task/neat_periodic_task.dart';
import 'dart:io';

/// Initializes fetchData() to fetch data, to  show in Home Tab
/// Starts Scheduler to periodically call fetchData()

final StreamController streamController = StreamController();

class Initialize extends StatefulWidget {
  @override
  _InitializeState createState() => _InitializeState();
}

class _InitializeState extends State<Initialize> {

  /// Calls two process
  tasks() async {
    await jsonHandler.fetchData();
    await scheduler();
  }

  ///Periodically calls fetchData()
  scheduler() async {
    // Create a periodic task that prints 'Hello World' every 30s
    final scheduler = NeatPeriodicTaskScheduler(
      interval: Duration(seconds: 120),
      name: 'Fetch Data',
      timeout: Duration(seconds: 5),
      task: () async => jsonHandler.fetchData(),
      minCycle: Duration(seconds: 5),
    );

    scheduler.start();
    await ProcessSignal.sigterm.watch().first;
    await scheduler.stop();
  }

  /// When the widget initiates calls tasks()
  @override
  void initState() {
    super.initState();
    tasks();
  }

  /// StreamBuilder checks if the Stream has data and builds accordingly
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: StreamBuilder(
          stream: streamController.stream,
          builder: (context, snapShot) {
            ///If fetchData() resulted in error
            if (snapShot.hasError) {
              Text("Error");
            } else if (snapShot.connectionState == ConnectionState.waiting) { ///if fetch data is working to fetch data
              return LoadingScreen();
            }
            ///If fetchData() successfully fetched data
            return HomeScreen();
          },
        ),
      ),
    );
  }
}
