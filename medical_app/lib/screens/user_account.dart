import 'package:flutter/material.dart';
import 'package:medical_app/custom_widget/app_bar.dart';

class UserAccount extends StatefulWidget {
  final Map members;

  const UserAccount({Key key, this.members}) : super(key: key);

  _UserAccountState createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  // String _fullName = widget.members['firstName'];
  List _address = ['123/A', 'Amaragedara', 'Bulathsinhala'];
  String _nicNumber = '123456789';
  String _relationship = 'Brother';

  Widget _userDetails() {
    return Positioned(
        top: 175.0,
        bottom: 20.0,
        left: MediaQuery.of(context).size.width / 20,
        right: MediaQuery.of(context).size.width / 20,
        child: Container(
          height: 175,
          width: MediaQuery.of(context).size.width / 1.2,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
          ),
          child: Column(children: <Widget>[
            SizedBox(
              height: 50.0,
            ),
            Container(
              child: Text(
                'Malaka',
                // widget.members['firstName'],
                style: TextStyle(
                    color: Color(0xFF19769F),
                    fontSize: 20.0,
                    fontFamily: 'Pacifico',
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
                margin: EdgeInsets.all(5.0),
                child: ListTile(
                    leading: Text('Full Name:'),
                    title: Text(
                      'Malaka Sanjeewa Peiris'
                      // widget.members['firstName'] +
                      //   ' ' +
                      //   widget.members['middleName'] +
                      //   ' ' +
                      //   widget.members['lastName']
                        ))),
            Card(
                child: ListTile(
                    leading: Text('Address:'),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                       // Text(widget.members['address']),
                         Text(_address[1]),
                         Text(_address[2]),
                      ],
                    ))),
            Card(
                child: ListTile(
                    leading: Text('NIC Number:'),
                    title: Text(
                      '123456789v'
                      // widget.members['nationalId'] != null
                      //   ? widget.members['nationalId']
                      //   : ''
                        ))),
            Card(
                child: ListTile(
                    leading: Text('Relationship:'),
                    title: Text(
                      'User'
                      //  widget.members['relationshipFromTheUser'].toString()
                        ))),
          ]),
        ));
  }

  Widget _bBar() {
    return Container(
      height: 54.0,
      child: BottomNavigationBar(backgroundColor: Color(0xFFFFFFFF), items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              // color: Colors.white,
            ),
            title: Text(
              'Home',
              //  style: TextStyle(color: Colors.white),
            )),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              // color: Colors.white,
            ),
            title: Text(
              'Settings',
              //  style: TextStyle(color: Colors.white),
            ))
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return Scaffold(
        body: ListView(
          padding: EdgeInsets.all(0.0),
          children: <Widget>[
            CustomAppBar(title: 'User Account',),
            Container(
              width: MediaQuery.of(context).size.width,
              height: (orientation == Orientation.portrait)
                  ? MediaQuery.of(context).size.height //- 54
                  : MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(0.0),
              margin: EdgeInsets.all(0.0),
              child: Stack(
                children: <Widget>[
                  // Positioned(
                  //     child: CustomAppBar(
                  //   leading: IconButton(
                  //       icon: Container(
                  //         child: Icon(
                  //           Icons.cancel,
                  //           color: Colors.white,
                  //         ),
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(4.0),
                  //             border: Border.all(color: Colors.white)),
                  //       ),
                  //       onPressed: () {}),
                  //   trailing: IconButton(
                  //       icon: Container(
                  //         child: Icon(Icons.settings),
                  //         decoration: BoxDecoration(
                  //             color: Colors.white,
                  //             borderRadius: BorderRadius.circular(4.0),
                  //             border: Border.all(color: Colors.white)),
                  //       ),
                  //       onPressed: () {}),
                  //   image: 'images/profile.jpeg',
                  // )),
                  _userDetails(),
                  Positioned(
                    top: 120.0,
                    right: MediaQuery.of(context).size.width / 2 - 55.0,
                    //  left: MediaQuery.of(context).size.width/2,
                    child: Container(
                      height: 110.0,
                      width: 110.0,
                      //  padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(62.5),
                        border:
                            Border.all(color: Color(0xFFEBEBEB), width: 0.2),
                      ),
                      child: Center(
                        child: Container(
                          //  margin: EdgeInsets.only(bottom: 10.0),
                          width: 100,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(62.5),
                            child:Image.asset('images/me.jpg')
                            //  Image.network(
                            //   widget.members['photo']['imageUrl'],
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                          // decoration:
                          // BoxDecoration(
                          //     border: Border.all(
                          //         color: Color(0xE78F8989), width: 2.0),
                          //     image: DecorationImage(
                          //         image: Image.network(),
                          //         fit: BoxFit.cover),
                          //     borderRadius: BorderRadius.circular(62.5),
                          //     color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        //    margin: EdgeInsets.only(top:20.0),

        //  bottomNavigationBar: _bBar(),
      );
    });
  }
}
