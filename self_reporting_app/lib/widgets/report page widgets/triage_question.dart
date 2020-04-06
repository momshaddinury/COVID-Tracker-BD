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
  bool placeHolder;

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
              value: 'হ্যাঁ',
              child: Text('হ্যাঁ'),
            ),
            FormBuilderFieldOption(value: 'না', child: Text('না')),
          ],
          validators: [
            FormBuilderValidators.required(),
          ],
          onSaved: (value) {
            if (placeHolder == fever) {
              if (value == "হ্যাঁ") {
                fever = true;
              } else if (value == "না") {
                fever = false;
              }
            } else if (placeHolder == coughOrThroatPain) {
              if (value == "হ্যাঁ") {
                coughOrThroatPain = true;
              } else if (value == "না") {
                coughOrThroatPain = false;
              }
            } else if (placeHolder == problemBreathing) {
              if (value == "হ্যাঁ") {
                problemBreathing = true;
              } else if (value == "না") {
                problemBreathing = false;
              }
            } else if (placeHolder == cameBackFromAbroad) {
              if (value == "হ্যাঁ") {
                cameBackFromAbroad = true;
              } else if (value == "না") {
                cameBackFromAbroad = false;
              }
            } else if (placeHolder == contactWithAnyCOVIDPatient) {
              if (value == "হ্যাঁ") {
                contactWithAnyCOVIDPatient = true;
              } else if (value == "না") {
                contactWithAnyCOVIDPatient = false;
              }
            } else if (placeHolder ==
                cameInContactWithPersonHavingCoughOrThroatPain) {
              if (value == "হ্যাঁ") {
                cameInContactWithPersonHavingCoughOrThroatPain = true;
              } else if (value == "না") {
                cameInContactWithPersonHavingCoughOrThroatPain = false;
              }
            } else if (placeHolder == riskGroup) {
              if (value == "হ্যাঁ") {
                riskGroup = true;
              } else if (value == "না") {
                riskGroup = false;
              }
            }
          },
        )
      ],
    );
  }
}
