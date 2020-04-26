/*
import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:selfreportingapp/model/country_data.dart';
import 'package:selfreportingapp/model/district.dart';
import 'package:selfreportingapp/model/division.dart';
import 'package:selfreportingapp/model/patient_data.dart';
import 'package:selfreportingapp/model/upazila.dart';
import 'package:selfreportingapp/services/api.dart';
import 'package:selfreportingapp/services/json_handle.dart';
import 'package:selfreportingapp/widgets/toast.dart';

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
  List<String> districtList = [], subDistrictList = [], divisionList = [];
  Future<List<Division>> futureDivision;
  List<Division> divisionDetails;
  Future<List<District>> futureDistrict;
  List<District> districtDetails;
  Future<List<Upazila>> futureUpazila;
  List<Upazila> upazilaDetails;

  @override
  void initState() {
    super.initState();
//    divisionList = bdModel.getDivisionListBn();

    futureDivision = getAllDivision();
    futureDistrict = getAllDistricts();
    futureUpazila = getAllUpazila();
    futureDivision.then((division) {
      if (this.mounted) {
        setState(() {
          divisionDetails = division;
        });
      }
    });
    futureDistrict.then((district) {
      if (this.mounted) {
        setState(() {
          districtDetails = district;
        });
      }
    });
    futureUpazila.then((upazila) {
      if (this.mounted) {
        setState(() {
          upazilaDetails = upazila;
        });
      }
    });

    divisionList = getDivisionList();
  }

  List<String> getDivisionList() {
    List<String> list = [];
    if (divisionDetails != null) {
      for (int i = 0; i < divisionDetails.length; i++) {
        if (divisionDetails[i].nameBn != null) {
          list.add(divisionDetails[i].nameBn);
        }
      }
    }
    return list;
  }

  List<String> getDistrictList(String division) {
    List<String> list = [];
    if (districtDetails != null) {
      for (int i = 0; i < districtDetails.length; i++) {
        ;
        if (districtDetails[i].division != null &&
            districtDetails[i].division.nameBn == division) {
          list.add(districtDetails[i].nameBn);
        }
      }
    }
    return list;
  }

  List<String> getUpazilaList(String district) {
    List<String> list = [];
    if (upazilaDetails != null) {
      for (int i = 0; i < upazilaDetails.length; i++) {
        if (upazilaDetails[i].district != null &&
            upazilaDetails[i].district.nameBn == district) {
          list.add(upazilaDetails[i].nameBn);
        }
      }
    }
    return list;
  }

  String getDivisionCode(String division) {
    String code;
    if (divisionDetails != null) {
      for (int i = 0; i < divisionDetails.length; i++) {
        if (divisionDetails[i].nameBn == division) {
          code = divisionDetails[i].code.toString();
        }
      }
    }
    if (code == null) {
      return division;
    } else {
      return code;
    }
  }

  String getUpazilaCode(String upazila) {
    String code;
    if (upazilaDetails != null) {
      for (int i = 0; i < upazilaDetails.length; i++) {
        if (upazilaDetails[i].nameBn == upazila) {
          code = upazilaDetails[i].code.toString();
        }
      }
    }
    if (code == null) {
      return upazila;
    } else {
      return code;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
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
                            */
