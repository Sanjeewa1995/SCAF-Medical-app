import 'package:flutter/material.dart';
import 'package:medical_app/custom_widget/drawer.dart';
import 'package:medical_app/screens/bmi_home.dart';
import 'package:medical_app/screens/pressure_home.dart';
import 'package:medical_app/screens/sugar_home.dart';

class TabBarScreen extends StatefulWidget {
  final Map user;

  const TabBarScreen({Key key, this.user}) : super(key: key);

  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _globalKey,
        drawer: CustomDrawer(
          url: widget.user["photo"]["imageUrl"],
          name: widget.user['firstName'] +
              ' ' +
              widget.user['middleName'] +
              ' ' +
              widget.user['lastName'],
        ),
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/HomePage');
                })
          ],
          leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                _globalKey.currentState.openDrawer();
              }),
          title: Text('Member Home'),
          centerTitle: true,
          bottom:
              TabBar(tabs: <Widget>[Tab(text: 'BMI'), Tab(text: 'Pressure'), Tab(text:'Sugar')]),
        ),
        body: TabBarView(children: [BmiHome(), PressureHome(), SugarHome()]),
      ),
    );
  }
}
