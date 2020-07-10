import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final Function validator;
  final Function onSaved;
  final TextInputType keyboardType;
  //keyboardType: TextInputType.number,
  final bool isPassword;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final Function onFieldSubmitted;
  final Function onTap;
  final TextEditingController textEditingController;

  MyTextFormField({
    this.hintText,
    this.labelText,
    this.validator,
    this.onSaved,
    this.keyboardType,
    this.isPassword = false,
    this.textInputAction,
    this.focusNode,
    this.onFieldSubmitted,
    this.onTap,
    this.textEditingController,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: TextFormField(
        controller: textEditingController,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          contentPadding: EdgeInsets.all(15.0),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF19769F), width: 2.0)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFEBEBEB), width: 2.0)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2.0)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF19769F), width: 2.0)),
        ),
        obscureText: isPassword ? true : false,
        validator: validator,
        onSaved: onSaved,
        keyboardType: keyboardType,
        onTap: onTap,
      ),
    );
  }
}
