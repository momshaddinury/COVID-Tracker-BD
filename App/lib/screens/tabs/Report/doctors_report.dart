import 'package:auto_size_text/auto_size_text.dart';
import 'package:covidtrackerbd/model/bdModel.dart';
import 'package:covidtrackerbd/model/patientDataModel.dart';
import 'package:covidtrackerbd/services/api.dart';
import 'package:covidtrackerbd/services/json.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_html/flutter_html.dart';

import 'formSubmissionPage.dart';

class DoctorsReport extends StatefulWidget {
  @override
  _DoctorsReportState createState() => _DoctorsReportState();
}

class _DoctorsReportState extends State<DoctorsReport> {
  final formKey = GlobalKey<FormState>();
  var data;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  BDModel bdModel = new BDModel();
  String selectedDivision, selectedDistrict;
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FormBuilder(
                    key: _fbKey,
                    readOnly: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //সন্দেহভাজন রোগীর তথ্য
                        Center(
                          child: AutoSizeText(
                            " সন্দেহভাজন রোগীর তথ্য",
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
                        Divider(
                          thickness: 10,
                          height: 50.0,
                          color: Colors.black45,
                        ),
                        FormBuilderTextField(
                          attribute: "number",
                          decoration: InputDecoration(
                            labelText: "ফবি.এম.ডি.সি নম্বর",
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          keyboardType: TextInputType.number,
                          validators: [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.numeric(),
                            /*FormBuilderValidators.minLength(11,
                          errorText: "১১ ডিজিট"),
                          FormBuilderValidators.maxLength(11,
                          errorText: "১১ ডিজিট")*/
                          ],
                          onSaved: (value) => bmdc = value,
                        ),

                        //রোগীর নাম
                        FormBuilderTextField(
                          attribute: "name",
                          decoration: InputDecoration(
                            labelText: "রোগীর নাম",
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          onSaved: (value) => fullName = value,
                        ),

                        // বয়স
                        FormBuilderTextField(
                          attribute: "age",
                          decoration: InputDecoration(
                            labelText: "রোগীর বয়স?",
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          validators: [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.numeric(),
                          ],
                          onSaved: (value) => age = value,
                          keyboardType: TextInputType.number,
                        ),

                        // লিঙ্গ:
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 10, top: 10),
                          child: AutoSizeText(
                            "লিঙ্গ",
                            textAlign: TextAlign.left,
                          ),
                        ),
                        FormBuilderChoiceChip(
                          attribute: 'choice_chip',
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          options: [
                            FormBuilderFieldOption(
                              value: 'পুরুষ',
                              child: Text('পুরুষ'),
                            ),
                            FormBuilderFieldOption(
                              value: 'মহিলা',
                              child: Text('মহিলা'),
                            ),
                          ],
                          onSaved: (value) => gender = value,
                        ),
                        Divider(
                          thickness: 10,
                          height: 50.0,
                          color: Colors.black45,
                        ),
                        // বিভাগ
                        FormBuilderDropdown(
                          attribute: "dropdown",
                          //decoration: InputDecoration(labelText: "Gender"),
                          // initialValue: 'Male',
                          hint: Text('   বিভাগ নির্বাচন করুন'),
                          validators: [FormBuilderValidators.required()],
                          onSaved: (value) => division = value,
                          items: bdModel.getDivisionListBn()
                              .map((value) => DropdownMenuItem(
                                  value: value, child: Text("$value")))
                              .toList(),
                          onChanged: (value){
                            setState(() {
                              selectedDivision = value.toString().trim();
                            });
                          },
                        ),
                        // জেলা
                        FormBuilderDropdown(
                          attribute: "dropdown",
                          //decoration: InputDecoration(labelText: "Gender"),
                          // initialValue: 'Male',
                          hint: Text('   জেলা নির্বাচন করুন'),
                          validators: [FormBuilderValidators.required()],
                          onSaved: (value) => district = value,
                          items: bdModel.getDistrictListBn(selectedDivision)
                              .map((value) => DropdownMenuItem(
                                  value: value, child: Text("$value")))
                              .toList(),
                          onChanged: (value){
                            setState(() {
                              selectedDistrict = value.toString().trim();
                            });
                          },
                        ),


                        // উপজেলা
                        FormBuilderDropdown(
                          attribute: "dropdown",
                          //decoration: InputDecoration(labelText: "Gender"),
                          // initialValue: 'Male',
                          hint: Text('   উপজেলা নির্বাচন করুন'),
                          validators: [FormBuilderValidators.required()],
                          onSaved: (value) => upazila = value,
                          items: bdModel.getSubDistrictListBn(selectedDistrict)
                              .map((value) => DropdownMenuItem(
                                  value: value, child: Text("$value")))
                              .toList(),
                        ),

                        //রোগীর ঠিকানা
                        FormBuilderTextField(
                          attribute: "name",
                          decoration: InputDecoration(
                            labelText: "রোগীর ঠিকানা",
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          onSaved: (value) => address = value,
                        ),

                        //রোগীর মোবাইল
                        FormBuilderTextField(
                          attribute: "phonenumber",
                          decoration: InputDecoration(
                            labelText: "রোগীর মোবাইল নম্বর [১১ ডিজিট]",
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          keyboardType: TextInputType.number,
                          validators: [
                            FormBuilderValidators.required(),
                            FormBuilderValidators.numeric(),
                            FormBuilderValidators.minLength(11,
                                errorText: "১১ ডিজিট"),
                            FormBuilderValidators.maxLength(11,
                                errorText: "১১ ডিজিট")
                          ],
                          onSaved: (value) => phoneNumber = value,
                        ),
                        Divider(
                          thickness: 10,
                          height: 50.0,
                          color: Colors.black45,
                        ),
                        // বিগত ১৪ দিনে বিদেশ ফেরত?:
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: AutoSizeText("বিগত ১৪ দিনে বিদেশ ফেরত?"),
                        ),
                        FormBuilderChoiceChip(
                          attribute: 'choice_chip',
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          options: [
                            FormBuilderFieldOption(
                              value: 'হ্যাঁ',
                              child: Text('হ্যাঁ'),
                            ),
                            FormBuilderFieldOption(
                                value: 'না', child: Text('না')),
                          ],
                          validators: [
                            FormBuilderValidators.required(),
                          ],
                          onSaved: (value) => cameBackFromAbroad = value,
                        ),

                        //বিগত ১৪ দিনে প্রবাসী/কোয়ারেন্টাইনকৃত/কোভিড১৯ আঙ্ক্রান্ত রোগীর সংপর্শে এসেছে কিনা?
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 10),
                          child: AutoSizeText(
                              "বিগত ১৪ দিনে প্রবাসী/কোয়ারেন্টাইনকৃত/কোভিড১৯ আঙ্ক্রান্ত রোগীর সংপর্শে এসেছে কিনা?"),
                        ),
                        FormBuilderChoiceChip(
                          attribute: 'choice_chip',
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          options: [
                            FormBuilderFieldOption(
                              value: 'হ্যাঁ',
                              child: Text('হ্যাঁ'),
                            ),
                            FormBuilderFieldOption(
                                value: 'না', child: Text('না')),
                          ],
                          validators: [
                            FormBuilderValidators.required(),
                          ],
                          onSaved: (value) =>
                              contactWithAnyCOVIDPatient = value,
                        ),
                        Divider(
                          thickness: 10,
                          height: 50.0,
                          color: Colors.black45,
                        ),
                        //জ্বর আছে কিনা?
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 10),
                          child: AutoSizeText("জ্বর আছে কিনা?"),
                        ),
                        FormBuilderChoiceChip(
                          attribute: 'choice_chip',
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          options: [
                            FormBuilderFieldOption(
                              value: 'হ্যাঁ',
                              child: Text('হ্যাঁ'),
                            ),
                            FormBuilderFieldOption(
                                value: 'না', child: Text('না')),
                          ],
                          validators: [
                            FormBuilderValidators.required(),
                          ],
                          onSaved: (value) => fever = value,
                        ),

                        //সর্দি আছে কিনা?
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 10),
                          child: AutoSizeText("সর্দি আছে কিনা?"),
                        ),
                        FormBuilderChoiceChip(
                          attribute: 'choice_chip',
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          options: [
                            FormBuilderFieldOption(
                              value: 'হ্যাঁ',
                              child: Text('হ্যাঁ'),
                            ),
                            FormBuilderFieldOption(
                                value: 'না', child: Text('না')),
                          ],
                          validators: [
                            FormBuilderValidators.required(),
                          ],
                          onSaved: (value) => fever = value,
                        ),

                        //সর্দি আছে কিনা?
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 10),
                          child: AutoSizeText("কাশি আছে কিনা?"),
                        ),
                        FormBuilderChoiceChip(
                          attribute: 'choice_chip',
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          options: [
                            FormBuilderFieldOption(
                              value: 'হ্যাঁ',
                              child: Text('হ্যাঁ'),
                            ),
                            FormBuilderFieldOption(
                                value: 'না', child: Text('না')),
                          ],
                          validators: [
                            FormBuilderValidators.required(),
                          ],
                          onSaved: (value) => fever = value,
                        ),

                        //গলা ব্যথা আছে কিনা?
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 10),
                          child: AutoSizeText("গলা ব্যথা আছে কিনা?"),
                        ),
                        FormBuilderChoiceChip(
                          attribute: 'choice_chip',
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          options: [
                            FormBuilderFieldOption(
                              value: 'হ্যাঁ',
                              child: Text('হ্যাঁ'),
                            ),
                            FormBuilderFieldOption(
                                value: 'না', child: Text('না')),
                          ],
                          validators: [
                            FormBuilderValidators.required(),
                          ],
                          onSaved: (value) => fever = value,
                        ),

                        //শ্বাসকষ্ট আছে কিনা?
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 10),
                          child: AutoSizeText("শ্বাসকষ্ট আছে কিনা?"),
                        ),
                        FormBuilderChoiceChip(
                          attribute: 'choice_chip',
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          options: [
                            FormBuilderFieldOption(
                              value: 'হ্যাঁ',
                              child: Text('হ্যাঁ'),
                            ),
                            FormBuilderFieldOption(
                                value: 'না', child: Text('না')),
                          ],
                          validators: [
                            FormBuilderValidators.required(),
                          ],
                          onSaved: (value) => fever = value,
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
                            "বন্ধ করুন",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            //toast("অপেক্ষা করুন");
                            _fbKey.currentState.reset();
                            // await auth.signOut();
                            Navigator.pop(context);
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
                            "রিসেট",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            //toast("অপেক্ষা করুন");
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
                            "জমা দিন",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            toast("অপেক্ষা করুন");
                            if (_fbKey.currentState.saveAndValidate()) {
                              toast("প্রসেসিং");
                              print(_fbKey.currentState.value);
                              await submitResponse();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text("টেস্ট রেজাল্ট"),
                                  content: new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          child: RichText(
                                        text: TextSpan(
                                          text: 'ফলাফল: $assessmentMessage\n',
                                          style: TextStyle(
                                            color: Colors.red,
                                            decoration: TextDecoration.none,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: "\nআইডি: $userID\n",
                                              style: TextStyle(
                                                color: Colors.red,
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                      Html(
                                        data: """$notes""",
                                        onLinkTap: (url) {
                                          print("Openning url");
                                        },
                                      ),
                                    ],
                                  ),
                                  actions: <Widget>[
                                    new FlatButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      textColor: Theme.of(context).primaryColor,
                                      child: const Text('ওকে'),
                                    ),
                                  ],
                                ),
                              );
                              //await auth.signOut();
                              toast("সফল ভাবে জমা হয়েছে");
                            } else {
                              print(_fbKey.currentState.value);
                              toast("পুনরায় চেক করুন");
                              print("ভেলিডেশন ফেইল্ড");
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
        ),
      ),
    );
  }
}
