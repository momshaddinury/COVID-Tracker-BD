import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:selfreportingapp/model/patient_data.dart';

class TriageQuestion extends StatelessWidget {
  TriageQuestion({
    Key key,
    @required this.question,
    @required this.placeHolder,
  }) : super(key: key);

  final String question;
  String placeHolder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: AutoSizeText(question),
        ),
        FormBuilderChoiceChip(
          attribute: 'choice_chip',
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
          ),
          options: [
            FormBuilderFieldOption(
              value: true,
              child: Text('হ্যাঁ'),
            ),
            FormBuilderFieldOption(
              value: false,
              child: Text('না'),
            ),
          ],
          validators: [
            FormBuilderValidators.required(),
          ],
          onSaved: (value) {
            if (placeHolder == "fever") {
              fever = value;
            } else if (placeHolder == "coughOrThroatPain") {
              coughOrThroatPain = value;
            } else if (placeHolder == "problemBreathing") {
              problemBreathing = value;
            } else if (placeHolder == "cameBackFromAbroad") {
              cameBackFromAbroad = value;
            } else if (placeHolder == "contactWithAnyCOVIDPatient") {
              contactWithAnyCOVIDPatient = value;
            } else if (placeHolder ==
                "cameInContactWithPersonHavingCoughOrThroatPain") {
              cameInContactWithPersonHavingCoughOrThroatPain = value;
            } else if (placeHolder == "riskGroup") {
              riskGroup = value;
            }
          },
        )
      ],
    );
  }
}
