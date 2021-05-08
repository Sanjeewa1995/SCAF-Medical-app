import 'package:flutter/material.dart';
import 'package:medical_app/api/api.dart';
import 'package:medical_app/api/dio_api_response.dart';
import 'package:medical_app/custom_widget/buttons.dart';
import 'package:medical_app/custom_widget/text_field.dart';
import 'package:medical_app/shared_preference.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';

import 'package:medical_app/custom_widget/progress_dialog.dart';
import 'package:medical_app/utils/alert.dart';

class SugarBottomSheet extends StatefulWidget {
  @override
  _SugarBottomSheetState createState() => _SugarBottomSheetState();
}

class _SugarBottomSheetState extends State<SugarBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _sugarController = TextEditingController();
  final _photoController = TextEditingController();

  final _sugarFocus = FocusNode();

  ProgressDialog _progressDialog;

  File image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _progressDialog = ProgressDialog(context);
  }

  Future getImage(ImageSource source) async {
    final imagePicker = await picker.getImage(source: source);
    setState(() {
      image = File(imagePicker.path);
    });

    print(imagePicker.path);
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
                      textEditingController: _sugarController,
                      labelText: 'Sugar Value',
                      keyboardType: TextInputType.number,
                      focusNode: _sugarFocus,
                      onFieldSubmitted: (t) {
                        _sugarFocus.unfocus();
                      },
                    ),
                     MyTextFormField(
                      textEditingController: _photoController,
                      labelText: 'Report Photo (Optional)',
                      keyboardType: TextInputType.number,
                      onTap: () async {
                        await getImage(ImageSource.camera);
                        setState(() {
                          _photoController.text = 'Add Photo';
                        });
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
                        String filename = image.path.split('/').last;
                        _progressDialog.show();
                        String uid = await SharedPreference().getMemberUID();
                        Map<String, dynamic> photoData = {
                          'Files': await MultipartFile.fromFile(image.path,
                              filename: filename,
                              contentType: MediaType('image', 'jpg')),
                          'type': 'image/jpeg',
                        };
                        Map<String, dynamic> _data = {
                          'BloodSugarValue':
                              double.parse(_sugarController.text),
                          'MemberUid': uid,
                          'LabLocationType': 0
                        };
                        if (image != null) {
                          _data.addAll(photoData);
                        }
                        ApiResponse response = await ApiCall.dioPostRequest(
                            endPoint: 'BloodSugar/createbloodsugar',
                            data: _data);
                        _progressDialog.hide();
                        if (response.isSuccess) {
                          Navigator.of(context).pop();
                          Alerts.showMessage(
                              context, 'Add Blood Sugar success', title: '');
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
