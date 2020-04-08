import 'dart:convert';

import 'package:selfreportingapp/model/patient_data.dart';
import 'package:selfreportingapp/services/geo_locator.dart';

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
  "location": {
    "latitude": position.latitude,
    "longitude": position.longitude,
    "altitude": position.altitude
  },
  "relationship_id": relationType,
  "nid": nid,
  "address": address,
  "is_offline": false,
  "metadata": {},
  "submitted_at": DateTime.now().millisecondsSinceEpoch
});
