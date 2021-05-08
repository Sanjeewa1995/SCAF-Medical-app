import 'package:flutter/material.dart';
import 'package:medical_app/api/api.dart';
import 'package:medical_app/api/api_response.dart';
import 'package:medical_app/custom_widget/buttons.dart';

import 'package:medical_app/custom_widget/sugar_bottom_sheet.dart' as btm;
import 'package:medical_app/screens/charts.dart';
import 'package:medical_app/screens/sugar_report_list.dart';
import 'package:medical_app/shared_preference.dart';
import 'package:medical_app/custom_widget/progress_dialog.dart';
import 'package:medical_app/utils/alert.dart';

class SugarHome extends StatefulWidget {
  @override
  _SugarHomeState createState() => _SugarHomeState();
}

class _SugarHomeState extends State<SugarHome> {
  ProgressDialog _progressDialog;

  @override
  void initState() {
    super.initState();
    _progressDialog = ProgressDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 15, width: double.infinity),
          Container(
            height: 230,
            width: 230,
             decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(image: AssetImage('images/sugar.jpg',), fit: BoxFit.cover)
            ),
          ),
          SizedBox(height: 20.0),
          Theme(
            data: Theme.of(context)
                .copyWith(canvasColor: Colors.transparent),
            child: btm.SugarBottomSheet(),
          ),
          ReUseButton(
            label: 'Report List',
            onTap: () async {
              _progressDialog.show();
              String memberUid = //'1f4ca422-4038-4e99-98db-b2fa93b2a6e8';
                  await SharedPreference().getMemberUID();
              print(memberUid);
              ApiResponse response =
                  await ApiCall.jsonGettRequest('BloodSugar/$memberUid');
              _progressDialog.hide();
              if (response.isSuccess) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SugarReportList(
                             // report: response.jsonBody,
                            )));
              } else {
                Alerts.showMessage(context, response.statusMessage);
              }
            },
          ),
          ReUseButton(
            label: 'Report Chart',
            onTap: () async {
              _progressDialog.show();
              String memberUid = //'1f4ca422-4038-4e99-98db-b2fa93b2a6e8';
                  await SharedPreference().getMemberUID();
              print(memberUid);
              ApiResponse response =
                  await ApiCall.jsonGettRequest('BloodSugar/$memberUid');
              _progressDialog.hide();
              if (response.isSuccess) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BmiCharts(
                              // lineData: response.jsonBody,
                              // xData: "regDate",
                              // yData: "bloodSugarValue",
                              // yTitle: 'Blood Sugar',
                            )));
              } else {
                Alerts.showMessage(context, response.statusMessage);
              }
              // Navigator.of(context).pushReplacementNamed('/BmiCharts');
            },
          ),
        ],
      ),
    );
  }
}

class ReUseButton extends StatelessWidget {
  final String label;
  final Function onTap;

  const ReUseButton({Key key, this.label, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: MyRaisedButton(
        roundedBorde: true,
        label: label,
        onPressed: onTap,
        size: 300,
      ),
    );
  }
}
