import 'dart:convert';

import 'package:selfreportingapp/model/patient_data.dart';
import 'package:selfreportingapp/services/geo_locator.dart';

double lat = position.latitude;
double lon = position.longitude;
double alt = position.altitude;

String mainCaseData = jsonEncode({
  "age": {"answer": "$age"},
  "phone": {"answer": "$phoneNumber"},
  "name": {"answer": "$fullName"},
  "gender": {"answer": gender},
  "has_sore_throat": {"answer": coughOrThroatPain},
  "has_breathlessness": {"answer": problemBreathing},
  "is_contacted_with_covid": {"answer": contactWithAnyCOVIDPatient},
  "is_contacted_with_family_who_cough": {
    "answer": cameInContactWithPersonHavingCoughOrThroatPain
  },
  "high_risk": {"answer": riskGroup},
  "is_healthcare_worker": {"answer": healthCareWorker},
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
