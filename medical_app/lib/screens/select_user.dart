import 'package:flutter/material.dart';
import 'package:medical_app/custom_widget/app_bar.dart';
import 'package:medical_app/screens/bmi_home.dart';
import 'package:medical_app/screens/pressure_home.dart';
import 'package:medical_app/screens/tab_screen.dart';
import 'package:medical_app/screens/user_account.dart';
import 'package:medical_app/shared_preference.dart';

import 'package:medical_app/custom_widget/progress_dialog.dart';

class SelectUser extends StatefulWidget {
  final List user;

  const SelectUser({Key key, this.user}) : super(key: key);

  _SelectUserState createState() => _SelectUserState();
}

class _SelectUserState extends State<SelectUser> {
  @override
  void initState() {
    super.initState();

    // _progressDialog = ProgressDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    final double statusbarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text(
      //     'Select member',
      //     style: TextStyle(color: Colors.white),
      //   ),
      // ),
      body: Column(
        children: [
          CustomAppBar(title: 'Select User'),
          Container(
            margin: EdgeInsets.all(0),
 height: MediaQuery.of(context).size.height - 50 - statusbarHeight,
            child: ListView.builder(
                itemCount: widget.user.length,
                itemBuilder: (context, index) {
                  String fullName = widget.user[index]['firstName'];
                  String relationship =
                      widget.user[index]["relationshipFromTheUser"].toString();
                  String imageUrl = widget.user[index]['photo']['imageUrl'];
                  return Container(
                    margin: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 20.0),
                    height: 80,
                    child: Card(
                      shadowColor: Color(0xFF35D6A6),
                      elevation: 7.0,
                      // color: Colors.blueAccent,
                      child: ListTile(
                        title: Text(
                          fullName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Color(0xFF19769F)),
                        ),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(62.5),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            height: 50,
                            width: 50,
                          ),
                        ),
                        subtitle: Text(
                          relationship,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Color(0xFFD1D2D2)),
                        ),
                        onTap: () async {
                          // _progressDialog.show();
                          await SharedPreference(
                                  memberUid: widget.user[index]["memberUid"])
                              .setMemberUID();
                          print(widget.user[index]["memberUid"]);
                          // _progressDialog.hide();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => TabBarScreen(user:widget.user[index])));
                        },
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
