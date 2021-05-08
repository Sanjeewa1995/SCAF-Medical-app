import 'package:flutter/material.dart';
import 'package:medical_app/api/api.dart';
import 'package:medical_app/api/api_response.dart';
import 'package:medical_app/api/api_status.dart';
import 'package:medical_app/custom_widget/app_bar.dart';
import 'package:medical_app/custom_widget/progress_dialog.dart';
import 'package:medical_app/screens/create_lab.dart';
import 'package:medical_app/screens/create_user_page.dart';
import 'package:medical_app/screens/select_user.dart';
import 'package:medical_app/shared_preference.dart';
import 'package:medical_app/utils/alert.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiResponse response;

  ProgressDialog _progressDialog;

  @override
  void initState() {
    super.initState();
    _progressDialog = ProgressDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CustomAppBar(title: 'Home'),
          Container(
            height: MediaQuery.of(context).size.height - 50 - statusbarHeight,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  height: 230,
                  child: Image.asset(
                    'images/home.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Expanded(flex: 2, child: Container()),
                ReusableButton(
                  text: 'New member',
                  icon: Icons.navigate_next,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CreateUser()));
                  },
                ),
                ReusableButton(
                  icon: Icons.navigate_next,
                  text: 'Select Member',
                  onTap: () async {
                    _progressDialog.show();
                    String uid = await SharedPreference().getUserUID();
                    response = await ApiCall.jsonGettRequest('Member/$uid');
                    _progressDialog.hide();
                    if (response.isSuccess) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectUser(
                                    user: response.jsonBody,
                                  )));
                    } else {
                      Alerts.showMessage(context, response.statusMessage);
                    }
                  },
                ),
                ReusableButton(
                  icon: Icons.navigate_next,
                  text: 'Create Lab',
                  onTap: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CreateLab()));
                  },
                ),
                Expanded(flex: 2, child: Container()),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ReusableButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final Function onTap;

  const ReusableButton({@required this.text, @required this.icon, this.onTap});

  @override
  _ReusableButtonState createState() => _ReusableButtonState();
}

class _ReusableButtonState extends State<ReusableButton> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(20, 15, 20, 0.0),
      elevation: 10.0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color(0xFF19799F), const Color(0xFF2FC9A6)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: ListTile(
            title: Padding(
              padding: EdgeInsets.only(left: 80),
              child: Text(
                widget.text,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            trailing: Icon(
              widget.icon,
              color: Colors.white,
              size: 30.0,
            ),
            onTap: widget.onTap),
      ),
    );
  }
}
