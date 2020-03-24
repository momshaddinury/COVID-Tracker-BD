import 'package:covidtrackerbd/model/patientDataModel.dart';
import 'package:covidtrackerbd/model/users.dart';
import 'package:covidtrackerbd/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'loggedOut.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
//          color: Colors.white,
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
  final AuthService auth = AuthService();
  var data;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  ValueChanged _onChanged = (val) => print(val);

  @override
  void dispose() {
    signOut();
    super.dispose();
  }

  signOut() async {
    await auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
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
            SizedBox(
              height: 10,
            ),
            FormBuilder(
              // context,
              key: _fbKey,
              autovalidate: true,
              initialValue: {
                'movie_rating': 5,
              },
              readOnly: false,
              child: Column(
                children: <Widget>[
                  //Name
                  FormBuilderTextField(
                    attribute: "name",
                    decoration: InputDecoration(
                      labelText: "Input Your Name",
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    //onChanged: _onChanged,
                    onSaved: (value) => fullName = value,
                  ),
                  // Age
                  FormBuilderTextField(
                    attribute: "age",
                    decoration: InputDecoration(
                      labelText: "Input Your Age",
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    //onChanged: _onChanged,
                    valueTransformer: (text) => num.tryParse(text),
                    validators: [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                    ],
                    //onSaved: (value) => age = value,
                    keyboardType: TextInputType.number,
                  ),

                  //Gender:
                  FormBuilderChoiceChip(
                    attribute: 'choice_chip',
                    decoration: InputDecoration(
                      labelText: 'Select Gender',
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    options: [
                      FormBuilderFieldOption(
                        value: 'Male',
                        child: Text('Male'),
                      ),
                      FormBuilderFieldOption(
                          value: 'Female', child: Text('Female')),
                    ],
                    //onChanged: (value) => print(value),
                    onSaved: (value) => gender = value,
                  ),

                  //Profession
                  FormBuilderTextField(
                    attribute: "profession",
                    decoration: InputDecoration(
                      labelText: "Profession",
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    //onChanged: _onChanged,
                    onSaved: (value) => profession = value,
                  ),

                  //Contact Number:
                  FormBuilderTextField(
                    attribute: "phonenumber",
                    decoration: InputDecoration(
                      labelText: "Contact Number [11 Digit]",
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    //onChanged: _onChanged,
                    keyboardType: TextInputType.number,
                    validators: [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.numeric(),
                      FormBuilderValidators.minLength(11,
                          errorText: "Less than 11 digit"),
                      FormBuilderValidators.maxLength(11,
                          errorText: "More than 11 digit")
                    ],
                    onSaved: (value) => phoneNumber = value,
                  ),

                  //NID:
                  FormBuilderTextField(
                    attribute: "number",
                    decoration: InputDecoration(
                      labelText: "NID [10 Digit]",
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    //onChanged: _onChanged,
                    keyboardType: TextInputType.number,
                    validators: [
                      FormBuilderValidators.numeric(),
                      FormBuilderValidators.minLength(10,
                          errorText: "Less than 10 digit"),
                      FormBuilderValidators.maxLength(10,
                          errorText: "More than 10 digit")
                    ],
                    onSaved: (value) => nid = value,
                  ),

                  // Migrant:
                  FormBuilderChoiceChip(
                    attribute: 'choice_chip',
                    decoration: InputDecoration(
                      labelText: 'Returned from Abroad?',
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    options: [
                      FormBuilderFieldOption(
                        value: 'YES',
                        child: Text('YES'),
                      ),
                      FormBuilderFieldOption(value: 'NO', child: Text('NO')),
                    ],
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                    //onChanged: (value) => print(value),
                    onSaved: (value) => migrant = value,
                  ),

                  //Came in Contact with NRB:
                  FormBuilderChoiceChip(
                    attribute: 'choice_chip',
                    decoration: InputDecoration(
                      labelText: 'Met anyone from Abroad within 14 days?',
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    options: [
                      FormBuilderFieldOption(
                        value: 'YES',
                        child: Text('YES'),
                      ),
                      FormBuilderFieldOption(value: 'NO', child: Text('NO')),
                    ],
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                    //onChanged: (value) => print(value),
                    onSaved: (value) => isContacted = value,
                  ),

                  //Anyone from the family showing symptoms
                  FormBuilderChoiceChip(
                    attribute: 'choice_chip',
                    decoration: InputDecoration(
                      labelText: 'Anyone in the Family has Symtoms of COVID?',
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    options: [
                      FormBuilderFieldOption(
                        value: 'YES',
                        child: Text('YES'),
                      ),
                      FormBuilderFieldOption(value: 'NO', child: Text('NO')),
                    ],
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                    // onChanged: (value) => print(value),
                    onSaved: (value) => isAnyoneInFamily = value,
                  ),

                  // Date of First showing symptoms
                  FormBuilderDateRangePicker(
                    attribute: "date_range",
                    firstDate: DateTime(1970),
                    lastDate: DateTime(2030),
                    format: DateFormat("yyyy-MM-dd"),
                    //onChanged: _onChanged,
                    onSaved: (value) => date = value,
                    decoration: InputDecoration(
                      hintText: "When did you first started showing Symptoms?",
                      hintMaxLines: 2,
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    validators: [],
                  ),

                  //Breathing Pattern
                  FormBuilderTextField(
                    attribute: "number",
                    decoration: InputDecoration(
                      hintText:
                          "Input Breathing Pattern/Minute. Hint: ( Start Stopwatch and measure your breath)",
                      hintMaxLines: 3,
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    onChanged: _onChanged,
                    //onSaved: (value) => breathCount = value,
                    keyboardType: TextInputType.number,
                  ),
                  //Fever:
                  FormBuilderChoiceChip(
                    attribute: 'choice_chip',
                    decoration: InputDecoration(
                      labelText: 'Do you have fever above 100?',
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    options: [
                      FormBuilderFieldOption(
                        value: 'YES',
                        child: Text('YES'),
                      ),
                      FormBuilderFieldOption(value: 'NO', child: Text('NO')),
                    ],
                    //onChanged: (value) => print(value),
                    onSaved: (value) => fever = value,
                  ),

                  //Symptoms
                  FormBuilderFilterChip(
                    attribute: 'filter_chip',
                    selectedColor: Colors.green[200],
                    decoration: InputDecoration(
                      labelText: 'Select Symptoms ',
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    options: [
                      FormBuilderFieldOption(
                          value: 'Fever', child: Text('Fever')),
                      FormBuilderFieldOption(
                          value: 'Cough', child: Text('Cough')),
                      FormBuilderFieldOption(
                          value: 'Sore Throat', child: Text('Sore Throat')),
                      FormBuilderFieldOption(
                          value: 'Shortness of Breath',
                          child: Text('Shortness of Breath')),
                      FormBuilderFieldOption(
                          value: 'Fatigue', child: Text('Fatigue')),
                      FormBuilderFieldOption(
                          value: 'Aches & Pain', child: Text('Aches & Pain')),
                      FormBuilderFieldOption(
                          value: 'Headaches', child: Text('Headaches')),
                      FormBuilderFieldOption(
                          value: 'Runny or Stuffy Nose',
                          child: Text('Runny or Stuffy Nose')),
                      FormBuilderFieldOption(
                          value: 'Sneezing', child: Text('Sneezing')),
                      FormBuilderFieldOption(
                          value: 'Diarrhoea', child: Text('Diarrhoea')),
                      FormBuilderFieldOption(
                          value: 'None', child: Text('None')),
                    ],
                    //onChanged: (value) => print(value),
                    onSaved: (value) => symptoms = value,
                  ),

                  // Higher Risk Group
                  FormBuilderFilterChip(
                    attribute: 'filter_chip',
                    selectedColor: Colors.green[200],
                    decoration: InputDecoration(
                      labelText: 'Do you have any of these?',
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    options: [
                      FormBuilderFieldOption(
                          value: 'Asthma', child: Text('Asthma')),
                      FormBuilderFieldOption(
                          value: 'Pregnant', child: Text('Pregnant')),
                      FormBuilderFieldOption(
                          value: 'Heart Disease', child: Text('Heart Disease')),
                      FormBuilderFieldOption(
                          value: 'Diabetes', child: Text('Diabetes')),
                      FormBuilderFieldOption(
                          value: 'Lung Disease', child: Text('Lung Disease')),
                      FormBuilderFieldOption(
                          value: 'HIV Patient', child: Text('HIV Patient')),
                      FormBuilderFieldOption(
                          value: 'None', child: Text('None')),
                    ],
                    //onChanged: (value) => print(value),
                    onSaved: (value) => riskGroup = value,
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    color: Colors.red,
                    child: Text(
                      "Go Back",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      Fluttertoast.showToast(
                          msg: "Please Wait",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIos: 1,
                          backgroundColor: Colors.blueAccent,
                          textColor: Colors.white,
                          fontSize: 20.0);
                      _fbKey.currentState.reset();
                      await auth.signOut();
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: MaterialButton(
                    color: Theme.of(context).accentColor,
                    child: Text(
                      "Reset",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Fluttertoast.showToast(
                          msg: "Please Wait",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIos: 1,
                          backgroundColor: Colors.blueAccent,
                          textColor: Colors.white,
                          fontSize: 20.0);
                      _fbKey.currentState.reset();
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: MaterialButton(
                    color: Colors.green,
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      Fluttertoast.showToast(
                          msg: "Please Wait",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIos: 1,
                          backgroundColor: Colors.blueAccent,
                          textColor: Colors.white,
                          fontSize: 16.0);
                      if (_fbKey.currentState.saveAndValidate()) {
                        Fluttertoast.showToast(
                            msg: "Processing",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.blueAccent,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        print(_fbKey.currentState.value);
                        await auth.updateDB();
                        await auth.signOut();
                        Fluttertoast.showToast(
                            msg: "Submitted Successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.blueAccent,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        print(_fbKey.currentState.value);
                        Fluttertoast.showToast(
                            msg: "Please Check Your Form Again",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos: 1,
                            backgroundColor: Colors.blueAccent,
                            textColor: Colors.white,
                            fontSize: 16.0);
                        print("validation failed");
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
