import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:selfreportingapp/model/country_data.dart';
import 'package:selfreportingapp/model/district.dart';
import 'package:selfreportingapp/model/division.dart';
import 'package:selfreportingapp/model/patient_data.dart';
import 'package:selfreportingapp/model/upazila.dart';
import 'package:selfreportingapp/services/api.dart';
import 'package:selfreportingapp/widgets/report_page_widgets/action_button.dart';
import 'package:selfreportingapp/widgets/report_page_widgets/personal_information.dart';
import 'package:selfreportingapp/widgets/report_page_widgets/triage_question.dart';

class MainCaseReport extends StatefulWidget {
  @override
  _MainCaseReportState createState() => _MainCaseReportState();
}

class _MainCaseReportState extends State<MainCaseReport> {
  final formKey = GlobalKey<FormState>();
  var data;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  BDModel bdModel = new BDModel();
  String selectedDivision, selectedDistrict;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  List<String> districtList = [], subDistrictList = [], divisionList = [];
  //final ValueNotifier<int> isReset = ValueNotifier<int>(0);
  Future<List<Division>> futureDivision;
  List<Division> divisionDetails;
  Future<List<District>> futureDistrict;
  List<District> districtDetails;
  Future<List<Upazila>> futureUpazila;
  List<Upazila> upazilaDetails;

  rebuildParent() {
    //isReset.value += 1;
    initState();
    //print(isReset);
  }

  List<List> question = [
    ["আপনার কি জ্বর/ কাশি / গলাব্যথা আছে ?", "coughOrThroatPain"],
    ["আপনার কি শ্বাসকষ্ট আছে ?", "problemBreathing"],
    [
      "আপনার প্রতিবেশী বা এলাকার কোন ব্যক্তি কি করোনা ভাইরাসে আক্রান্ত ?",
      "contactWithAnyCOVIDPatient"
    ],
    [
      "আপনার পরিবারের কোন সদস্য কি জ্বর, কাশি, বা শ্বাসকষ্টে আক্রান্ত?",
      "cameInContactWithPersonHavingCoughOrThroatPain"
    ],
    [
      "আপনি কি ডায়াবেটিস, উচ্চ রক্তচাপ, হার্ট ,কিডনী লিভার বা ফুসফুসের কোন রোগ ( এজমা, সিওপিডি), এইচআইভি (এইডস), ক্যান্সার ইত্যাদি রোগে ভুগছেন?",
      "riskGroup"
    ],
    [
      " আপনি কি একজন স্বাস্থ্যকর্মী? (ডাক্তার, নার্স, সহায়ককর্মী ইত্যাদি)",
      "healthCareWorker"
    ],
  ];

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
    "সেলফ"
  ];

  @override
  void initState() {
    super.initState();

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
        elevation: 2.0,
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
                        FormBuilderDropdown(
                          attribute: "text",
                          // initialValue: 'Male',
                          hint: AutoSizeText('   সম্পর্ক নির্বাচন করুন'),
                          validators: [FormBuilderValidators.required()],
                          onSaved: (value) {
                            if (value == "পিতা") {
                              personalQAPlaceholder.relationType = "01";
                            } else if (value == "মাতা") {
                              personalQAPlaceholder.relationType = "02";
                            } else if (value == "বোন") {
                              personalQAPlaceholder.relationType = "03";
                            } else if (value == "ছেলে") {
                              personalQAPlaceholder.relationType = "04";
                            } else if (value == "মেয়ে") {
                              personalQAPlaceholder.relationType = "05";
                            } else if (value == "ভাই") {
                              personalQAPlaceholder.relationType = "06";
                            } else if (value == "স্বামী") {
                              personalQAPlaceholder.relationType = "07";
                            } else if (value == "স্ত্রী") {
                              personalQAPlaceholder.relationType = "08";
                            } else if (value == "দাদা") {
                              personalQAPlaceholder.relationType = "09";
                            } else if (value == "নাতি") {
                              personalQAPlaceholder.relationType = "10";
                            } else if (value == "দাদী") {
                              personalQAPlaceholder.relationType = "11";
                            } else if (value == "নাতনি") {
                              personalQAPlaceholder.relationType = "12";
                            } else if (value == "চাচা") {
                              personalQAPlaceholder.relationType = "13";
                            } else if (value == "চাচী") {
                              personalQAPlaceholder.relationType = "14";
                            } else if (value == "ভাইপো") {
                              personalQAPlaceholder.relationType = "15";
                            } else if (value == "ভাইঝি") {
                              personalQAPlaceholder.relationType = "16";
                            } else if (value == "কাজিন") {
                              personalQAPlaceholder.relationType = "17";
                            } else if (value == "সেলফ") {
                              personalQAPlaceholder.relationType = "00";
                            }
                          },
                          items: relationTypeNames
                              .map((value) => DropdownMenuItem(
                                    value: value,
                                    child: Text('   $value'),
                                  ))
                              .toList(),
                        ),
                        PersonalInformation(),
                        // বিভাগ
                        FormBuilderDropdown(
                          attribute: "divisionDropdown",
                          //decoration: InputDecoration(labelText: "Gender"),
                          // initialValue: 'Male',
                          hint: Text('   বিভাগ নির্বাচন করুন'),
                          validators: [FormBuilderValidators.required()],
                          onSaved: (value) => personalQAPlaceholder.division =
                              getDivisionCode(value.toString().trim()),
                          items: getDivisionList()
                              .map((value) => DropdownMenuItem(
                                  value: value, child: Text("   $value")))
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
                          onSaved: (value) =>
                              personalQAPlaceholder.district = value,
                          items: districtList
                              .map((value) => DropdownMenuItem(
                                  value: value, child: Text("   $value")))
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
                          /*validators: [FormBuilderValidators.required()],*/
                          allowClear: true,
                          onSaved: (value) => personalQAPlaceholder.upazila =
                              getUpazilaCode(value.toString().trim()),
                          items: subDistrictList
                              .map((value) => DropdownMenuItem(
                                  value: value, child: Text("   $value")))
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
                        SizedBox(
                          height: 10,
                        ),

                        /// Triage Q/A Form
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: question.length,
                          itemBuilder: (BuildContext context, int i) {
                            return TriageQuestion(
                              question: question[i][0],
                              placeHolder: question[i][1],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ActionButton(fbKey: _fbKey, rebuildParent: rebuildParent),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
