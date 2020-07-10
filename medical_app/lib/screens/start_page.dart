import 'package:flutter/material.dart';
import 'package:medical_app/custom_widget/buttons.dart';
import 'package:medical_app/screens/login_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
            ),
            Expanded(
              flex: 4,
              child: Container(
                child: Image.asset(
                  'images/doctor.jpg',
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      'DOCTORS',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                        color: Color(0xFFCDCDCD),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      'Find expert doctors for perticular problem',
                      style:
                          TextStyle(fontSize: 17.0, color: Color(0xFFC0C0C0)),
                    ),
                    Text(
                      'on one tap',
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Color(0xFFC0C0C0),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: MyRaisedButton(
                  label: 'Getting Started  >',
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LogInPage()));
                  },
                  textColor: Colors.white,
                  roundedBorde: true,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
