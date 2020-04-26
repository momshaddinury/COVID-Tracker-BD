import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:selfreportingapp/model/patient_data.dart';

class PersonalInformation extends StatelessWidget {
  const PersonalInformation({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //Name
        FormBuilderTextField(
          attribute: "name",
          decoration: InputDecoration(
            labelText: "নাম?",
            filled: true,
            fillColor: Colors.grey[200],
          ),
          validators: [
            FormBuilderValidators.required(),
          ],
          onSaved: (value) => personalQAPlaceholder.fullName = value,
        ),

        // Contact Number:
        FormBuilderTextField(
          attribute: "phonenumber",
          decoration: InputDecoration(
            labelText: "ফোন নম্বর (১১ ডিজিট)",
            filled: true,
            fillColor: Colors.grey[200],
          ),
          keyboardType: TextInputType.number,
          validators: [
            FormBuilderValidators.required(),
            FormBuilderValidators.numeric(),
            FormBuilderValidators.minLength(11, errorText: "১১ ডিজিট"),
            FormBuilderValidators.maxLength(11, errorText: "১১ ডিজিট")
          ],
          onSaved: (value) => personalQAPlaceholder.phoneNumber = value,
        ),

        // NID:
        FormBuilderTextField(
          attribute: "number",
          decoration: InputDecoration(
            labelText: "এন আই ডি (অপশনাল)",
            filled: true,
            fillColor: Colors.grey[200],
          ),
          keyboardType: TextInputType.number,
          onSaved: (value) => personalQAPlaceholder.nid = value,
        ),

        // Gender:
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: AutoSizeText("লিঙ্গ"),
        ),
        FormBuilderChoiceChip(
          attribute: 'choice_chip',
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
          ),
          options: [
            FormBuilderFieldOption(
              value: 'Male',
              child: Text('পুরুষ'),
            ),
            FormBuilderFieldOption(
              value: 'Female',
              child: Text('মহিলা'),
            ),
            FormBuilderFieldOption(
              value: 'Others',
              child: Text('অন্যান্য'),
            )
          ],
          validators: [
            FormBuilderValidators.required(),
          ],
          onSaved: (value) {
            personalQAPlaceholder.gender = value;
          },
        ),

        // Age
        FormBuilderTextField(
          attribute: "age",
          decoration: InputDecoration(
            labelText: "আপনার বয়স?",
            filled: true,
            fillColor: Colors.grey[200],
          ),
          validators: [
            FormBuilderValidators.required(),
            FormBuilderValidators.numeric(),
          ],
          onSaved: (value) => personalQAPlaceholder.age = value,
          keyboardType: TextInputType.number,
        ),

        FormBuilderTextField(
          attribute: "text",
          decoration: InputDecoration(
            labelText: "বাড়ির নম্বর/ঠিকানা",
            filled: true,
            fillColor: Colors.grey[200],
          ),
          validators: [
            FormBuilderValidators.required(),
          ],
          onSaved: (value) => personalQAPlaceholder.address = value,
        ),
      ],
    );
  }
}
