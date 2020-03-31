import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:selfreportingapp/model/patient_data.dart';
import 'package:selfreportingapp/services/firebase_auth.dart';

import 'formSubmissionPage.dart';

class SelfReportingPage extends StatefulWidget {
  @override
  _SelfReportingPageState createState() => _SelfReportingPageState();
}

class _SelfReportingPageState extends State<SelfReportingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InitialCheck(),
    );
  }
}

class InitialCheck extends StatefulWidget {
  @override
  _InitialCheckState createState() => _InitialCheckState();
}

class _InitialCheckState extends State<InitialCheck> {
  final formKey = GlobalKey<FormState>();
  final AuthService auth = AuthService();
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
                      Center(
                        child: AutoSizeText(
                          "যদি পরিবারের কোন সদস্যের ব্যাক্তিগত মোবাইল নম্বর না থাকে তবে আপনি নিজের বা পরিবারের অন্য কারো ফোন নম্বর ব্যবহার করে তথ্য প্রদান করতে পারবেন। এই ক্ষেত্রে অপশন থেকে 'পরিবারের সদস্যর জন্য' এই অপশন টি সিলেক্ট করার জন্য অনুরোধ করা যাচ্ছে। ধন্যবাদ",
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
                              "আপনি কি নিজের জন্য তথ্য দিচ্ছেন নাকি পরিবারের কারো জন্য?",
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
                              onSaved: (value) => notSelf = value,
                              items: ['নিজের জন্য', 'পরিবারের সদস্যর জন্য']
                                  .map((choice) => DropdownMenuItem(
                                      value: choice, child: Text("$choice")))
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LogInToSubmit()));
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
