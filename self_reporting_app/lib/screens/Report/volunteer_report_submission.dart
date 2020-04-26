import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:selfreportingapp/model/patient_data.dart';
import 'package:selfreportingapp/services/api.dart';
import 'package:selfreportingapp/services/json_handle.dart';
import 'package:selfreportingapp/widgets/loading.dart';

class VolunteerUpdate extends StatefulWidget {
  @override
  _VolunteerUpdateState createState() => _VolunteerUpdateState();
}

class _VolunteerUpdateState extends State<VolunteerUpdate> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

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
                              onChanged: (value) =>
                                  volunteerAccessToken = value,
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
                              onPressed: () {
                                if (_fbKey.currentState.saveAndValidate()) {
                                  Dialogs.showLoadingDialog(
                                      context, _keyLoader);
                                  postVolunteerToken().then((onValue) {
                                    if (tokenStatus) {
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              '/MainCaseReport',
                                              ModalRoute.withName('/HomePage'))
                                          .then((value) {
                                        Navigator.of(_keyLoader.currentContext,
                                                rootNavigator: true)
                                            .pop();
                                      });
                                    } else {
                                      Navigator.of(_keyLoader.currentContext,
                                              rootNavigator: true)
                                          .pop();
                                    }
                                  });
                                } else {
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
            ],
          ),
        ),
      ),
    );
  }
}
