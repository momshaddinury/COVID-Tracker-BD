# COVID-Tracker-BD
The initial goal is to create an app that will help in tracking live stats of Corona

App Name: COVID-19 Live Tracker (BETA)

Lead Developer: Momshad Dinury

## Resources Used
* Database: Google Cloud Firestore
* Backend: Google Cloud Functions
* Android Application: Flutter & Dart
* Map Provider: Leaflet

## Team members:
* Abdullah Z Khan Junaid (App)
* Mahbubur Rahman (Server and API)
* Ibrahim Ullah (Data Logging and Model Analysis)

## App Features:
1. User can check COVID19 Stat update of Bangladesh
2. User can see other infected people in the location tab
3. User can check global COVID19 update
4. User can participate in a survey to collect data

## API

* [JSON - Public pull data by number](#public-pull-data-by-number)
* [JSON - Public pull data by organization](#public-pull-data-by-organization)
* [JSON - POST single data](#post-single-data)

### Public API data
* HTTP POST [https://us-central1-covid19-bd.cloudfunctions.net/onUserResponseSubmit](https://us-central1-covid19-bd.cloudfunctions.net/onUserResponseSubmit](https://us-central1-covid19-bd.cloudfunctions.net/onUserResponseSubmit](https://us-central1-covid19-bd.cloudfunctions.net/onUserResponseSubmit)
* HTTP POST [https://us-central1-covid19-bd.cloudfunctions.net/getResponsesByUserPhone](https://us-central1-covid19-bd.cloudfunctions.net/getResponsesByUserPhone)
* HTTP POST [https://us-central1-covid19-bd.cloudfunctions.net/getResponsesByOrgName](https://us-central1-covid19-bd.cloudfunctions.net/getResponsesByOrgName)

### JSON Structure
#### Public pull data by number
**Request**
```json
{
    "data": {
        "number": "01222222222"
    }
}
```
**Fail**
```json
{
    "result": {
        "error": "<error_msg>"
    }
}
```
**Success**
```json
{
    "result": {
        "responses": [
            {
                "updated_at": 15234133213,
                "age": {
                    "type": "number",
                    "answer": "20",
                    "question": "আপনার বয়স? "
                },
                "nid": "10923921883712932",
                "is_visited_abroad": {
                    "type": "boolean",
                    "answer": "false",
                    "question": "আপনি কি বিগত ১৪ দিনের ভিতরে বিদেশ হতে এসেছেন?"
                },
                "is_feverish": {
                    "question": "আপনার কি জ্বর আছে বা জ্বরজ্বর অনুভব করছেন?",
                    "type": "boolean",
                    "answer": "false"
                },
                "is_contacted_with_covid": {
                    "question": "আপনি কি বিগত ১৪ দিনের ভিতরে করোনা ভাইরাসে ( কোবিড-১৯) আক্রান্ত এরকম কোন ব্যক্তির সংস্পর্শে এসেছিলেন ( একই স্থানে অবস্থান বা ভ্রমন )",
                    "type": "boolean",
                    "answer": "false"
                },
                "submitted_at": 15234133213,
                "has_sore_throat": {
                    "question": "আপনার কি কাশি বা গলাব্যথা বা দুইটাই আছে? ",
                    "type": "boolean",
                    "answer": "false"
                },
                "organization_id": "X",
                "has_breathlessness": {
                    "question": "আপনার কি শ্বাসকষ্ট আছে বা শ্বাস নিতে বা ফেলতে কষ্ট হচ্ছে?",
                    "type": "boolean",
                    "answer": "false"
                },
                "user_phone": "01222222222",
                "address": "Lalmatia, Dhaka",
                "organization_name": "covid19-bd_app",
                "metadata": {},
                "is_contacted_with_family_who_cough": {
                    "question": "আপনার পরিবারের কোন সদস্য / অফিস কলিগ /একই সাথে থাকেন এরকম কোন ব্যক্তির কি জ্বর, কাশি, শ্বাসকষ্ট আছে? ",
                    "type": "boolean",
                    "answer": "true"
                },
                "high_risk": {
                    "question": "আপনার কি অন্য কোন অসুখে  ভুগছেন (যেমন : ডায়াবেটিস, এজমা বা হাঁপানি , দীর্ঘমেয়াদি শ্বাসকষ্টের রোগ বা সিওপিডি, কিডনি রোগ, ক্যান্সার বা ক্যান্সারের জন্য কোন চিকিৎসা নিচ্ছেন?",
                    "type": "boolean",
                    "answer": "true"
                },
                "location": {
                    "latitude": 22,
                    "longitude": 91,
                    "altitude": 0
                },
                "created_at": 15234133213
            },
            {
                "metadata": {},
                "is_contacted_with_family_who_cough": {
                    "question": "আপনার পরিবারের কোন সদস্য / অফিস কলিগ /একই সাথে থাকেন এরকম কোন ব্যক্তির কি জ্বর, কাশি, শ্বাসকষ্ট আছে? ",
                    "type": "boolean",
                    "answer": "true"
                },
                "high_risk": {
                    "question": "আপনার কি অন্য কোন অসুখে  ভুগছেন (যেমন : ডায়াবেটিস, এজমা বা হাঁপানি , দীর্ঘমেয়াদি শ্বাসকষ্টের রোগ বা সিওপিডি, কিডনি রোগ, ক্যান্সার বা ক্যান্সারের জন্য কোন চিকিৎসা নিচ্ছেন?",
                    "type": "boolean",
                    "answer": "true"
                },
                "location": {
                    "latitude": 22,
                    "longitude": 91,
                    "altitude": 0
                },
                "created_at": 15234133213,
                "updated_at": 15234133213,
                "age": {
                    "question": "আপনার বয়স? ",
                    "type": "number",
                    "answer": "20"
                },
                "nid": "10923921883712932",
                "is_visited_abroad": {
                    "question": "আপনি কি বিগত ১৪ দিনের ভিতরে বিদেশ হতে এসেছেন?",
                    "type": "boolean",
                    "answer": "false"
                },
                "is_feverish": {
                    "question": "আপনার কি জ্বর আছে বা জ্বরজ্বর অনুভব করছেন?",
                    "type": "boolean",
                    "answer": "false"
                },
                "is_contacted_with_covid": {
                    "type": "boolean",
                    "answer": "false",
                    "question": "আপনি কি বিগত ১৪ দিনের ভিতরে করোনা ভাইরাসে ( কোবিড-১৯) আক্রান্ত এরকম কোন ব্যক্তির সংস্পর্শে এসেছিলেন ( একই স্থানে অবস্থান বা ভ্রমন )"
                },
                "submitted_at": 15234133213,
                "has_sore_throat": {
                    "type": "boolean",
                    "answer": "false",
                    "question": "আপনার কি কাশি বা গলাব্যথা বা দুইটাই আছে? "
                },
                "organization_id": "X",
                "has_breathlessness": {
                    "question": "আপনার কি শ্বাসকষ্ট আছে বা শ্বাস নিতে বা ফেলতে কষ্ট হচ্ছে?",
                    "type": "boolean",
                    "answer": "false"
                },
                "user_phone": "01222222222",
                "address": "Lalmatia, Dhaka",
                "organization_name": "covid19-bd_app"
            },
            {
                "is_contacted_with_covid": {
                    "question": "আপনি কি বিগত ১৪ দিনের ভিতরে করোনা ভাইরাসে ( কোবিড-১৯) আক্রান্ত এরকম কোন ব্যক্তির সংস্পর্শে এসেছিলেন ( একই স্থানে অবস্থান বা ভ্রমন )",
                    "type": "boolean",
                    "answer": "false"
                },
                "submitted_at": 15234133213,
                "has_sore_throat": {
                    "question": "আপনার কি কাশি বা গলাব্যথা বা দুইটাই আছে? ",
                    "type": "boolean",
                    "answer": "false"
                },
                "organization_id": "X",
                "has_breathlessness": {
                    "question": "আপনার কি শ্বাসকষ্ট আছে বা শ্বাস নিতে বা ফেলতে কষ্ট হচ্ছে?",
                    "type": "boolean",
                    "answer": "false"
                },
                "user_phone": "01222222222",
                "address": "Lalmatia, Dhaka",
                "organization_name": "covid19-bd_app",
                "metadata": {},
                "is_contacted_with_family_who_cough": {
                    "question": "আপনার পরিবারের কোন সদস্য / অফিস কলিগ /একই সাথে থাকেন এরকম কোন ব্যক্তির কি জ্বর, কাশি, শ্বাসকষ্ট আছে? ",
                    "type": "boolean",
                    "answer": "true"
                },
                "high_risk": {
                    "question": "আপনার কি অন্য কোন অসুখে  ভুগছেন (যেমন : ডায়াবেটিস, এজমা বা হাঁপানি , দীর্ঘমেয়াদি শ্বাসকষ্টের রোগ বা সিওপিডি, কিডনি রোগ, ক্যান্সার বা ক্যান্সারের জন্য কোন চিকিৎসা নিচ্ছেন?",
                    "type": "boolean",
                    "answer": "true"
                },
                "location": {
                    "longitude": 91,
                    "altitude": 0,
                    "latitude": 22
                },
                "created_at": 15234133213,
                "updated_at": 15234133213,
                "age": {
                    "question": "আপনার বয়স? ",
                    "type": "number",
                    "answer": "20"
                },
                "nid": "10923921883712932",
                "is_visited_abroad": {
                    "question": "আপনি কি বিগত ১৪ দিনের ভিতরে বিদেশ হতে এসেছেন?",
                    "type": "boolean",
                    "answer": "false"
                },
                "is_feverish": {
                    "question": "আপনার কি জ্বর আছে বা জ্বরজ্বর অনুভব করছেন?",
                    "type": "boolean",
                    "answer": "false"
                }
            }
        ]
    }
}
```
#### Public pull data by organization
**Request**
```json
{
    "data": {
        "organization_name": "X"
    }
}
```
**Fail**
```json
{
    "result": {
        "error": "<error_msg>"
    }
}
```
**Success**
*Same as by phone number*
#### POST single data
```json
{
    "data": {
        "age": {
            "type": "number",
            "question": "আপনার বয়স? ",
            "answer": "20"
        },
        "is_feverish": {
            "type": "boolean",
            "question": "আপনার কি জ্বর আছে বা জ্বরজ্বর অনুভব করছেন?",
            "answer": "false"
        },
        "has_sore_throat": {
            "type": "boolean",
            "question": "আপনার কি কাশি বা গলাব্যথা বা দুইটাই আছে? ",
            "answer": "false"
        },
        "has_breathlessness": {
            "type": "boolean",
            "question": "আপনার কি শ্বাসকষ্ট আছে বা শ্বাস নিতে বা ফেলতে কষ্ট হচ্ছে?",
            "answer": "false"
        },
        "is_visited_abroad": {
            "type": "boolean",
            "question": "আপনি কি বিগত ১৪ দিনের ভিতরে বিদেশ হতে এসেছেন?",
            "answer": "false"
        },
        "is_contacted_with_covid": {
            "type": "boolean",
            "question": "আপনি কি বিগত ১৪ দিনের ভিতরে করোনা ভাইরাসে ( কোবিড-১৯) আক্রান্ত এরকম কোন ব্যক্তির সংস্পর্শে এসেছিলেন ( একই স্থানে অবস্থান বা ভ্রমন )",
            "answer": "false"
        },
        "is_contacted_with_family_who_cough": {
            "type": "boolean",
            "question": "আপনার পরিবারের কোন সদস্য / অফিস কলিগ /একই সাথে থাকেন এরকম কোন ব্যক্তির কি জ্বর, কাশি, শ্বাসকষ্ট আছে? ",
            "answer": "true"
        },
        "high_risk": {
            "type": "boolean",
            "question": "আপনার কি অন্য কোন অসুখে  ভুগছেন (যেমন : ডায়াবেটিস, এজমা বা হাঁপানি , দীর্ঘমেয়াদি শ্বাসকষ্টের রোগ বা সিওপিডি, কিডনি রোগ, ক্যান্সার বা ক্যান্সারের জন্য কোন চিকিৎসা নিচ্ছেন?",
            "answer": "true"
        },
        "location": {
            "latitude": 22,
            "longitude": 91,
            "altitude": 0
        },
        "nid":"10923921883712932",
        "address":"Lalmatia, Dhaka",
        "organization_id":"X",
        "organization_name":"covid19-bd_app",
        "user_phone":"01222222222",
        "metadata":{},
        "submitted_at": 15234133213,
        "created_at": 15234133213,
        "updated_at": 15234133213
    }
}
```

Dashboard Was Inspired By:
https://github.com/spporan/covid19bdApp (Thanks to Shah Poran vai for his contribution)
