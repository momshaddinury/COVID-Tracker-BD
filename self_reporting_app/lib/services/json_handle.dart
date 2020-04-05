import 'dart:convert';

ParseJson parseJson = ParseJson();

String assessmentMessage;
int risk;
String userID;
String notes;
String id;
String message;
String version;

class ParseJson {
  Map<String, dynamic> responseJsonDecoded;

  decodeJson(String response) async {
    ///Need to replace '' with "" because as of now '' can't be parsed
    //String responseJson = response.replaceAll('\'', '"');
    try {
      //print("decodeJson");
      responseJsonDecoded = jsonDecode(response);
      print("decodeJson: ${responseJsonDecoded.values}");
      //for (dynamic value in responseJsonDecoded.values) {
      version = responseJsonDecoded['version'];
      assessmentMessage = responseJsonDecoded['assessmentMessage'];
      risk = responseJsonDecoded['risk'];
      userID = responseJsonDecoded['uniqueId'];
      notes = responseJsonDecoded['instructions'];
      message = responseJsonDecoded['message'];
      id = responseJsonDecoded['id'];
      //}
    } catch (e) {
      print('error decodeJson(): $e');
    }
  }
}
