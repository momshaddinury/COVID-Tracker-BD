import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:selfreportingapp/model/country_data.dart';
import 'package:selfreportingapp/model/patient_data.dart';
import 'package:selfreportingapp/services/api.dart';
import 'package:selfreportingapp/services/json_handle.dart';
import 'package:selfreportingapp/widgets/toast.dart';

class NeighboursReport extends StatefulWidget {
  @override
  _NeighboursReportState createState() => _NeighboursReportState();
}

class _NeighboursReportState extends State<NeighboursReport> {
  final formKey = GlobalKey<FormState>();
  var data;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  BDModel bdModel = new BDModel();
  String selectedDivision, selectedDistrict;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  List<String> districtList = [], subDistrictList = [], divisionList = [];

  @override
  void initState() {
    divisionList = bdModel.getDivisionListBn();
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
                            " বিদেশ ফেরত ব্যক্তির তথ্য",
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

                        //রোগীর নাম
                        FormBuilderTextField(
                          attribute: "name",
                          decoration: InputDecoration(
                            labelText: "ব্যক্তির নাম",
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          validators: [
                            FormBuilderValidators.required(),
                          ],
                          onSaved: (value) => fullName = value,
                        ),

                        //রোগীর পিতার নাম
                        FormBuilderTextField(
                          attribute: "fathername",
                          decoration: InputDecoration(
                            labelText: "পিতার নাম",
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          onSaved: (value) => patientFatherName = value,
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
                          validators: [
                            FormBuilderValidators.required(),
                          ],
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

                        // আনুমানিক বয়স
                        FormBuilderTextField(
                          attribute: "age",
                          decoration: InputDecoration(
                            labelText: "আনুমানিক বয়স?",
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

                        //দেশে ফেরার তারিখ
                        FormBuilderDateRangePicker(
                          attribute: "date_range",
                          firstDate: DateTime(1970),
                          lastDate: DateTime(2030),
                          format: DateFormat("yyyy-MM-dd"),
                          onSaved: (value) => dateofReturnNRB = value,
                          validators: [
                            FormBuilderValidators.required(),
                          ],
                          decoration: InputDecoration(
                            labelText: "   দেশে ফেরার তারিখ",
                          ),
                        ),

                        // যে দেশ থেকে ফিরেছেন
                        FormBuilderTextField(
                          attribute: "name",
                          decoration: InputDecoration(
                            labelText: "যে দেশ থেকে ফিরেছেন",
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          validators: [
                            FormBuilderValidators.required(),
                          ],
                          onSaved: (value) => countryNRB = value,
                        ),

                        // বিভাগ
                        FormBuilderDropdown(
                          attribute: "divisionDropdown",
                          //decoration: InputDecoration(labelText: "Gender"),
                          // initialValue: 'Male',
                          hint: Text('   বিভাগ নির্বাচন করুন'),
                          validators: [FormBuilderValidators.required()],
                          onSaved: (value) => division = value,
                          items: divisionList
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
                              setState(() {
                                divisionList = bdModel.getDivisionListBn();
                              });
                            } else {
                              setState(() {
                                divisionList = [];
                                selectedDivision = value.toString().trim();
                                districtList =
                                    bdModel.getDistrictListBn(selectedDivision);
                              });
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
                                setState(() {
                                  districtList = bdModel
                                      .getDistrictListBn(selectedDivision);
                                });
                              }
                            } else {
                              setState(() {
                                districtList = [];
                                selectedDistrict = value.toString().trim();
                                subDistrictList = bdModel
                                    .getSubDistrictListBn(selectedDistrict);
                              });
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
                          onSaved: (value) => upazila = value,
                          items: subDistrictList
                              .map((value) => DropdownMenuItem(
                                  value: value, child: Text("$value")))
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              if (selectedDistrict != "" &&
                                  selectedDistrict != null) {
                                setState(() {
                                  subDistrictList = bdModel
                                      .getSubDistrictListBn(selectedDistrict);
                                });
                              }
                            } else {
                              setState(() {
                                subDistrictList = [];
                              });
                            }
                          },
                        ),

                        //ইউনিয়ন/পৌরসভা/মেট্রোপলিটন
                        FormBuilderTextField(
                          attribute: "name",
                          decoration: InputDecoration(
                            labelText: "ইউনিয়ন/পৌরসভা/মেট্রোপলিটন",
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          onSaved: (value) => union = value,
                        ),

                        //গ্রাম/ওয়ার্ড
                        FormBuilderTextField(
                          attribute: "name",
                          decoration: InputDecoration(
                            labelText: "গ্রাম/ওয়ার্ড",
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          onSaved: (value) => village = value,
                        ),

                        //বাড়ির নম্বর/ঠিকানা
                        FormBuilderTextField(
                          attribute: "name",
                          decoration: InputDecoration(
                            labelText: "বাড়ির নম্বর/ঠিকানা",
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          validators: [
                            FormBuilderValidators.required(),
                          ],
                          onSaved: (value) => address = value,
                        ),

                        //রোগীর মোবাইল
                        FormBuilderTextField(
                          attribute: "phonenumber",
                          decoration: InputDecoration(
                            labelText: "ব্যক্তির মোবাইল নম্বর [১১ ডিজিট]",
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
                                  title: const Text("ফলাফল"),
                                  content: new Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          child: RichText(
                                        text: TextSpan(
                                          text: 'ফলাফল: $message\n',
                                          style: TextStyle(
                                            color: Colors.red,
                                            decoration: TextDecoration.none,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: "\nআইডি: $id\n",
                                              style: TextStyle(
                                                color: Colors.red,
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                      /*Html(
                                        data: """$notes""",
                                        onLinkTap: (url) {
                                          print("Openning url");
                                        },
                                      ),*/
                                    ],
                                  ),
                                  actions: <Widget>[
                                    new FlatButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .popUntil((route) => route.isFirst);
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
