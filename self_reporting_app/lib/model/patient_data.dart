String volunteerAccessToken;
var triageQAPlaceHolder = TriageQAPlaceholder();

class TriageQAPlaceholder {
  bool coughOrThroatPain;
  bool problemBreathing;
  bool contactWithAnyCOVIDPatient;
  bool cameInContactWithPersonHavingCoughOrThroatPain;
  bool riskGroup;
  bool healthCareWorker;

  Map<String, bool> get triageQAPlaceholderValue {
    return {
      "coughOrThroatPain": coughOrThroatPain,
      "problemBreathing": problemBreathing,
      "contactWithAnyCOVIDPatient": contactWithAnyCOVIDPatient,
      "cameInContactWithPersonHavingCoughOrThroatPain":
          cameInContactWithPersonHavingCoughOrThroatPain,
      "riskGroup": riskGroup,
      "healthCareWorker": healthCareWorker,
    };
  }
}

var personalQAPlaceholder = PersonalQAPlaceholder();

class PersonalQAPlaceholder {
  String _fullName;
  String _phoneNumber;
  String _nid;
  String _gender;
  String _age;
  String _address;
  String _division;
  String _district;
  String _upazila;
  String _relationType;

  Map<String, dynamic> get personalQAPlaceholderValue {
    return {
      "fullName": _fullName,
      "phoneNumber": _phoneNumber,
      "nid": _nid,
      "gender": _gender,
      "age": _age,
      "address": _address,
      "division": _division,
      "district": _district,
      "upazila": _upazila,
      "relationType": _relationType
    };
  }

  set fullName(String value) {
    _fullName = value;
  }

  set relationType(String value) {
    _relationType = value;
  }

  set upazila(String value) {
    _upazila = value;
  }

  set district(String value) {
    _district = value;
  }

  set division(String value) {
    _division = value;
  }

  set address(String value) {
    _address = value;
  }

  set age(String value) {
    _age = value;
  }

  set gender(String value) {
    _gender = value;
  }

  set nid(String value) {
    _nid = value;
  }

  set phoneNumber(String value) {
    _phoneNumber = value;
  }
}

var citizenQAPlaceholder = CitizenQAPlaceholder();

class CitizenQAPlaceholder extends PersonalQAPlaceholder {
  String _patientFatherName;
  List<DateTime> _dateofReturnNRB;
  String _countryNRB;
  String _union;
  String _village;

  Map<String, dynamic> get citizenQAPlaceholderValue {
    return {
      "patientFatherName": _patientFatherName,
      "dateofReturnNRB": _dateofReturnNRB.toString(),
      "countryNRB": _countryNRB,
      "union": _union,
      "village": _village,
    };
  }

  set patientFatherName(String value) {
    _patientFatherName = value;
  }

  set village(String value) {
    _village = value;
  }

  set union(String value) {
    _union = value;
  }

  set countryNRB(String value) {
    _countryNRB = value;
  }

  set dateofReturnNRB(List<DateTime> value) {
    _dateofReturnNRB = value;
  }
}
