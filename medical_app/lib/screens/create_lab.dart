import 'package:flutter/material.dart';

import 'package:medical_app/custom_widget/text_field.dart';
import 'package:medical_app/custom_widget/buttons.dart';
import 'package:medical_app/screens/home.dart';

class CreateLab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    TextEditingController _labNameController = TextEditingController();
    TextEditingController _addressController = TextEditingController();
    TextEditingController _contactController = TextEditingController();

   final FocusNode _labNameFocus = FocusNode();
   final FocusNode _addressFocus = FocusNode();
   final FocusNode _contactNumberFocus = FocusNode();

    _fieldFocusChange(
        BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
      currentFocus.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Create Lab'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              MyTextFormField(
                textEditingController: _labNameController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return ' LabName is required';
                  }
                  return null;
                },
                onSaved: (String value) {
                  var sirName = value;
                },
                keyboardType: TextInputType.text,
                labelText: 'Lab Name',
                textInputAction: TextInputAction.next,
                focusNode: _labNameFocus,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(context, _labNameFocus, _addressFocus);
                },
              ),
              MyTextFormField(
                textEditingController: _addressController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return ' LabName is required';
                  }
                  return null;
                },
                onSaved: (String value) {
                  var sirame = value;
                },
                keyboardType: TextInputType.text,
                labelText: 'Address',
                textInputAction: TextInputAction.next,
                focusNode: _addressFocus,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(
                      context, _addressFocus, _contactNumberFocus);
                },
              ),
              MyTextFormField(
                textEditingController: _contactController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return ' LabName is required';
                  }
                  return null;
                },
                onSaved: (String value) {
                  var sirNam = value;
                },
                keyboardType: TextInputType.text,
                labelText: 'Lab Name',
                textInputAction: TextInputAction.next,
                focusNode: _contactNumberFocus,
                onFieldSubmitted: (term) {
                  _contactNumberFocus.unfocus();
                },
              ),
              MyRaisedButton(
                roundedBorde: true,
                label: 'Create',
                textColor: Colors.white,
                onPressed: () async {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