/*FormBuilderValidators.minLength(11,
                          errorText: "১১ ডিজিট"),
                          FormBuilderValidators.maxLength(11,
                          errorText: "১১ ডিজিট")*/ /*

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
                          padding: const EdgeInsets.only(left: 10, top: 10),
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
                            FormBuilderFieldOption(
                              value: 'অন্যান্য',
                              child: Text('অন্যান্য'),
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
                          attribute: "divisionDropdown",
                          //decoration: InputDecoration(labelText: "Gender"),
                          // initialValue: 'Male',
                          hint: Text('   বিভাগ নির্বাচন করুন'),
                          validators: [FormBuilderValidators.required()],
                          onSaved: (value) => division =
                              getDivisionCode(value.toString().trim()),
                          items: getDivisionList()
                              .map((value) => DropdownMenuItem(
                                  value: value, child: Text("$value")))
                              .toList(),
                          onChanged: (value) {
                            _fbKey.currentState.fields["districtDropdown"]
                                .currentState
                                .reset();
                            _fbKey.currentState.fields["subDistrictDropdown"]
                                .currentState
                                .reset();
                            if (value == null) {
                              if (this.mounted) {
                                setState(() {
                                  divisionList = getDivisionList();
                                  districtList = [];
                                  subDistrictList = [];
                                });
                              }
                            } else {
                              if (this.mounted) {
                                setState(() {
                                  divisionList = [];
                                  selectedDivision = value.toString().trim();
                                  districtList =
                                      getDistrictList(selectedDivision);
                                });
                              }
                            }
                          },
                          allowClear: true,
                        ),
                        // জেলা
                        FormBuilderDropdown(
                          attribute: "districtDropdown",
                          //decoration: InputDecoration(labelText: "Gender"),
                          // initialValue: 'Male',
                          hint: Text('   জেলা নির্বাচন করুন'),
                          allowClear: true,
                          validators: [FormBuilderValidators.required()],
                          onSaved: (value) => district = value,
                          items: districtList
                              .map((value) => DropdownMenuItem(
                                  value: value, child: Text("$value")))
                              .toList(),
                          onChanged: (value) {
                            _fbKey.currentState.fields["subDistrictDropdown"]
                                .currentState
                                .reset();
                            if (value == null) {
                              if (selectedDivision != "" &&
                                  selectedDivision != null) {
                                if (this.mounted) {
                                  setState(() {
                                    districtList =
                                        getDistrictList(selectedDivision);
                                    subDistrictList = [];
                                  });
                                }
                              }
                            } else {
                              if (this.mounted) {
                                setState(() {
                                  districtList = [];
                                  selectedDistrict = value.toString().trim();
                                  subDistrictList =
                                      getUpazilaList(selectedDistrict);
                                });
                              }
                            }
                          },
                        ),

                        // উপজেলা
                        FormBuilderDropdown(
                          attribute: "subDistrictDropdown",
                          //decoration: InputDecoration(labelText: "Gender"),
                          // initialValue: 'Male',
                          hint: Text('   উপজেলা নির্বাচন করুন'),
                          validators: [FormBuilderValidators.required()],
                          allowClear: true,
                          onSaved: (value) =>
                              upazila = getUpazilaCode(value.toString().trim()),
                          items: subDistrictList
                              .map((value) => DropdownMenuItem(
                                  value: value, child: Text("$value")))
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              if (selectedDistrict != "" &&
                                  selectedDistrict != null) {
                                if (this.mounted) {
                                  setState(() {
                                    subDistrictList =
                                        getUpazilaList(selectedDistrict);
                                  });
                                }
                              }
                            } else {
                              if (this.mounted) {
                                setState(() {
                                  subDistrictList = [];
                                });
                              }
                            }
                          },
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
                        */
/*Padding(
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
                          onSaved: (value) => triageQAPlaceHolder.cameBackFromAbroad = value,
                        ),*/ /*


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
                          onSaved: (value) => triageQAPlaceHolder
                              .contactWithAnyCOVIDPatient = value,
                        ),
                        Divider(
                          thickness: 10,
                          height: 50.0,
                          color: Colors.black45,
                        ),
                        //জ্বর আছে কিনা?
                        */
/*Padding(
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
                          onSaved: (value) => triageQAPlaceHolder.fever = value,
                        ),*/ /*


                        //সর্দি আছে কিনা?
                        */
/*Padding(
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
                        ),*/ /*


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
                          //onSaved: (value) => fever = value,
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
                          //onSaved: (value) => fever = value,
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
                          //onSaved: (value) => fever = value,
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
                              await postMainCaseReport();
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
*/
