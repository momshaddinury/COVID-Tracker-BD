import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:selfreportingapp/model/patient_data.dart';
import 'package:selfreportingapp/model/question_list.dart';
import 'package:selfreportingapp/widgets/report_page_widgets/action_button.dart';
import 'package:selfreportingapp/widgets/report_page_widgets/personal_information.dart';
import 'package:selfreportingapp/widgets/report_page_widgets/triage_question.dart';

class VolunteerUpdate extends StatefulWidget {
  @override
  _VolunteerUpdateState createState() => _VolunteerUpdateState();
}

class _VolunteerUpdateState extends State<VolunteerUpdate> {
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
                          "আপনার ভলেন্টিয়ার এক্সেস টোকেন টি দিন। ধন্যবাদ",
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
                              "আপনার এক্সেস টোকেন টি দিন",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            //Name
                            FormBuilderTextField(
                              attribute: "token",
                              decoration: InputDecoration(
                                labelText: "এক্সেস টোকেন?",
                                filled: true,
                                fillColor: Colors.grey[200],
                              ),
                              validators: [
                                FormBuilderValidators.required(),
                              ],
                              onSaved: (value) => volunteerAccessToken = value,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      /// BUTTON ROW
                      Row(
                        children: <Widget>[
                          /// BACK BUTTON
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

                          /// NEXT BUTTON
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
                                              VolunteerReportSubmissionPage()));
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

class VolunteerReportSubmissionPage extends StatefulWidget {
  @override
  _VolunteerReportSubmissionPageState createState() =>
      _VolunteerReportSubmissionPageState();
}

class _VolunteerReportSubmissionPageState
    extends State<VolunteerReportSubmissionPage> {
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
//          color: Colors.white,
        child: SingleChildScrollView(
          child: Form(
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
                  ),
                  Center(
                    child: AutoSizeText(
                      "সঠিক তথ্য দিয়ে ফর্মটি পূর্ণ করুন। আপনার মোবাইল নম্বর ঠিক ভাবে দিন। নির্দেশনা মেনে চলুন",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
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
                    readOnly: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        /// Personal Information
                        PersonalInformation(),

                        /// Fever:
                        TriageQuestion(
                            question: question[0], placeHolder: fever),

                        /// কাশি বা গলাব্যথা বা দুইটাই:
                        TriageQuestion(
                            question: question[1],
                            placeHolder: coughOrThroatPain),

                        /// শ্বাসকষ্ট:
                        TriageQuestion(
                            question: question[2],
                            placeHolder: problemBreathing),

                        /// Migrant:
                        TriageQuestion(
                            question: question[3],
                            placeHolder: cameBackFromAbroad),

                        /// Came in Contact with NRB:
                        TriageQuestion(
                            question: question[4],
                            placeHolder: contactWithAnyCOVIDPatient),

                        /// আপনি কি বিগত ১৪ দিনের ভিতরে শ্বাসকষ্ট বা কাশিতে
                        /// আক্রান্ত এরকম কোন ব্যক্তির সংস্পর্শে এসেছিলেন?
                        TriageQuestion(
                            question: question[5],
                            placeHolder:
                                cameInContactWithPersonHavingCoughOrThroatPain),

                        /// আপনার কি অন্য কোন অসুখে  ভুগছেন (যেমন : ডায়াবেটিস,
                        /// এজমা বা হাঁপানি , দীর্ঘমেয়াদি শ্বাসকষ্টের রোগ বা সিওপিডি,
                        /// কিডনি রোগ, ক্যান্সার বা ক্যান্সারের জন্য কোন চিকিৎসা নিচ্ছেন?
                        TriageQuestion(
                            question: question[6], placeHolder: riskGroup),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ActionButton(fbKey: _fbKey),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
