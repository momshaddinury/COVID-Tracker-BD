# COVID-Tracker-BD
The initial goal is to create an app that will help in tracking live stats of Corona

App Name: COVID-19 Live Tracker (BETA)

Lead Developer: [Momshad Dinury](https://github.com/dinurymomshad)

## Sections
* [Resources Used](#resources-used)
* [Team members](#team-members)
* [App Features](#app-features)
* [API](#api)
* [Covid19 Cloud Functions](#covid19-cloud-functions)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
* [Contributors](#contributors)

## Resources Used
* Database: Google Cloud Firestore
* Backend: Google Cloud Functions
* Android Application: Flutter & Dart
* Map Provider: Leaflet

## Team members
* [Abdullah Z Khan Junaid (Cloud Functions & App)](https://github.com/AZKZero)
* [Mahbubur Rahman (Server and API)](https://github.com/mahbubcubd)
* Ibrahim Ullah (Data Logging and Model Analysis)

## App Features
1. User can check COVID19 Stat update of Bangladesh
2. User can see other infected people in the location tab
3. User can check global COVID19 update
4. User can participate in a survey to collect data

## API

* [JSON - Public pull data by number](#public-pull-data-by-number)
* [JSON - Public pull data by organization](#public-pull-data-by-organization)
* [JSON - POST single data](#post-single-data)

### Public API data
All POST requests have body application/json. The bodies are listed in [JSON Structure](#json-structure)

* HTTP POST [https://us-central1-covid19-bd.cloudfunctions.net/onUserResponseSubmit](https://us-central1-covid19-bd.cloudfunctions.net/onUserResponseSubmit)
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
				"age": {
					"type": "number",
					"question_bn": "আপনার বয়স? ",
					"question_en": "",
					"answer": "20"
				},
                "name": {
					"type": "number",
					"question_bn": "",
					"question_en": "",
					"answer": "md saifur rahman"
				},
				"is_feverish": {
					"type": "boolean",
					"question_bn": "আপনার কি জ্বর আছে বা জ্বরজ্বর অনুভব করছেন?",
					"question_en": "",
					"answer": "false"
				},
				"has_sore_throat": {
					"type": "boolean",
					"question_bn": "আপনার কি কাশি বা গলাব্যথা বা দুইটাই আছে? ",
					"question_en": "",
					"answer": "false"
				},
				"has_breathlessness": {
					"type": "boolean",
					"question_bn": "আপনার কি শ্বাসকষ্ট আছে বা শ্বাস নিতে বা ফেলতে কষ্ট হচ্ছে?",
					"question_en": "",
					"answer": "false"
				},
				"is_visited_abroad": {
					"type": "boolean",
					"question_bn": "আপনি কি বিগত ১৪ দিনের ভিতরে বিদেশ হতে এসেছেন?",
					"question_en": "",
					"answer": "false"
				},
				"is_contacted_with_covid": {
					"type": "boolean",
					"question_bn": "আপনি কি বিগত ১৪ দিনের ভিতরে করোনা ভাইরাসে ( কোবিড-১৯) আক্রান্ত এরকম কোন ব্যক্তির সংস্পর্শে এসেছিলেন ( একই স্থানে অবস্থান বা ভ্রমন )",
					"question_en": "",
					"answer": "false"
				},
				"is_contacted_with_family_who_cough": {
					"type": "boolean",
					"question_bn": "আপনার পরিবারের কোন সদস্য / অফিস কলিগ /একই সাথে থাকেন এরকম কোন ব্যক্তির কি জ্বর, কাশি, শ্বাসকষ্ট আছে? ",
					"question_en": "",
					"answer": "true"
				},
				"high_risk": {
					"type": "boolean",
					"question_bn": "আপনার কি অন্য কোন অসুখে  ভুগছেন (যেমন : ডায়াবেটিস, এজমা বা হাঁপানি , দীর্ঘমেয়াদি শ্বাসকষ্টের রোগ বা সিওপিডি, কিডনি রোগ, ক্যান্সার বা ক্যান্সারের জন্য কোন চিকিৎসা নিচ্ছেন?",
					"question_en": "",
					"answer": "true"
				},
				"location": {
					"latitude": 22,
					"longitude": 91,
					"altitude": 0
				},
				"nid": "10923921883712932",
				"address": "Lalmatia, Dhaka",
				"is_offline": true,
				"organization_id": "X",
				"organization_name": "covid19-bd_app",
				"user_phone": "01222222222",
				"metadata": {},
				"submitted_at": 15234133213,
				"created_at": 15234133213,
				"updated_at": 15234133213
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
**Request**
```json
{
    "data": {
        "age": {
            "type": "number",
            "question_bn": "আপনার বয়স? ",
            "question_en" : "",
            "answer": "20"
        },
        "name": {
			"type": "number",
    		"question_bn": "",
			"question_en": "",
			"answer": "MD saifur rahman"
		},
        "is_feverish": {
            "type": "boolean",
            "question_bn": "আপনার কি জ্বর আছে বা জ্বরজ্বর অনুভব করছেন?",
            "question_en" : "",
            "answer": "false"
        },
        "has_sore_throat": {
            "type": "boolean",
            "question_bn": "আপনার কি কাশি বা গলাব্যথা বা দুইটাই আছে? ",
            "question_en" : "",
            "answer": "false"
        },
        "has_breathlessness": {
            "type": "boolean",
            "question_bn": "আপনার কি শ্বাসকষ্ট আছে বা শ্বাস নিতে বা ফেলতে কষ্ট হচ্ছে?",
            "question_en" : "",
            "answer": "false"
        },
        "is_visited_abroad": {
            "type": "boolean",
            "question_bn": "আপনি কি বিগত ১৪ দিনের ভিতরে বিদেশ হতে এসেছেন?",
            "question_en" : "",
            "answer": "false"
        },
        "is_contacted_with_covid": {
            "type": "boolean",
            "question_bn": "আপনি কি বিগত ১৪ দিনের ভিতরে করোনা ভাইরাসে ( কোবিড-১৯) আক্রান্ত এরকম কোন ব্যক্তির সংস্পর্শে এসেছিলেন ( একই স্থানে অবস্থান বা ভ্রমন )",
            "question_en" : "",
            "answer": "false"
        },
        "is_contacted_with_family_who_cough": {
            "type": "boolean",
            "question_bn": "আপনার পরিবারের কোন সদস্য / অফিস কলিগ /একই সাথে থাকেন এরকম কোন ব্যক্তির কি জ্বর, কাশি, শ্বাসকষ্ট আছে? ",
            "question_en" : "",
            "answer": "true"
        },
        "high_risk": {
            "type": "boolean",
            "question_bn": "আপনার কি অন্য কোন অসুখে  ভুগছেন (যেমন : ডায়াবেটিস, এজমা বা হাঁপানি , দীর্ঘমেয়াদি শ্বাসকষ্টের রোগ বা সিওপিডি, কিডনি রোগ, ক্যান্সার বা ক্যান্সারের জন্য কোন চিকিৎসা নিচ্ছেন?",
            "question_en" : "",
            "answer": "true"
        },
        "location": {
            "latitude": 22,
            "longitude": 91,
            "altitude": 0
        },
        "nid":"10923921883712932",
        "address":"Lalmatia, Dhaka",
        "is_offline": true,
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
**Success**
```json
{
    "result": {
        "assessmentMessage": "Extra Urgent",
        "risk": 5,
        "uniqueId": "SZZTXTdwpjRDCxoGJGPd",
        "instructions": "<p><b>5: Immediate</b><br> <b>ফলাফল: আপনার করোনা ভাইরাস বা কোভিড-১৯ এ আক্রান্ত হওয়ার সমূহ সম্ভাবনা রয়েছে।</b><br> অতিসত্তর মোবাইলে আপনার নিকটবর্তী হাসপাতাল বা ৩৩৩, ১৬২৬৩, ১০৬৫৫ অথবা আইইডিসিআর এর হটলাইন নাম্বারে যোগাযোগ করবেন দেরি না করে শ্বাসকষ্টের চিকিৎসার জন্যে হাসপাতালে যান। হাসপাতালে যাওয়ার সময় অবস্যই মাস্ক পরিধান করবেন এবং গণপরিবহন বা ভীড় এড়িয়ে চলবেন। যাতাযাতের সময় আপনার সাথে শুধু একজন সঙ্গী থাকতে পারবে তবে তাঁর সাথে নিরাপদ দূরত্ব ( ৩ ফুট ) বজায় রাখতে হবে।  </p>",
        "numbers": [
            "333",
            "16263",
            "10655"
        ]
    }
}
```

Dashboard Was Inspired By:
https://github.com/spporan/covid19bdApp (Thanks to Shah Poran vai for his contribution)

## Covid19 Cloud Functions

### Prerequisites

- Learn about [Git](https://git-scm.com/)
  - Use Git (latest)
- Learn about [NodeJS](https://nodejs.org/) and [NPM](https://nodejs.org/)
  - Use Node v11.3.0
  - Use Npm v6.12.0
- Learn about [Firebase Tools](https://github.com/firebase/firebase-tools)
  - User v7.6.1
- Learn about [TSLint](https://palantir.github.io/tslint/)
  - Use v5.18.0
  
### Installation

Run `npm install -g firebase-tools` For Firebase Tools

Run `npm install -g tslint@5.18.0` for tsLint.

Run `npm install` to grab all project dependencies. (be on the project directory)

Now Run `cd functions` to be at cloud functions directory now run `npm install` to install all the dependencies

#### Build to development

Run  `firebase deploy --project development` to deploy the project to development environment.  

#### Firestore

Modify `firebase.firestore.rules` and `firebase.firestore.indexes.json`.

#### Storage

Modify `firebase.storage.rules`.

#### Hosting

Modify `firebase.json`.

#### Deployment

Run `firebase login` to login to your Firebase Console. Run `firebase deploy` to deploy the project and update firebase rules.

#### Run Firebase function locally

- go to function folder

`cd functions`

 - Start the emulator

`firebase emulator:start`

#### Deploy specific firebase function 

`firebase deploy --only functions:functionName`  

#### To call the firebase functions 
Note: You must provide the corresponding params

`https://us-central1-covid19-bd.cloudfunctions.net/onUserResponseSubmit`

`https://us-central1-covid19-bd.cloudfunctions.net/getUserByUserPhone`

#### Set Environment Variable  in firebase function
firebase functions:config:set service.name="your env var name "
firebase functions:config:set auth.migration_api=""

#### Further help

To get more help on Firebase Tools use `firebase help` or go check out the [Firebase Tools Documentation](https://github.com/firebase/firebase-tools).

## Contributors
- [Shah Poran](https://github.com/spporan)
- [Nur Farazi](https://github.com/nurfarazi)
- [Muhammad.Nazmul Ahsan](https://github.com/tarekahsan709)