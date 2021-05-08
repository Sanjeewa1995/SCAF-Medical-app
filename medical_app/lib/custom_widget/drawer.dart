import 'package:flutter/material.dart';

import '../shared_preference.dart';

class CustomDrawer extends StatefulWidget {
  final String url;
  final String name;

  const CustomDrawer({Key key, this.url, this.name}) : super(key: key);

  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          width: 300,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0xFF19769F),
                Color(0xFF35D6A6),
              ],
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      icon: Icon(Icons.cancel, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ],
              ),
              Container(
                height: 110.0,
                width: 110.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(62.5),
                  border: Border.all(color: Color(0xFFEBEBEB), width: 0.2),
                ),
                child: Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(62.5),
                      child: Image.network(
                        widget.url,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                widget.name,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 15.0),
              ),
              SizedBox(height: 30),
              Divider(color: Colors.white),
              ReUseButton(title: 'User Account'),
              Divider(color: Colors.white),
              ReUseButton(title: 'About Us'),
              Divider(color: Colors.white),
              ReUseButton(
                title: 'Log Out',
                onTap: () {
                  SharedPreference.setIsLoggedIn(null);
                  Navigator.of(context).pushReplacementNamed('/');
                },
              ),
              Divider(color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

class ReUseButton extends StatelessWidget {
  final String title;
  final Function onTap;

  const ReUseButton({Key key, this.title, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: onTap,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 30.0),
                Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 18.0)),
              ],
            ),
          ],
        ));
  }
}
