import 'dart:convert';

import 'package:selfreportingapp/model/patient_data.dart';
import 'package:selfreportingapp/services/geo_locator.dart';

String citizenData = jsonEncode({
  "name": {
    "type": "text",
    "question_bn": "ব্যক্তির নাম ",
    "question_en": "",
    "answer": "$fullName"
  },
  "phone": {
    "type": "text",
    "question_bn": "মোবাইল ",
    "question_en": "",
    "answer": "$phoneNumber"
  },
  "father_name": {
    "type": "text",
    "question_bn": "পিতার নাম ",
    "question_en": "",
    "answer": "$patientFatherName"
  },
  "gender": {
    "type": "text",
    "question_bn": "লিঙ্গ",
    "question_en": "",
    "answer": gender
  },
  "estimated_age": {
    "type": "text",
    "question_bn": "আনুমানিক বয়স",
    "question_en": "",
    "answer": "$age"
  },
  "came_back_bangladesh_at": {
    "type": "number",
    "question_bn": "দেশে ফেরার তারিখ",
    "question_en": "",
    "answer": 15234133213
  },
  "from_country": {
    "type": "text",
    "question_bn": "যে দেশ থেকে ফিরেছেনরিখ",
    "question_en": "",
    "answer": countryNRB
  },
  "division": {
    "type": "text",
    "question_bn": "বিভাগ",
    "question_en": "",
    "answer": division
  },
  "zilla": {
    "type": "text",
    "question_bn": "জেলা",
    "question_en": "",
    "answer": district
  },
  "upzilla": {
    "type": "text",
    "question_bn": "উপজেলা",
    "question_en": "",
    "answer": upazila
  },
  "union": {
    "type": "text",
    "question_bn": "",
    "question_en": "union",
    "answer": union
  },
  "ward": {
    "type": "text",
    "question_bn": "গ্রাম/ওয়ার্ড",
    "question_en": "",
    "answer": village
  },
  "house_no": {
    "type": "text",
    "question_bn": "বাড়ির নম্বর/ওয়ার্ড",
    "question_en": "",
    "answer": address
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
