import 'dart:async';
import 'package:covidtrackerbd/Screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'service & api//JSONHandler.dart';
import 'Screens/loadingScreen.dart';
import 'package:neat_periodic_task/neat_periodic_task.dart';
import 'dart:io';

final StreamController streamController = StreamController();

class Initialize extends StatefulWidget {
  @override
  _InitializeState createState() => _InitializeState();
}

class _InitializeState extends State<Initialize> {
  tasks() async {
    await jsonHandler.fetchData();
    await scheduler();
  }

  scheduler() async {
    // Create a periodic task that prints 'Hello World' every 30s
    final scheduler = NeatPeriodicTaskScheduler(
      interval: Duration(seconds: 20),
      name: 'Fetch Data',
      timeout: Duration(seconds: 5),
      task: () async => jsonHandler.fetchData(),
      minCycle: Duration(seconds: 5),
    );

    scheduler.start();
    await ProcessSignal.sigterm.watch().first;
    await scheduler.stop();
  }

  @override
  void initState() {
    super.initState();
    tasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: StreamBuilder(
          stream: streamController.stream,
          builder: (context, snapShot) {
            if (snapShot.hasError) {
              Text("Error");
            } else if (snapShot.connectionState == ConnectionState.waiting) {
              return LoadingScreen();
            }
            return HomeScreen();
          },
        ),
      ),
    );
  }
}
