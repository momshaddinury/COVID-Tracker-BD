import 'dart:async';
import 'package:data_connection_checker/data_connection_checker.dart';
import '../initialize.dart';

StreamSubscription<DataConnectionStatus> listener;

DataConnectionService dataConnectionService = DataConnectionService();

class DataConnectionService {
  networkCheck() async {
    await Future.delayed(Duration(seconds: 2));
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          print('::Data connection is available.');
          streamController.sink.add(status);
          tasks();
          break;
        case DataConnectionStatus.disconnected:
          print('::Disconnected from the internet.');
          break;
      }
    });
  }
}
