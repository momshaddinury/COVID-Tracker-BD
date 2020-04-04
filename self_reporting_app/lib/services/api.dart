import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:selfreportingapp/model/citizen_reporting_qa.dart';
import 'package:selfreportingapp/model/self_report_qa.dart';

import 'json_handle.dart';

String productionBaseUrl = "https://corona-dghs.xyz/api/response";
String productionOrgLoginUrl =
    "https://corona-dghs.xyz/api/organizations/login";
String productionAccessToken =
    "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZTgyMWUxMDdjOTMyMTFkOWMxMDJkYTYiLCJuYW1lIjoiTW9tc2hhZCBEaW51cnkiLCJlbWFpbCI6Im1kLmRpbnVyeUBnbWFpbC5jb20iLCJpYXQiOjE1ODU2NTkxNDksImV4cCI6MTYwMTIxMTE0OSwiaXNzIjoiNWU4MjFlMTA3YzkzMjExZDljMTAyZGE2In0.SrPTrtpLiVZhmnhbwrRpjovZ-hNugr19N0Jt1voGAQU";

String proCitizenReportSubmissionUrl =
    "https://corona-dghs.xyz/api/response/citizen";

String developmentBaseUrl = "http://dev.corona-dghs.xyz/api/response";
String developmentOrgUrl = "http://dev.corona-dghs.xyz/api/organizations/login";
String devAccessToken =
    "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZTgyMzUwMGFlMTRlOTE5NjA0YzM4MDYiLCJuYW1lIjoiTW9tc2hhZCBEaW51cnkiLCJlbWFpbCI6Im1kLmRpbnVyeUBnbWFpbC5jb20iLCJpYXQiOjE1ODU2MzcwNDAsImV4cCI6MTYwMTE4OTA0MCwiaXNzIjoiNWU4MjM1MDBhZTE0ZTkxOTYwNGMzODA2In0.0Es-E2QxvBSgO3Rm4hAZaKiq8j6XGBALY4WWPP_1-GI";

String devCitizenReportSubmissionUrl =
    "https://dev.corona-dghs.xyz/api/response/citizen";

Future<http.Response> submitResponse() async {
  Map<String, String> headers = {
    'Authorization': '$productionAccessToken',
    'Content-type': 'application/json',
  };
  var response =
      await http.post(productionBaseUrl, body: data, headers: headers);

  print("submitResponse() - ${response.body}");
  parseJson.decodeJson(response.body.toString());
  return response;
}

/*Future<String> orgLoginResponse() async {
  Map<String, String> headers = {
    'Content-type': 'application/json',
  };
  var response = await http.post(developmentOrgUrl,
      body: logInCredentials, headers: headers);

  Map<String, dynamic> _response = jsonDecode(response.body.toString());
  print("logInCredentials() - ${_response['access_token']}");
  String _result = _response['access_token'];
  return _result;
}

//Stirng accessToken = await orgLoginResponse();
String logInCredentials =
    '{"email": "md.dinury@gmail.com", "password": "passwordpassword?"}';*/

Future<http.Response> submitCitizenResponse() async {
  Map<String, String> headers = {
    'Authorization': '$productionAccessToken',
    'Content-type': 'application/json',
  };
  var response = await http.post(proCitizenReportSubmissionUrl,
      body: citizenData, headers: headers);

  print("submitCitizenResponse() - ${response.body}");
  parseJson.decodeJson(response.body.toString());
  return response;
}
