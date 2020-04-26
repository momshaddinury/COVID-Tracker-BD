import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:selfreportingapp/model/district.dart';
import 'package:selfreportingapp/model/division.dart';
import 'package:selfreportingapp/model/patient_data.dart';
import 'package:selfreportingapp/model/upazila.dart';
import 'package:selfreportingapp/services/geo_locator.dart';

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

//Location:
double lat = position.latitude;
double lon = position.longitude;
double alt = position.altitude;

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

//Get all Division
Future<List<Division>> getAllDivision() async {
  Map<String, String> headers = {
    'Authorization': '$productionAccessToken',
  };
  final response =
      await http.get(productionBaseUrl + "divisions", headers: headers);
  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    List<Division> divisionDetails =
        body.map((dynamic item) => Division.fromJson(item)).toList();
    return divisionDetails;
//    return Division.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load Divisions');
  }
}

//Get all Districts
Future<List<District>> getAllDistricts() async {
  Map<String, String> headers = {
    'Authorization': '$productionAccessToken',
  };
  final response =
      await http.get(productionBaseUrl + "districts", headers: headers);
  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    List<District> districtDetails =
        body.map((dynamic item) => District.fromJson(item)).toList();
    return districtDetails;
  } else {
    throw Exception('Failed to load Divisions');
  }
}

//Get all Upazila
Future<List<Upazila>> getAllUpazila() async {
  Map<String, String> headers = {
    'Authorization': '$productionAccessToken',
    'Content-type': 'application/json',
  };
  final response =
      await http.get(productionBaseUrl + "upazilas", headers: headers);
  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    List<Upazila> upazilaDetails =
        body.map((dynamic item) => Upazila.fromJson(item)).toList();
    return upazilaDetails;
  } else {
    throw Exception('Failed to load Divisions');
  }
}

//POST Methods

//Main Case Report submission API
Future<http.Response> postMainCaseReport() async {
  Map<String, String> headers = {
    'Authorization': '$productionAccessToken',
    'Content-type': 'application/json',
  };
  String mainCaseData = jsonEncode({
    "age": {
      "answer": "${personalQAPlaceholder.personalQAPlaceholderValue['age']}"
    },
    "phone": {
      "answer":
          "${personalQAPlaceholder.personalQAPlaceholderValue['phoneNumber']}"
    },
    "name": {
      "answer":
          "${personalQAPlaceholder.personalQAPlaceholderValue['fullName']}"
    },
    "gender": {
      "answer": personalQAPlaceholder.personalQAPlaceholderValue['gender']
    },
    "has_sore_throat": {
      "answer":
          triageQAPlaceHolder.triageQAPlaceholderValue['coughOrThroatPain']
    },
    "has_breathlessness": {
      "answer": triageQAPlaceHolder.triageQAPlaceholderValue['problemBreathing']
    },
    "is_contacted_with_covid": {
      "answer": triageQAPlaceHolder
          .triageQAPlaceholderValue['contactWithAnyCOVIDPatient']
    },
    "is_contacted_with_family_who_cough": {
      "answer": triageQAPlaceHolder.triageQAPlaceholderValue[
          'cameInContactWithPersonHavingCoughOrThroatPain']
    },
    "high_risk": {
      "answer": triageQAPlaceHolder.triageQAPlaceholderValue['riskGroup']
    },
    "is_healthcare_worker": {
      "answer": triageQAPlaceHolder.triageQAPlaceholderValue['healthCareWorker']
    },
    "division": {
      "answer": personalQAPlaceholder.personalQAPlaceholderValue['division']
    },
    "district": {
      "answer": personalQAPlaceholder.personalQAPlaceholderValue['district']
    },
    "upazila": {
      "answer": personalQAPlaceholder.personalQAPlaceholderValue['upazila']
    },
    "location": {"latitude": lat, "longitude": lon, "altitude": alt},
    "relationship_id":
        personalQAPlaceholder.personalQAPlaceholderValue['relationType'],
    "nid": personalQAPlaceholder.personalQAPlaceholderValue['nid'],
    "address": personalQAPlaceholder.personalQAPlaceholderValue['address'],
    "is_offline": false,
    "metadata": {},
    "submitted_at": DateTime.now().millisecondsSinceEpoch
  });
  print(mainCaseData);
  var response = await http.post(productionBaseUrl + "response",
      body: "$mainCaseData", headers: headers);
  //print("submitResponse() - ${response.body}");
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
  String citizenData = jsonEncode({
    "name": {
      "type": "text",
      "question_bn": "ব্যক্তির নাম ",
      "question_en": "",
      "answer": "${citizenQAPlaceholder.citizenQAPlaceholderValue['fullName']}"
    },
    "phone": {
      "type": "text",
      "question_bn": "মোবাইল ",
      "question_en": "",
      "answer":
          "${citizenQAPlaceholder.citizenQAPlaceholderValue['phoneNumber']}"
    },
    "father_name": {
      "type": "text",
      "question_bn": "পিতার নাম ",
      "question_en": "",
      "answer":
          "${citizenQAPlaceholder.citizenQAPlaceholderValue['patientFatherName']}"
    },
    "gender": {
      "type": "text",
      "question_bn": "লিঙ্গ",
      "question_en": "",
      "answer": citizenQAPlaceholder.citizenQAPlaceholderValue['gender']
    },
    "estimated_age": {
      "type": "text",
      "question_bn": "আনুমানিক বয়স",
      "question_en": "",
      "answer": "${citizenQAPlaceholder.citizenQAPlaceholderValue['age']}"
    },
    "came_back_bangladesh_at": {
      "type": "number",
      "question_bn": "দেশে ফেরার তারিখ",
      "question_en": "",
      "answer":
          citizenQAPlaceholder.citizenQAPlaceholderValue['dateofReturnNRB']
    },
    "from_country": {
      "type": "text",
      "question_bn": "যে দেশ থেকে ফিরেছেনরিখ",
      "question_en": "",
      "answer": citizenQAPlaceholder.citizenQAPlaceholderValue['countryNRB']
    },
    "division": {
      "type": "text",
      "question_bn": "বিভাগ",
      "question_en": "",
      "answer": citizenQAPlaceholder.citizenQAPlaceholderValue['division']
    },
    "zilla": {
      "type": "text",
      "question_bn": "জেলা",
      "question_en": "",
      "answer": citizenQAPlaceholder.citizenQAPlaceholderValue['district']
    },
    "upzilla": {
      "type": "text",
      "question_bn": "উপজেলা",
      "question_en": "",
      "answer": citizenQAPlaceholder.citizenQAPlaceholderValue['upazila']
    },
    "union": {
      "type": "text",
      "question_bn": "",
      "question_en": "union",
      "answer": citizenQAPlaceholder.citizenQAPlaceholderValue['union']
    },
    "ward": {
      "type": "text",
      "question_bn": "গ্রাম/ওয়ার্ড",
      "question_en": "",
      "answer": citizenQAPlaceholder.citizenQAPlaceholderValue['village']
    },
    "house_no": {
      "type": "text",
      "question_bn": "বাড়ির নম্বর/ওয়ার্ড",
      "question_en": "",
      "answer": citizenQAPlaceholder.citizenQAPlaceholderValue['address']
    },
    "location": {
      "latitude": position.latitude,
      "longitude": position.longitude,
      "altitude": position.altitude
    },
    "relationship": "neighbor",
    "metadata": {},
    "submitted_at": DateTime.now().millisecondsSinceEpoch
  });
  print(citizenData);
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
