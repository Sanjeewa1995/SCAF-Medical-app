import 'package:flutter/material.dart';
import 'package:medical_app/custom_widget/buttons.dart';
import 'package:medical_app/custom_widget/text_field.dart';
import 'package:medical_app/screens/signup_page.dart';
import 'package:medical_app/api.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LogInPage extends StatefulWidget {
  LogInPage({Key key}) : super(key: key);

  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  bool waiting = false;
  String response;

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final FocusNode _userNameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  Widget _userName() {
    return MyTextFormField(
      textEditingController: _userNameController,
      keyboardType: TextInputType.text,
      labelText: 'User Name',
      hintText: 'Malaka',
      textInputAction: TextInputAction.next,
      focusNode: _userNameFocus,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _userNameFocus, _passwordFocus);
      },
    );
  }

  _buildPassword() {
    return MyTextFormField(
      textEditingController: _passwordController,
      labelText: 'Password',
      textInputAction: TextInputAction.done,
      focusNode: _passwordFocus,
      onFieldSubmitted: (term) {
        _passwordFocus.unfocus();
      },
    );
  }

  Widget _myAppBar() {
    return Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Color(0xFF19769F),
          Color(0xFF35D6A6),
        ],
        begin: Alignment.centerRight,
        end: Alignment(-1.0, -1.0),
      )),
      child: Center(
        child: Container(
          child: Text(
            'Sign In',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  _responseAler(String response) {
    return Alert(
        context: context,
        title: 'Response',
        content: Text(response),
        buttons: [
          DialogButton(
              gradient: LinearGradient(
                colors: <Color>[
                  Color(0xFF19769F),
                  Color(0xFF35D6A6),
                ],
              ),
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
        style: AlertStyle(
          backgroundColor: Color(0xFFf5f5f5),
        )).show();
  }

  Widget _waiting() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return waiting
        ? _waiting()
        : Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: <Widget>[
                    // _myAppBar(),
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                color: Color(0xFF19769F),
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _userName(),
                    _buildPassword(),

                    Expanded(
                      flex: 1,
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FlatButton(
                              onPressed: () {},
                              child: Text('Forget Password?'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: MyRaisedButton(
                        roundedBorde: true,
                        label: 'Sign In',
                        textColor: Colors.white,
                        onPressed: () async {
                          setState(() {
                            waiting = true;
                          });

                          response = await logInUser(_userNameController.text,
                              _passwordController.text);
                          setState(() {
                            waiting = false;
                          });
                          _responseAler(response);
                        },
                      ),
                    ),

                    Expanded(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('Don\'t Have Account?'),
                            FlatButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpPage()));
                              },
                              child: Text(
                                'Create Account',
                                style: TextStyle(
                                  color: Color(0xFF19769F),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
