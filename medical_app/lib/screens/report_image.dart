import 'package:flutter/material.dart';
import 'package:medical_app/custom_widget/app_bar.dart';

class ReportImage extends StatelessWidget {
  final String url;
  final String date;

  const ReportImage({Key key, this.url, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: '2020 June 23',
            traile: IconButton(
                color: Colors.white,
                iconSize: 30,
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/HomePage');
                }),
          ),
          Expanded(
            child: Card(
              margin: EdgeInsets.all(25),
              child: Image.asset('images/report.jpg', height: 700,)
             // Image.network(url, fit: BoxFit.cover,)
              ),
          )
        ],
      ),
    );
  }
}
