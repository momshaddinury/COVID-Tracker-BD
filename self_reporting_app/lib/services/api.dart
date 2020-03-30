import 'package:http/http.dart' as http;
import 'package:selfreportingapp/model/self_reporting_qa.dart';

import 'json_handle.dart';

String productionBaseUrl = "http://35.186.155.204";
String productionAccessToken =
    "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZTgyMWUxMDdjOTMyMTFkOWMxMDJkYTYiLCJuYW1lIjoiTW9tc2hhZCBEaW51cnkiLCJlbWFpbCI6Im1kLmRpbnVyeUBnbWFpbC5jb20iLCJpYXQiOjE1ODU1ODU2ODAsImV4cCI6MTYwMTEzNzY4MCwiaXNzIjoiNWU4MjFlMTA3YzkzMjExZDljMTAyZGE2In0.NTGXk4-yKyffbF-Od0Ojfd6-ocOywRJp6kpa3QS47Bc";

String developmentBaseUrl = "http://35.187.229.54";
String devAccessToken =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZTgyMzUwMGFlMTRlOTE5NjA0YzM4MDYiLCJuYW1lIjoiTW9tc2hhZCBEaW51cnkiLCJlbWFpbCI6Im1kLmRpbnVyeUBnbWFpbC5jb20iLCJpYXQiOjE1ODU1OTE1NTIsImV4cCI6MTYwMTE0MzU1MiwiaXNzIjoiNWU4MjM1MDBhZTE0ZTkxOTYwNGMzODA2In0.B08N67t4lF1vhpp2P0ihswWqecfMBHG5A4E0EZaRC_o";

Future<http.Response> submitResponse() async {
  Map<String, String> headers = {
    'Authorization': '$devAccessToken',
    'Content-type': 'application/json',
  };
  var response =
      await http.post(developmentBaseUrl, body: data, headers: headers);
  print(response.body);
  parseJson.decodeJson(response.body);
  return response;
}
