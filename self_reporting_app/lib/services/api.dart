import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:selfreportingapp/model/citizen_reporting_qa.dart';
import 'package:selfreportingapp/model/main_case_report_qa.dart';
import 'package:selfreportingapp/model/patient_data.dart';

import 'json_handle.dart';

String productionBaseUrl = "https://corona-dghs.xyz/api/";
//String productionOrgLoginUrl =
//    "https://corona-dghs.xyz/api/organizations/login";
String productionAccessToken =
    "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZTgyMWUxMDdjOTMyMTFkOWMxMDJkYTYiLCJuYW1lIjoiTW9tc2hhZCBEaW51cnkiLCJlbWFpbCI6Im1kLmRpbnVyeUBnbWFpbC5jb20iLCJpYXQiOjE1ODU2NTkxNDksImV4cCI6MTYwMTIxMTE0OSwiaXNzIjoiNWU4MjFlMTA3YzkzMjExZDljMTAyZGE2In0.SrPTrtpLiVZhmnhbwrRpjovZ-hNugr19N0Jt1voGAQU";

String developmentBaseUrl = "http://dev.corona-dghs.xyz/api/response";
String developmentOrgUrl = "http://dev.corona-dghs.xyz/api/organizations/login";
String devAccessToken =
    "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZTgyMzUwMGFlMTRlOTE5NjA0YzM4MDYiLCJuYW1lIjoiTW9tc2hhZCBEaW51cnkiLCJlbWFpbCI6Im1kLmRpbnVyeUBnbWFpbC5jb20iLCJpYXQiOjE1ODU2MzcwNDAsImV4cCI6MTYwMTE4OTA0MCwiaXNzIjoiNWU4MjM1MDBhZTE0ZTkxOTYwNGMzODA2In0.0Es-E2QxvBSgO3Rm4hAZaKiq8j6XGBALY4WWPP_1-GI";

String devCitizenReportSubmissionUrl =
    "https://dev.corona-dghs.xyz/api/response/citizen";

String volunteerAuthTokenUrl =
    "https://us-central1-covid19-bd.cloudfunctions.net/validateToken";

//GET Methods

//Get all Questions
Future<http.Response> getAllQuestions() async {
  Map<String, String> headers = {
    'Authorization': '$productionAccessToken',
  };
  var response =
      await http.get(productionBaseUrl + "questions", headers: headers);
  print("submitResponse() - ${response.body}");
  return response;
}

//Get all Districts
Future<http.Response> getAllDistricts() async {
  Map<String, String> headers = {
    'Authorization': '$productionAccessToken',
  };
  var response =
      await http.get(productionBaseUrl + "districts", headers: headers);
  return response;
}

//Get all Division
Future<http.Response> getAllDivision() async {
  Map<String, String> headers = {
    'Authorization': '$productionAccessToken',
  };
  var response =
      await http.get(productionBaseUrl + "divisions", headers: headers);
  return response;
}

//Get all Upazila
Future<http.Response> getAllUpazila() async {
  Map<String, String> headers = {
    'Authorization': '$productionAccessToken',
    'Content-type': 'application/json',
  };
  var response =
      await http.get(productionBaseUrl + "upazilas", headers: headers);
  return response;
}

//POST Methods

//Main Case Report submission API
Future<http.Response> postMainCaseReport() async {
  Map<String, String> headers = {
    'Authorization': '$productionAccessToken',
    'Content-type': 'application/json',
  };
  String mainCaseData = jsonEncode({
    "age": {"answer": "$age"},
    "phone": {"answer": "$phoneNumber"},
    "name": {"answer": "$fullName"},
    "gender": {"answer": gender},
    "is_feverish": {"answer": fever},
    "has_sore_throat": {"answer": coughOrThroatPain},
    "has_breathlessness": {"answer": problemBreathing},
    "is_visited_abroad": {"answer": cameBackFromAbroad},
    "is_contacted_with_covid": {"answer": contactWithAnyCOVIDPatient},
    "is_contacted_with_family_who_cough": {
      "answer": cameInContactWithPersonHavingCoughOrThroatPain
    },
    "high_risk": {"answer": riskGroup},
    "division": {"answer": division},
    "district": {"answer": district},
    "upazila": {"answer": upazila},
    "location": {"latitude": lat, "longitude": lon, "altitude": alt},
    "relationship_id": relationType,
    "nid": nid,
    "address": address,
    "is_offline": false,
    "metadata": {},
    "submitted_at": DateTime.now().millisecondsSinceEpoch
  });
  var response = await http.post(productionBaseUrl + "response",
      body: "$mainCaseData", headers: headers);
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

//Citizen report submission API
Future<http.Response> postCitizenReport() async {
  Map<String, String> headers = {
    'Authorization': '$productionAccessToken',
    'Content-type': 'application/json',
  };
  var response = await http.post(productionBaseUrl + "response/citizen",
      body: citizenData, headers: headers);

  print("submitCitizenResponse() - ${response.body}");
  parseJson.decodeJson(response.body.toString());
  return response;
}

/// Volunteer Auth
Future<http.Response> postVolunteerToken() async {
  Map<String, String> headers = {
    'Content-type': 'application/json',
  };
  String volunteerToken = jsonEncode({
    "data": {"access_token": volunteerAccessToken}
  });

  print(volunteerToken);
  var response = await http.post(volunteerAuthTokenUrl,
      body: "$volunteerToken", headers: headers);

  print("postVolunteerToken() - ${response.body}");
  parseJson.decodeJson(response.body.toString());
  print(tokenStatus);
  return response;
}
