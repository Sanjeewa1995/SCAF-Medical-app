import 'package:flutter/material.dart';
import 'package:medical_app/shared_preference.dart';

class SplashScreen extends StatefulWidget {

  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 300), () {
      this._checkLogeedIn();
    });
  }



  _checkLogeedIn() async {
    isLoggedIn = await SharedPreference.getIsLoggedIn();
    print(isLoggedIn);
    if (isLoggedIn!=null) {
      Navigator.of(context).pushReplacementNamed('/HomePage');
    } else {
      Navigator.of(context).pushReplacementNamed('/StartPage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Image.asset("images/home.png"),
      ),
    );
  }
}
