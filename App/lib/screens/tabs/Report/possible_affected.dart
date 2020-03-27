import 'package:auto_size_text/auto_size_text.dart';
import 'package:covidtrackerbd/model/patientDataModel.dart';
import 'package:covidtrackerbd/screens/tabs/Report/doctors_report.dart';
import 'package:covidtrackerbd/screens/tabs/Report/neighbours_report.dart';
import 'package:covidtrackerbd/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'formSubmissionPage.dart';

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
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Container(
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
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      /*Center(
                      child: AutoSizeText(
                        "আমার হাতেই আমার সুরক্ষা",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),*/
                      Center(
                        child: AutoSizeText(
                          "যদি পরিবারের কোন সদস্যের ব্যাক্তিগত মোবাইল নম্বর না থাকে তবে আপনি নিজের বা পরিবারের অন্য কারো ফোন নম্বর ব্যবহার করে তথ্য প্রদান করতে পারবেন। এই ক্ষেত্রে অপশন থেকে 'পরিবারের সদস্যর জন্য' এই অপশন টি সিলেক্ট করার অনুরোধ করা যাচ্ছে। ধন্যবাদ",
                          textAlign: TextAlign.justify,
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
