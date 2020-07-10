import 'package:flutter/material.dart';
import 'package:medical_app/custom_widget/text_field.dart';
import 'package:medical_app/custom_widget/buttons.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:validators/validators.dart' as validator;
import 'package:dio/dio.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _fullNameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _userNameFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _bDayFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _addressFormKey = GlobalKey<FormState>();

  Dio dio = Dio();

  TextEditingController _bDayController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _sirNameController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _middleNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _districtController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _bPlaceController = TextEditingController();
  TextEditingController _bTimeController = TextEditingController();
  TextEditingController _nicController = TextEditingController();
  TextEditingController _lineOneController = TextEditingController();
  TextEditingController _lineTwoController = TextEditingController();

  final FocusNode _fullNameFocus = FocusNode();
  final FocusNode _sirNameFocus = FocusNode();
  final FocusNode _userNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final FocusNode _firstLineFocus = FocusNode();
  final FocusNode _secondLineFocus = FocusNode();
  final FocusNode _bDayFocus = FocusNode();
  final FocusNode _bPlaceFocus = FocusNode();
  final FocusNode _bTimeFocus = FocusNode();
  final FocusNode _phoneNumberFocus = FocusNode();
  final FocusNode _districtFocus = FocusNode();
  final FocusNode _cityFocus = FocusNode();
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _middleNameFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final FocusNode _nicFocus = FocusNode();

  String fullName;
  String sirName;
  String firstName;
  String middleName;
  String lastName;
  String userName;
  String bDate;
  String email;
  String password;
  String confirmPassword;
  String _date;
  String bPlace;
  String bTime;
  String phoneNumber;
  String firstStreet;
  String secondStreet;
  String district;
  String city;
  String nic;
  String address;
  String eMassage;

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  _fullNameAlert() {
    return Alert(
        style: AlertStyle(
            backgroundColor: Color(0xFFf5f5f5),
            titleStyle: TextStyle(
              color: Color(0xFF19769F),
            )),
        title: 'Full Name',
        context: context,
        content: Form(
          key: _fullNameFormKey,
          child: Column(
            children: <Widget>[
              MyTextFormField(
                textEditingController: _sirNameController,
                keyboardType: TextInputType.text,
                validator: (String value) {
                  if (value.isEmpty) {
                    return ' SirName is required';
                  }
                  return null;
                },
                onSaved: (String value) {
                  sirName = value;
                },
                labelText: 'SirName',
                textInputAction: TextInputAction.next,
                focusNode: _sirNameFocus,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(context, _sirNameFocus, _firstNameFocus);
                },
              ),
              MyTextFormField(
                textEditingController: _firstNameController,
                keyboardType: TextInputType.text,
                validator: (String value) {
                  if (value.isEmpty) {
                    return ' Name is required';
                  }
                  return null;
                },
                onSaved: (String value) {
                  firstName = value;
                },
                labelText: 'First Name',
                textInputAction: TextInputAction.next,
                focusNode: _firstNameFocus,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(context, _firstNameFocus, _middleNameFocus);
                },
              ),
              MyTextFormField(
                textEditingController: _middleNameController,
                keyboardType: TextInputType.text,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Middle Name is required';
                  }
                  return null;
                },
                onSaved: (String value) {
                  middleName = value;
                },
                labelText: 'Middle Name',
                textInputAction: TextInputAction.next,
                focusNode: _middleNameFocus,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(context, _middleNameFocus, _lastNameFocus);
                },
              ),
              MyTextFormField(
                textEditingController: _lastNameController,
                keyboardType: TextInputType.text,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Last Name is required';
                  }
                  return null;
                },
                onSaved: (String value) {
                  lastName = value;
                },
                labelText: 'Last Name',
                textInputAction: TextInputAction.done,
                focusNode: _lastNameFocus,
                onFieldSubmitted: (term) {
                  _lastNameFocus.unfocus();
                },
              ),
            ],
          ),
        ),
        buttons: [
          DialogButton(
            child: Text(
              'Submit',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              if (!_fullNameFormKey.currentState.validate()) {
                return;
              }
              _fullNameFormKey.currentState.save();
              Navigator.of(context).pop();
            },
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFF19769F),
                Color(0xFF35D6A6),
              ],
            ),
          )
        ]).show();
  }

  _userNameAlert() {
    return Alert(
        style: AlertStyle(
            backgroundColor: Color(0xFFf5f5f5),
            titleStyle: TextStyle(
              color: Color(0xFF19769F),
            )),
        title: 'User Name',
        context: context,
        content: Form(
          key: _userNameFormKey,
          child: Column(
            children: <Widget>[
              MyTextFormField(
                textEditingController: _userNameController,
                keyboardType: TextInputType.text,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'User name is required';
                  }
                  if (value.contains(" ")) {
                    return 'Don\'t add space between letters';
                  }
                  return null;
                },
                onSaved: (String value) {
                  userName = value;
                },
                labelText: 'User Name',
                textInputAction: TextInputAction.next,
                focusNode: _userNameFocus,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(context, _userNameFocus, _emailFocus);
                },
              ),
              MyTextFormField(
                textEditingController: _emailController,
                keyboardType: TextInputType.text,
                validator: (String value) {
                  if (!validator.isEmail(value)) {
                    return 'Plese Enter valide email';
                  }
                  return null;
                },
                onSaved: (String value) {
                  email = value;
                },
                labelText: 'Email',
                textInputAction: TextInputAction.next,
                focusNode: _emailFocus,
                onFieldSubmitted: (term) {
                  _emailFocus.unfocus();
                },
              ),
            ],
          ),
        ),
        buttons: [
          DialogButton(
            child: Text(
              'Submit',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              if (!_userNameFormKey.currentState.validate()) {
                return;
              }
              _userNameFormKey.currentState.save();
              Navigator.of(context).pop();
            },
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFF19769F),
                Color(0xFF35D6A6),
              ],
            ),
          )
        ]).show();
  }

  _passwordAlert() async {
    return Alert(
        style: AlertStyle(
            backgroundColor: Color(0xFFf5f5f5),
            titleStyle: TextStyle(
              color: Color(0xFF19769F),
            )),
        title: 'Password',
        context: context,
        content: Form(
          key: _passwordFormKey,
          child: Column(
            children: <Widget>[
              MyTextFormField(
                textEditingController: _passwordController,
                keyboardType: TextInputType.text,
                validator: (String value) {
                  Pattern pattern =
                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
                  RegExp regex = new RegExp(pattern);
                  print(value);
                  if (value.isEmpty) {
                    return 'Please enter password';
                  } else {
                    if (!regex.hasMatch(value))
                      return 'Enter valid password';
                    else
                      return null;
                  }
                },
                onSaved: (String value) {
                  password = value;
                },
                labelText: 'Password',
                textInputAction: TextInputAction.next,
                focusNode: _passwordFocus,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(
                      context, _passwordFocus, _confirmPasswordFocus);
                },
              ),
              MyTextFormField(
                textEditingController: _confirmPasswordController,
                keyboardType: TextInputType.text,
                validator: (String value) {
                  if (_passwordController.text !=
                      _confirmPasswordController.text) {
                    return 'Confirm password is not valide';
                  }
                  return null;
                },
                onSaved: (String value) {
                  confirmPassword = value;
                },
                labelText: 'Confirm password',
                textInputAction: TextInputAction.next,
                focusNode: _confirmPasswordFocus,
                onFieldSubmitted: (term) {
                  _confirmPasswordFocus.unfocus();
                },
              ),
            ],
          ),
        ),
        buttons: [
          DialogButton(
            child: Text(
              'Submit',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              if (!_passwordFormKey.currentState.validate()) {
                return;
              }
              _passwordFormKey.currentState.save();
              Navigator.of(context).pop();
            },
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFF19769F),
                Color(0xFF35D6A6),
              ],
            ),
          )
        ]).show();
  }

  _addressAlert() async {
    return Alert(
        style: AlertStyle(
            backgroundColor: Color(0xFFf5f5f5),
            titleStyle: TextStyle(
              color: Color(0xFF19769F),
            )),
        title: 'Location',
        context: context,
        content: Form(
          key: _addressFormKey,
          child: Column(
            children: <Widget>[
              MyTextFormField(
                textEditingController: _lineOneController,
                keyboardType: TextInputType.text,
                validator: (String value) {
                  if (value.isEmpty) {
                    return ' Line one is required';
                  }
                  return null;
                },
                onSaved: (String value) {
                  firstStreet = value;
                },
                labelText: 'Line one',
                textInputAction: TextInputAction.next,
                focusNode: _firstLineFocus,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(context, _firstLineFocus, _secondLineFocus);
                },
              ),
              MyTextFormField(
                textEditingController: _lineTwoController,
                keyboardType: TextInputType.text,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Line two is required';
                  }
                  return null;
                },
                onSaved: (String value) {
                  secondStreet = value;
                },
                labelText: 'Line two',
                textInputAction: TextInputAction.next,
                focusNode: _secondLineFocus,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(context, _secondLineFocus, _cityFocus);
                },
              ),
              MyTextFormField(
                textEditingController: _cityController,
                keyboardType: TextInputType.text,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'City is required';
                  }
                  return null;
                },
                onSaved: (String value) {
                  city = value;
                },
                labelText: 'City',
                textInputAction: TextInputAction.done,
                focusNode: _cityFocus,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(context, _cityFocus, _districtFocus);
                },
              ),
              MyTextFormField(
                textEditingController: _districtController,
                keyboardType: TextInputType.text,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'District is required';
                  }
                  return null;
                },
                onSaved: (String value) {
                  district = value;
                },
                labelText: 'Ditrict',
                textInputAction: TextInputAction.next,
                focusNode: _districtFocus,
                onFieldSubmitted: (term) {
                  _districtFocus.unfocus();
                },
              ),
            ],
          ),
        ),
        buttons: [
          DialogButton(
            child: Text(
              'Submit',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              if (!_addressFormKey.currentState.validate()) {
                return;
              }
              _addressFormKey.currentState.save();
              Navigator.of(context).pop();
            },
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFF19769F),
                Color(0xFF35D6A6),
              ],
            ),
          )
        ]).show();
  }

  _bDayAlert() {
    return Alert(
        style: AlertStyle(
            backgroundColor: Color(0xFFf5f5f5),
            titleStyle: TextStyle(
              color: Color(0xFF19769F),
            )),
        title: 'Birth Date',
        context: context,
        content: Form(
          key: _bDayFormKey,
          child: Column(
            children: <Widget>[
              MyTextFormField(
                textEditingController: _bDayController,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Birth Date is required';
                  }
                  return null;
                },
                onSaved: (String value) {
                  bDate = value;
                },
                labelText: 'Date Of Birth',
                hintText: '1995/05/29',
                onTap: () async {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  await _dateFlicker();
                  setState(() {
                    _bDayController.text = _date;
                  });
                },
                focusNode: _bDayFocus,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(context, _bDayFocus, _bPlaceFocus);
                },
              ),
              MyTextFormField(
                textEditingController: _bPlaceController,
                keyboardType: TextInputType.text,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Birth place is required';
                  }
                  return null;
                },
                onSaved: (String value) {
                  bPlace = value;
                },
                labelText: 'Birth place',
                textInputAction: TextInputAction.next,
                focusNode: _bPlaceFocus,
                onFieldSubmitted: (term) {
                  _fieldFocusChange(context, _bPlaceFocus, _bTimeFocus);
                },
              ),
              MyTextFormField(
                textEditingController: _bTimeController,
                keyboardType: TextInputType.text,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Birth time is required';
                  }
                  return null;
                },
                onSaved: (String value) {
                  bTime = value;
                },
                labelText: 'Birth time',
                textInputAction: TextInputAction.done,
                focusNode: _bTimeFocus,
                onFieldSubmitted: (term) {
                  _bTimeFocus.unfocus();
                },
              ),
            ],
          ),
        ),
        buttons: [
          DialogButton(
            child: Text(
              'Submit',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              if (!_bDayFormKey.currentState.validate()) {
                return;
              }
              _bDayFormKey.currentState.save();
              Navigator.of(context).pop();
            },
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFF19769F),
                Color(0xFF35D6A6),
              ],
            ),
          )
        ]).show();
  }

  _dateFlicker() async {
    DateTime _dateTime = await showRoundedDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 70),
        lastDate: DateTime(DateTime.now().year + 70),
        borderRadius: 16,
        theme: ThemeData.dark());
    setState(() {
      _date = DateFormat.yMMMMd().format(_dateTime);
    });
  }

  Widget _fullName() {
    return MyTextFormField(
      textEditingController: _fullNameController,
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return ' Name is required';
        }
        return null;
      },
      onSaved: (String value) {
        fullName = value;
      },
      labelText: 'Full Name',
      textInputAction: TextInputAction.next,
      focusNode: _fullNameFocus,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _fullNameFocus, _userNameFocus);
      },
      onTap: () async {
        FocusScope.of(context).requestFocus(new FocusNode());
        await _fullNameAlert();
        setState(() {
          _fullNameController.text = _firstNameController.text +
              ' ' +
              _middleNameController.text +
              ' ' +
              _lastNameController.text;
        });
      },
    );
  }

  Widget _userName() {
    return MyTextFormField(
      textEditingController: _userNameController,
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'User Name is required';
        }
        return null;
      },
      onSaved: (String value) {
        userName = value;
      },
      labelText: 'User Name',
      textInputAction: TextInputAction.next,
      focusNode: _userNameFocus,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _userNameFocus, _emailFocus);
      },
      onTap: () async {
        FocusScope.of(context).requestFocus(new FocusNode());
        await _userNameAlert();
      },
    );
  }

  Widget _buildPassword() {
    return Row(children: <Widget>[
      Expanded(
        child: MyTextFormField(
          textEditingController: _passwordController,
          isPassword: true,
          keyboardType: TextInputType.visiblePassword,
          labelText: 'Password',
          validator: (String value) {
            Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
            RegExp regex = new RegExp(pattern);
            print(value);
            if (value.isEmpty) {
              return 'Please enter password';
            } else {
              if (!regex.hasMatch(value))
                return 'Enter valid password';
              else
                return null;
            }
          },
          onSaved: (String value) {
            password = value;
          },
          focusNode: _passwordFocus,
          onFieldSubmitted: (term) {
            _fieldFocusChange(context, _passwordFocus, _addressFocus);
          },
          onTap: () async {
            FocusScope.of(context).requestFocus(new FocusNode());
            await _passwordAlert();
          },
        ),
      ),
    ]);
  }

  Widget _buildBDay() {
    return Row(
      children: <Widget>[
        Expanded(
          child: MyTextFormField(
            textEditingController: _bDayController,
            validator: (String value) {
              if (value.isEmpty) {
                return 'Birth Date is required';
              }
              return null;
            },
            onSaved: (String value) {
              bDate = value;
            },
            labelText: 'Date Of Birth',
            hintText: '1995/05/29',
            onTap: () async {
              FocusScope.of(context).requestFocus(new FocusNode());
              _bDayAlert();
              setState(() {
                _bDayController.text = _date;
              });
            },
            focusNode: _bDayFocus,
            onFieldSubmitted: (term) {
              _fieldFocusChange(context, _bDayFocus, _phoneNumberFocus);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAddress() {
    return Row(children: <Widget>[
      Expanded(
        child: MyTextFormField(
          textEditingController: _addressController,
          keyboardType: TextInputType.text,
          labelText: 'Address',
          validator: (String value) {
            if (value.isEmpty) {
              return 'Address is required';
            }
            return null;
          },
          focusNode: _addressFocus,
          onFieldSubmitted: (term) {
            _fieldFocusChange(context, _addressFocus, _bDayFocus);
          },
          onTap: () async {
            FocusScope.of(context).requestFocus(new FocusNode());
            await _addressAlert();
            setState(() {
              _addressController.text = _lineOneController.text +
                  ',' +
                  _lineTwoController.text +
                  ',' +
                  _cityController.text;
            });
          },
          onSaved: (String value) {
            address = value;
          },
        ),
      ),
    ]);
  }

  _buildNIC() {
    return MyTextFormField(
      labelText: 'NIC number',
      validator: (String value) {
        if (value.isEmpty) {
          return 'NIC is required';
        }
        return null;
      },
      onSaved: (String value) {
        nic = value;
      },
      textEditingController: _nicController,
      focusNode: _nicFocus,
      onFieldSubmitted: (term) {
        _fieldFocusChange(context, _nicFocus, _phoneNumberFocus);
      },
    );
  }

  _buildPNumber() {
    return MyTextFormField(
      textEditingController: _phoneNumberController,
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone Number is required';
        }
        if (value.length != 10) {
          return 'Unvalid Phone number';
        }
        return null;
      },
      onSaved: (String value) {
        phoneNumber = value;
      },
      labelText: 'Phone Number',
      hintText: '07xxxxxxxx',
      textInputAction: TextInputAction.next,
      focusNode: _phoneNumberFocus,
      onFieldSubmitted: (term) {
        _phoneNumberFocus.unfocus();
      },
    );
  }

  upload() async {
    String url = 'https://scaf.lk:610/api/Auth/register';

    FormData formData = FormData.fromMap({
      'DateOfBirth': bDate,
      'NationId': nic,
      'FirstName': firstName,
      'LastName': lastName,
      'MiddleName': middleName,
      'SurName': sirName,
      'City': city,
      'District': district,
      'Address': address,
      'BirthPlace': bPlace,
      'BirthTime': bTime,
      'UserName': userName,
      'Password': password,
      'Email': email,
      'PhoneNumber': phoneNumber,
    });
    try {
      Response response = await dio.post(url,
          data: formData,
          options: Options(headers: {
            'accept': "*/*",
            "Content-Type": "multipart/form-data"
          }));
    } on DioError catch (e) {
      print(e.error);
      print(e.response.data);
      return Alert(
          context: context,
          title: 'Error',
          content: Text(e.response.data),
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

      //   eMassage = await e.response.data;
    }
    return Alert(
        context: context,
        title: '',
        content: Text('SignUp Success'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf5f5f5),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: Text('Sign Up',
                  style: TextStyle(
                      color: Color(0xFF19769F),
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 10.0),
            _fullName(),
            _userName(),
            _buildPassword(),
            _buildAddress(),
            _buildBDay(),
            _buildNIC(),
            _buildPNumber(),
            SizedBox(height: 10.0),
            MyRaisedButton(
              roundedBorde: true,
              label: 'Sign Up',
              textColor: Colors.white,
              onPressed: () async {
                if (!_formKey.currentState.validate()) {
                  return;
                }
                _formKey.currentState.save();
                print(firstName);
                print(middleName);
                print(lastName);
                print(sirName);
                print(userName);
                print(email);
                print(password);
                print(address);
                print(city);
                print(district);
                print(_date);
                print(bPlace);
                print(bTime);
                print(nic);
                print(phoneNumber);
                await upload();
              },
            ),
          ]),
        ),
      ),
    );
  }
}
