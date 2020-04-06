import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:selfreportingapp/model/patient_data.dart';
import 'package:selfreportingapp/model/question_list.dart';
import 'package:selfreportingapp/widgets/report%20page%20widgets/action_button.dart';
import 'package:selfreportingapp/widgets/report%20page%20widgets/personal_information.dart';
import 'package:selfreportingapp/widgets/report%20page%20widgets/triage_question.dart';

class RelativeReportSubmission extends StatefulWidget {
  @override
  _RelativeReportSubmissionState createState() =>
      _RelativeReportSubmissionState();
}

class _RelativeReportSubmissionState extends State<RelativeReportSubmission> {
  final formKey = GlobalKey<FormState>();
  var data;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  var relationTypeNames = [
    "পিতা",
    "মাতা",
    "বোন",
    "ছেলে",
    "মেয়ে",
    "ভাই",
    "স্বামী",
    "স্ত্রী",
    "দাদা",
    "নাতি",
    "দাদী",
    "নাতনি",
    "চাচা ",
    "চাচী ",
    "ভাইপো",
    "ভাইঝি",
    "কাজিন",
  ];

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
                      "সঠিক তথ্য দিয়ে ফর্মটি পূর্ণ করুন। আপনার মোবাইল নম্বর ঠিক ভাবে দিন। নির্দেশনা মেনে চলুন",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
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
                        FormBuilderDropdown(
                          attribute: "text",
                          decoration: InputDecoration(
                            labelText: "    আপনার সাথে সম্পর্ক?",
                          ),
                          // initialValue: 'Male',
                          hint: Text('   সম্পর্ক নির্বাচন করুন'),
                          validators: [FormBuilderValidators.required()],
                          onSaved: (value) => relationType = value,
                          items: relationTypeNames
                              .map((value) => DropdownMenuItem(
                                    value: value,
                                    child: Text('$value'),
                                  ))
                              .toList(),
                        ),

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
