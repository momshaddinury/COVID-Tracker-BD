import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:selfreportingapp/model/patient_data.dart';

import 'doctors_report.dart';
import 'neighbours_report.dart';

class PossibleAffected extends StatefulWidget {
  @override
  _PossibleAffectedState createState() => _PossibleAffectedState();
}

class _PossibleAffectedState extends State<PossibleAffected> {
  final formKey = GlobalKey<FormState>();
  var data;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Form(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 200,
                        child: Image.asset("assets/people.jpg"),
                      ),
                      Center(
                        child: AutoSizeText(
                          "আপনি চাইলে সন্দেহভাজন ব্যাক্তি সম্পর্কে তথ্য দিয়ে সরকার কে সাহায্য করতে পারেন। তবে সাবধান ভুল তথ্য প্রদানে শাস্তির ব্যবস্থা আছে।",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FormBuilder(
                        // context,
                        key: _fbKey,
                        readOnly: false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            //Name
                            AutoSizeText(
                              "আপনি কি ডাক্তার নাকি সচেতন প্রতিবেশী?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            FormBuilderDropdown(
                              attribute: "dropdown",
                              //decoration: InputDecoration(labelText: "Gender"),
                              // initialValue: 'Male',
                              hint: Text('উত্তর নির্বাচন করুন'),
                              validators: [FormBuilderValidators.required()],
                              onSaved: (value) => reporterType = value,
                              items: ['ডাক্তার', 'সচেতন প্রতিবেশী']
                                  .map((reporter) => DropdownMenuItem(
                                      value: reporter,
                                      child: Text("$reporter")))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: MaterialButton(
                              color: Colors.red,
                              child: Text(
                                "ফিরে যান",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                Navigator.pop(context);
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
                                "পরবর্তী ধাপ",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                //toast("অপেক্ষা করুন");
                                if (_fbKey.currentState.saveAndValidate()) {
                                  if (reporterType == "ডাক্তার") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DoctorsReport()));
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NeighboursReport()));
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
