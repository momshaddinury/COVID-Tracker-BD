import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

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
          onChanged: (value) {
            if (value == "হ্যাঁ") {
              placeHolder = true;
            } else if (value == "না") {
              placeHolder = false;
            }
          },
          validators: [
            FormBuilderValidators.required(),
          ],
          onSaved: (value) {
            if (value == "হ্যাঁ") {
              placeHolder = true;
            } else if (value == "না") {
              placeHolder = false;
            }
          },
        )
      ],
    );
  }
}
