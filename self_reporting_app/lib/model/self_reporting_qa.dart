import 'dart:convert';

import 'package:selfreportingapp/model/patient_data.dart';
import 'package:selfreportingapp/services/geo_locator.dart';

String data = jsonEncode({
  "age": {
    "type": "text",
    "question_bn": "আপনার বয়স? ",
    "question_en": "",
    "answer": "$age"
  },
  "phone": {
    "type": "text",
    "question_bn": "",
    "question_en": "",
    "answer": "$phoneNumber"
  },
  "name": {
    "type": "text",
    "question_bn": "আপনার নাম?",
    "question_en": "",
    "answer": "$fullName"
  },
  "gender": {
    "type": "text",
    "question_bn": "",
    "question_en": "",
    "answer": gender
  },
  "is_feverish": {
    "type": "boolean",
    "question_bn": "আপনার কি জ্বর আছে বা জ্বরজ্বর অনুভব করছেন?",
    "question_en": "",
    "answer": fever
  },
  "has_sore_throat": {
    "type": "boolean",
    "question_bn": "আপনার কি কাশি বা গলাব্যথা বা দুইটাই আছে? ",
    "question_en": "",
    "answer": coughOrThroatPain
  },
  "has_breathlessness": {
    "type": "boolean",
    "question_bn": "আপনার কি শ্বাসকষ্ট আছে বা শ্বাস নিতে বা ফেলতে কষ্ট হচ্ছে?",
    "question_en": "",
    "answer": problemBreathing
  },
  "is_visited_abroad": {
    "type": "boolean",
    "question_bn": "আপনি কি বিগত ১৪ দিনের ভিতরে বিদেশ হতে এসেছেন?",
    "question_en": "",
    "answer": cameBackFromAbroad
  },
  "is_contacted_with_covid": {
    "type": "boolean",
    "question_bn":
        "আপনি কি বিগত ১৪ দিনের ভিতরে করোনা ভাইরাসে ( কোবিড-১৯) আক্রান্ত এরকম কোন ব্যক্তির সংস্পর্শে এসেছিলেন ( একই স্থানে অবস্থান বা ভ্রমন )",
    "question_en": "",
    "answer": contactWithAnyCOVIDPatient
  },
  "is_contacted_with_family_who_cough": {
    "type": "boolean",
    "question_bn":
        "গত ১৪ দিনে জর, কাশি, শ্বাসকষ্ট আছে এমন কারোর সংস্পর্শে কি আপনি এসেছিলেন ( পরিবার সদস্য / অফিস কলিগ )? ",
    "question_en": "",
    "answer": cameInContactWithPersonHavingCoughOrThroatPain
  },
  "high_risk": {
    "type": "boolean",
    "question_bn":
        "আপনার কি অন্য কোন অসুখে  ভুগছেন (যেমন : ডায়াবেটিস, এজমা বা হাঁপানি , দীর্ঘমেয়াদি শ্বাসকষ্টের রোগ বা সিওপিডি, কিডনি রোগ, ক্যান্সার বা ক্যান্সারের জন্য কোন চিকিৎসা নিচ্ছেন?",
    "question_en": "",
    "answer": riskGroup
  },
  "location": {"latitude": "", "longitude": "", "altitude": ""},
  "relationship": "",
  "relationship_id": "",
  "nid": nid,
  "address": "",
  "is_offline": false,
  "offline_response": "",
  "metadata": {},
  "submitted_at": DateTime.now().millisecondsSinceEpoch
});
