import 'package:flutter/material.dart';
import 'package:medical_app/screens/start_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medical app',
      home:StartPage(),
    );
  }
}

