import 'dart:convert';

ParseJson parseJson = ParseJson();

String assessmentMessage;
String userID;
String notes;
class ParseJson {
  Map<String, dynamic> responseJsonDecoded;


  String convertToJson(String deviceID) {
    String unitID = '{"unit_id": "$deviceID"}';
    //print(unitID.runtimeType);
    return unitID;
  }
  String convertToJsonForConfirmation(String deviceID, String assetType, List<String> assetList) {
    String images = '{"unit_id": "$deviceID", "$assetType": "$assetList"}';
    return images;
  }

  decodeJson(String response) async {
    ///Need to replace '' with "" because as of now '' can't be parsed
    String responseJson = response.replaceAll('\'', '"');
    try {
      print("decodeJson");
      responseJsonDecoded = jsonDecode(responseJson);
      for(dynamic value in responseJsonDecoded.values) {
        print(value['instructions']);
        assessmentMessage = value['assessmentMessage'];
        userID = value['uniqueId'];
        notes = value['instructions'];
      }
    } catch (e) {
      print('decodeJson(): $e');
    }
  }
}