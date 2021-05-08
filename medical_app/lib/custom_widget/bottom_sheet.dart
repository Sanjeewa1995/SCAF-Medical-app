import 'package:flutter/material.dart';
import 'package:medical_app/api/api.dart';
import 'package:medical_app/api/dio_api_response.dart';
import 'package:medical_app/custom_widget/buttons.dart';
import 'package:medical_app/custom_widget/text_field.dart';
import 'package:medical_app/shared_preference.dart';

import 'package:medical_app/custom_widget/progress_dialog.dart';
import 'package:medical_app/utils/alert.dart';

class BottomSheet extends StatefulWidget {
  @override
  _BottomSheetState createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _heightController;

  TextEditingController _weightController;

  final _heightFocus = FocusNode();

  final _weightFocus = FocusNode();
  ProgressDialog _progressDialog;

  @override
  void initState() {
    super.initState();
    _heightController = TextEditingController();
    _weightController = TextEditingController();
    _progressDialog = ProgressDialog(context);
  }

  void _clearValue() {
    _heightController.clear();
    _weightController.clear();
  }

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  _showModelBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 500,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0))),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 30, 40, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    MyTextFormField(
                      textEditingController: _heightController,
                      labelText: 'Height',
                      keyboardType: TextInputType.number,
                      focusNode: _heightFocus,
                      onFieldSubmitted: (t) {
                        _fieldFocusChange(context, _heightFocus, _weightFocus);
                      },
                    ),
                    MyTextFormField(
                      textEditingController: _weightController,
                      labelText: 'weight',
                      keyboardType: TextInputType.number,
                      focusNode: _weightFocus,
                      onFieldSubmitted: (t) {
                        _weightFocus.unfocus();
                      },
                    ),
                    SizedBox(height: 5),
                    MyRaisedButton(
                      label: 'Add',
                      roundedBorde: true,
                      size: 100,
                      height: 50,
                      onPressed: () async {
                        if (!_formKey.currentState.validate()) {
                          return;
                        }
                        _progressDialog.show();
                        String uid = await SharedPreference().getMemberUID();
                        Map<String, dynamic> _data = {
                          'Height': double.parse(_heightController.text),
                          'Weight': double.parse(_weightController.text),
                          'MemberUid': uid,
                          'LabLocationType': 0
                        };
                        ApiResponse response = await ApiCall.dioPostRequest(
                            endPoint: 'Bmi/createbmi', data: _data);
                        _progressDialog.hide();
                        if (response.isSuccess) {
                          _clearValue();
                          Navigator.of(context).pop();
                          Alerts.showMessage(context, 'Add BMI success', title: '');
                        } else {
                          Alerts.showMessage(context, response.statusMessage);
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MyRaisedButton(
        roundedBorde: true,
        label: 'Add Report',
        onPressed: () {
          _showModelBottomSheet(context);
        },
        size: 300,
      ),
    );
  }
}
