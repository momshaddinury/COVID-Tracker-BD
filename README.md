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

* [Public API to pull data](#public-api-to-pull-data)
* [Push Data (Authorized Users Only)](#push-data-authorized-users-only)
* [JSON - Pull data](#public-pull-all-data)
* [JSON - Pull single data](#public-pull-single-data)
* [JSON - Authorized PATCH single data](#autorized-patch-single-data)

### Public API to pull data
* HTTP GET [https://firestore.googleapis.com/v1/projects/covid19-bd/databases/(default)/documents/COVIDARC/](https://firestore.googleapis.com/v1/projects/covid19-bd/databases/(default)/documents/COVIDARC/)
* HTTP GET [https://firestore.googleapis.com/v1/projects/covid19-bd/databases/(default)/documents/COVIDARC/<phone_number>](https://firestore.googleapis.com/v1/projects/covid19-bd/databases/(default)/documents/COVIDARC/)

### Push Data (Authorized Users Only)
HTTP PATCH [https://firestore.googleapis.com/v1/projects/covid19-bd/databases/(default)/documents/COVIDARC/<phone_number>?key=${key}]()

### JSON Structure
#### Public pull all data
```json
{
  "documents": [
    {
      "name": "projects/covid19-bd/databases/(default)/documents/COVIDARC/01222222222",
      "fields": {
        "Profession": {
          "stringValue": "Student"
        },
        "User location": {
          "stringValue": "lat: 22.0000000, lon: 91.0000000, alt: 0.0"
        },
        "Age": {
          "integerValue": "22"
        },
        "Temperature": {
          "stringValue": "YES"
        },
        "Migrant": {
          "stringValue": "YES"
        },
        "Date of First Showing Symptoms": {
          "arrayValue": {
            "values": [
              {
                "timestampValue": "2020-03-19T18:00:00Z"
              }
            ]
          }
        },
        "NID": {
          "stringValue": ""
        },
        "Breathing Pattern/Minute": {
          "stringValue": "36"
        },
        "Name": {
          "stringValue": "John"
        },
        "Symptoms": {
          "arrayValue": {
            "values": [
              {
                "stringValue": "Fever"
              },
              {
                "stringValue": "Cough"
              },
              {
                "stringValue": "Sore Throat"
              }
            ]
          }
        },
        "Came in Contact with NRB": {
          "stringValue": "NO"
        },
        "Phone": {
          "stringValue": "01222222222"
        },
        "Gender": {
          "stringValue": "Male"
        },
        "Anyone in  the Familu Showing Symptoms": {
          "stringValue": "NO"
        },
        "Risk Group": {
          "arrayValue": {
            "values": [
              {
                "stringValue": "None"
              }
            ]
          }
        }
      },
      "createTime": "2020-03-23T09:49:42.538963Z",
      "updateTime": "2020-03-23T10:17:45.371514Z"
    }
  ]
}
```

#### Public pull single data
```json
{
  "name": "projects/covid19-bd/databases/(default)/documents/COVIDARC/01222222222",
  "fields": {
    "User location": {
      "stringValue": "lat: 22.440346, lon: 91.8216247, alt: 0.0"
    },
    "Age": {
      "integerValue": "22"
    },
    "Temperature": {
      "stringValue": "YES"
    },
    "Migrant": {
      "stringValue": "YES"
    },
    "Date of First Showing Symptoms": {
      "arrayValue": {
        "values": [
          {
            "timestampValue": "2020-03-19T18:00:00Z"
          }
        ]
      }
    },
    "NID": {
      "stringValue": ""
    },
    "Breathing Pattern/Minute": {
      "stringValue": "36"
    },
    "Symptoms": {
      "arrayValue": {
        "values": [
          {
            "stringValue": "Fever"
          },
          {
            "stringValue": "Cough"
          },
          {
            "stringValue": "Sore Throat"
          }
        ]
      }
    },
    "Name": {
      "stringValue": "John"
    },
    "Came in Contact with NRB": {
      "stringValue": "NO"
    },
    "Phone": {
      "stringValue": "01222222222"
    },
    "Gender": {
      "stringValue": "Male"
    },
    "Anyone in  the Familu Showing Symptoms": {
      "stringValue": "NO"
    },
    "Risk Group": {
      "arrayValue": {
        "values": [
          {
            "stringValue": "None"
          }
        ]
      }
    },
    "Profession": {
      "stringValue": "Student"
    }
  },
  "createTime": "2020-03-23T09:49:42.538963Z",
  "updateTime": "2020-03-23T10:17:45.371514Z"
}
```


#### Autorized PATCH single data
```json
{"fields": {
    "User location": {
      "stringValue": "lat: 22.440346, lon: 91.8216247, alt: 0.0"
    },
    "Age": {
      "integerValue": "22"
    },
    "Temperature": {
      "stringValue": "YES"
    },
    "Migrant": {
      "stringValue": "YES"
    },
    "Date of First Showing Symptoms": {
      "arrayValue": {
        "values": [
          {
            "timestampValue": "2020-03-19T18:00:00Z"
          }
        ]
      }
    },
    "NID": {
      "stringValue": ""
    },
    "Breathing Pattern/Minute": {
      "stringValue": "36"
    },
    "Symptoms": {
      "arrayValue": {
        "values": [
          {
            "stringValue": "Fever"
          },
          {
            "stringValue": "Cough"
          },
          {
            "stringValue": "Sore Throat"
          }
        ]
      }
    },
    "Name": {
      "stringValue": "John"
    },
    "Came in Contact with NRB": {
      "stringValue": "NO"
    },
    "Phone": {
      "stringValue": "01222222222"
    },
    "Gender": {
      "stringValue": "Male"
    },
    "Anyone in  the Familu Showing Symptoms": {
      "stringValue": "NO"
    },
    "Risk Group": {
      "arrayValue": {
        "values": [
          {
            "stringValue": "None"
          }
        ]
      }
    },
    "Profession": {
      "stringValue": "Student"
    }
  }
}
```

Dashboard Was Inspired By:
https://github.com/spporan/covid19bdApp (Thanks to Shah Poran vai for his contribution)
