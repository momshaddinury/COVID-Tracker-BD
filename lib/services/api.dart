
import 'package:covidtrackerbd/services/json.dart';
import 'package:covidtrackerbd/services/jsonModel.dart';
import 'package:http/http.dart' as http;
String onUserResponseSubmitUrl = "https://us-central1-covid19-bd.cloudfunctions.net/onUserResponseSubmit";
String getUserByUserPhoneUrl = "https://us-central1-covid19-bd.cloudfunctions.net/getUserByUserPhone";

Future<http.Response> submitResponse() async {
  Map<String,String> headers = {
    'Content-type' : 'application/json',
    'Accept': 'application/json',
  };
  var response = await http.post(onUserResponseSubmitUrl,
  body: data, headers: headers);
  print(response.body);
  parseJson.decodeJson(response.body);
  return response;
}

