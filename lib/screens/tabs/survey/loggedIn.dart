import 'package:covidtrackerbd/model/users.dart';
import 'package:covidtrackerbd/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'loggedOut.dart';


String fullName;
String gender;
int age;
String phoneNumber;
String isInfected;
String profession;
int breathCount;
int temp;
int interaction;
String date;
String isContacted;
String location;

class LogInToSubmit extends StatefulWidget {
  @override
  _LogInToSubmitState createState() => _LogInToSubmitState();
}

class _LogInToSubmitState extends State<LogInToSubmit> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user == null) {
      return LoggedOut();
    } else {
      return Scaffold(
        body: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  COVIDForm(),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}

class COVIDForm extends StatefulWidget {
  @override
  _COVIDFormState createState() => _COVIDFormState();
}

class _COVIDFormState extends State<COVIDForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AuthService auth = AuthService();
//    PatientDataModel model = PatientDataModel();
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;

    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Text(
                "PLEASE STAY HOME, STAY SAFE",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.red,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "Please fill the form with correct information. If you show any symptoms or if you are at risk you'll be contacted. So make sure your information is correct",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.red,
                ),
              ),
            ),
            //Full name
            Container(
              alignment: Alignment.topCenter,
              width: halfMediaWidth,
              child: FormField(
                hintText: "Full Name",
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Enter your name";
                  }
                  return null;
                },
                onSaved: (String value) {
                  fullName = value;
                },
              ),
            ),
            Row(children: <Widget>[
              //Gender
              Expanded(
                child: Container(
                  alignment: Alignment.topCenter,
                  width: halfMediaWidth,
                  child: FormField(
                    hintText: "Gender",
                    /*validator: (String value) {
                      if (value.isEmpty) {
                        return "Enter your gender";
                      }
                      return null;
                    },*/
                    onSaved: (String value) {
                      gender = value;
                    },
                  ),
                ),
              ),
              //Age
              Expanded(
                child: Container(
                  alignment: Alignment.topCenter,
                  width: halfMediaWidth,
                  child: FormField(
                    hintText: "AGE (Number)",
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Enter your age";
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      age = int.parse(value);
                    },
                  ),
                ),
              ),
            ]),
            //Phone number
            Container(
              alignment: Alignment.topCenter,
              width: halfMediaWidth,
              child: FormField(
                isPhone: true,
                hintText: "Phone number (required)",
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Enter your number";
                  } else if (value.length < 11 || value.length > 11) {
                    return "Enter your number correctly";
                  }
                  return null;
                },
                onSaved: (String value) {
                  phoneNumber = value;
                },
              ),
            ),
            //Symptoms
            Container(
              alignment: Alignment.topCenter,
              width: halfMediaWidth,
              child: FormField(
                hintText: "Are you showing any symptoms? (Yes/No)",
                /*validator: (String value) {
                  if (value.isEmpty) {
                    return "Enter your response";
                  }
                  return null;
                },*/
                onSaved: (String value) {
                  isInfected = value;
                },
              ),
            ),
            //Profession
            Container(
              alignment: Alignment.topCenter,
              width: halfMediaWidth,
              child: FormField(
                hintText: "Profession",
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Enter your response";
                  }
                  return null;
                },
                onSaved: (String value) {
                  profession = value;
                },
              ),
            ),
            Row(
              children: <Widget>[
                //Breath Count
                Expanded(
                  child: Container(
                    alignment: Alignment.topCenter,
                    width: halfMediaWidth,
                    child: FormField(
                      hintText: "Breath Count/Minute",
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Enter your response";
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        breathCount = int.parse(value);
                      },
                    ),
                  ),
                ),
                //Temp
                Expanded(
                  child: Container(
                    alignment: Alignment.topCenter,
                    width: halfMediaWidth,
                    child: FormField(
                      hintText: "Temperature (Celcius)",
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Enter your temperature";
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        temp = int.parse(value);
                      },
                    ),
                  ),
                ),
              ],
            ),
            // Interaction with people
            Container(
              alignment: Alignment.topCenter,
              width: halfMediaWidth,
              child: FormField(
                hintText:
                    "How many people have you interected with in last 3 hours?",
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Enter your response";
                  }
                  return null;
                },
                onSaved: (String value) {
                  interaction = int.parse(value);
                },
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              width: halfMediaWidth,
              child: FormField(
                hintText: "Symptoms First Shown? (dd/mm/yyyy)",
                onSaved: (String value) {
                  date = value;
                },
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              width: halfMediaWidth,
              child: FormField(
                hintText:
                    "Did you come in contact with anyone from abroad? (Yes/No)",
                /*validator: (bool value) {
                  if (value == null) {
                    return "Enter your response";
                  }
                  return null;
                },*/
                onSaved: (String value) {
                  isContacted = value;
                },
              ),
            ),
            /*SubmitButton(auth: auth),*/
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 10.0, // soften the shadow
                  spreadRadius: 1.0, //extend the shadow
                  offset: Offset(
                    0.0, // Move to right 10  horizontally
                    2.0, // Move to bottom 10 Vertically
                  ),
                )
              ]),
              margin: EdgeInsets.all(10),
              child: FlatButton(
                padding: EdgeInsets.all(15),
                child: Text(
                  'SUBMIT',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                color: Colors.red[400],
                textColor: Colors.white,
                onPressed: () async {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    /* PatientDataModel(
                        fullName: fullName,
                        gender: gender,
                        age: age,
                        phoneNumber: phoneNumber,
                        isInfected: isInfected,
                        profession: profession,
                        breathCount: breathCount,
                        temp: temp,
                        interaction: interaction,
                        date: date,
                        isContacted: isContacted);*/
                    await auth.updateDB();
                    await auth.signOut();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FormField extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isPhone;

  FormField(
      {this.hintText, this.validator, this.onSaved, this.isPhone = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.all(15.0),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[200],
        ),
        validator: validator,
        onSaved: onSaved,
        keyboardType: isPhone ? TextInputType.number : TextInputType.text,
      ),
    );
  }
}
