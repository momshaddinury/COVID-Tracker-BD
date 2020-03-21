import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:covidtrackerbd/initialize.dart';

JSONHandler jsonHandler = JSONHandler();
final String apiURL = "https://perceptronlab.com/project/covidtrackerbd";
int infected, dead, recovery, dateTime;

class JSONHandler {
  Map<String, dynamic> responseJSONDecode;

  fetchData() async {
    print("fetchData()");
    //await Future.delayed(Duration(seconds: 1));

    http.Response response = await http.get(apiURL);

    if (response.statusCode == 200) {
      jsonHandler.decodeJson(response.body);

      if (jsonHandler.responseJSONDecode.isNotEmpty) {
        print("[JOSNs]: $responseJSONDecode");
        infected = responseJSONDecode['infected'];
        dead = responseJSONDecode['death'];
        recovery = responseJSONDecode['recovered'];

        streamController.sink.add(infected);
        streamController.sink.add(dead);
        streamController.sink.add(recovery);
      }
    }
  }

  decodeJson(String response) async {
    /// Need to replace '' with "" because as of now '' can't be parsed
    // String responseJson = response.replaceAll('\'', '"');
    try {
      responseJSONDecode = jsonDecode(response);
    } catch (e) {
      print('decodeJson(): $e');
    }
  }
}
