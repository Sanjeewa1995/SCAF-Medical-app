import 'package:flutter/material.dart';
import 'package:medical_app/api/api_response.dart';
import 'package:medical_app/custom_widget/app_bar.dart';
import 'package:medical_app/models/register.dart';
import 'package:medical_app/utils/alert.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:dio/dio.dart';
import 'package:medical_app/shared_preference.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

import 'package:medical_app/const_value.dart';
import 'package:medical_app/custom_widget/buttons.dart';
import 'package:medical_app/api/api.dart';
import 'package:medical_app/custom_widget/progress_dialog.dart';
import 'package:medical_app/models/user_model.dart';
import 'package:medical_app/api/dio_api_response.dart' as dioRes;


class SelectDp extends StatefulWidget {
  final Map<String, dynamic> data;
//  final String sirName;
//  final String firstName;
//  final String middleName;
//  final String lastName;
//  final String userName;
//  final String birthDate;
//  final String email;
//  final String password;
//  final String birthPlace;
//  final String birthTime;
//  final String phoneNumber;
//  final String district;
//  final String city;
//  final String nic;
//  final String address;

  static const routeName = '/selectDp';

  const SelectDp({Key key, this.data}) : super(key: key);

  //const SelectDp({Key key, this.sirName, this.firstName, this.middleName, this.lastName, this.userName, this.birthDate, this.email, this.password, this.birthPlace, this.birthTime, this.phoneNumber, this.district, this.city, this.nic, this.address}) : super(key: key);

  @override
  _SelectDpState createState() => _SelectDpState();
}

class _SelectDpState extends State<SelectDp> {
  Register reg = Register();
  File image;
  Dio dio = Dio();
  final picker = ImagePicker();
  ProgressDialog _progressDialog;
  

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

  uploadData() async {
    String filename = image.path.split('/').last;

    _progressDialog.show();

    String uid = await SharedPreference().getUserUID();

    print(uid.toString());
    print(widget.data.toString());

    Map<String, dynamic> allData = {
      'ApplicationUserUid': uid,
      'Files': await MultipartFile.fromFile(image.path,
          filename: filename, contentType: MediaType('image', 'jpg')),
      'type': 'image/jpeg',
    };

    if (widget.data != null && widget.data.length > 0) {
      allData.addAll(widget.data);
    }
    print(allData.toString());

    dioRes.ApiResponse response = await ApiCall.dioPostRequest(
        endPoint: 'Member/createmember', data: allData);

       // CreateUserModel resData = createUserModelFromJson(response.jsonBody);

    _progressDialog.hide();

    if (response.isSuccess) {
      Alerts.showMessage(context, 'SignUp Success', title: 'Response');
    } else {
      Alerts.showMessage(context, response.statusMessage);
    }

    //   FormData formData = FormData.fromMap({
    //     'DateOfBirth': widget.birthDate,
    //     'NationId': widget.nic,
    //     'FirstName': widget.firstName,
    //     'LastName': widget.lastName,
    //     'MiddleName': widget.middleName,
    //     'SurName': widget.sirName,
    //     'City': widget.city,
    //     'District': widget.district,
    //     'Address': widget.address,
    //     'BirthPlace': widget.birthPlace,
    //     'BirthTime': widget.birthTime,
    //     'UserName': widget.userName,
    //     'Password': widget.password,
    //     'Email': widget.email,
    //     'PhoneNumber': widget.phoneNumber,
    //     'ApplicationUserUid': uid,
    //     'RelationshipFromTheUser': 0,
    //     'MemberRole': 0,
    //     'Files': await MultipartFile.fromFile(image.path,
    //         filename: filename, contentType: MediaType('image', 'jpg')),
    //     'type': 'image/jpeg',
    //   });
    //   try {
    //     Response response = await dio.post(url,
    //         data: formData,
    //         options: Options(headers: {
    //           'accept': "*/*",
    //           "Content-Type": "multipart/form-data"
    //         }));
    //     print(response);
    //   } on DioError catch (e) {
    //     print(e.error);
    //     print(e.response.data);
    //     return Alert(
    //         context: context,
    //         title: 'Error',
    //         content: Text(e.response.data),
    //         buttons: [
    //           DialogButton(
    //               gradient: LinearGradient(
    //                 colors: <Color>[
    //                   Color(0xFF19769F),
    //                   Color(0xFF35D6A6),
    //                 ],
    //               ),
    //               child: Text(
    //                 'OK',
    //                 style: TextStyle(
    //                   color: Colors.white,
    //                 ),
    //               ),
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //               })
    //         ],
    //         style: AlertStyle(
    //           backgroundColor: Color(0xFFf5f5f5),
    //         )).show();

    //     //   eMassage = await e.response.data;
    //   }
    //   return Alert(
    //       context: context,
    //       title: '',
    //       content: Text('SignUp Success'),
    //       buttons: [
    //         DialogButton(
    //             gradient: LinearGradient(
    //               colors: <Color>[
    //                 Color(0xFF19769F),
    //                 Color(0xFF35D6A6),
    //               ],
    //             ),
    //             child: Text(
    //               'OK',
    //               style: TextStyle(
    //                 color: Colors.white,
    //               ),
    //             ),
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             })
    //       ],
    //       style: AlertStyle(
    //         backgroundColor: Color(0xFFf5f5f5),
    //       )).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAppBar(title: 'Select Profile Photo',),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          // Text(
          //   'Select profile photo',
          //   style: titleStyle,
          // ),
          SizedBox(height: 70),
          Container(
            height: 100,
            width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(62.5),
              child: image == null
                  ? Image.asset(
                      'images/dp.png',
                      fit: BoxFit.cover,
                    )
                  : Image.file(
                      image,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          SizedBox(height: 20),
          ReUseOutlineButton(
            title: 'Take Photo',
            imagePath: 'images/camera.png',
            gap: 5.0,
            onTap: () {
              getImage(ImageSource.camera);
            },
          ),
          SizedBox(height: 20.0),
          ReUseOutlineButton(
            title: 'Gallery',
            imagePath: 'images/gallery.png',
            gap: 10.0,
            onTap: () {
              getImage(ImageSource.gallery);
            },
          ),
          SizedBox(height: 30,),
          MyRaisedButton(
            size: 200,
              roundedBorde: true,
              label: 'Create',
              textColor: Colors.white,
              onPressed: () async {
                await uploadData();
              }),
        ],
      ),
    );
  }
}

class ReUseOutlineButton extends StatelessWidget {
  final String title;
  final String imagePath;
  final double gap;
  final Function onTap;

  const ReUseOutlineButton(
      {Key key, this.title, this.imagePath, this.gap, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      child: OutlineButton(
        borderSide: BorderSide(color: Colors.black),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                  height: 50, width: 50, child: Image.asset(imagePath)),
            ),
            SizedBox(
              width: gap,
            ),
            Container(child: Text(title))
          ],
        ),
      ),
    );
  }
}
