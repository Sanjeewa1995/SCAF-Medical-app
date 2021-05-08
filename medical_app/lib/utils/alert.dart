import 'package:flutter/material.dart';
import 'package:medical_app/custom_widget/buttons.dart';

import 'package:medical_app/custom_widget/text_field.dart';

class Alerts {
  static void _close(BuildContext context, {Function onCloseCallback}) {
    Navigator.of(context).pop();
    if (onCloseCallback != null) {
      onCloseCallback();
    }
  }

  static void showMessage(BuildContext context, String message,
      {String title = "Error",
      String button = "OK",
      Function onCloseCallback}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  topLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
            ),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Wrap(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(width: double.infinity),
                          Text(
                          title,
                          style:
                              TextStyle(color: Color(0xFF19769F), fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          message,
                          style: TextStyle(
                            color: Color(0xFF19769F),
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          height: 48.0,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            onPressed: () => _close(context,
                                onCloseCallback: onCloseCallback),
                            padding: EdgeInsets.all(12),
                            color: Color(0xFF19769F),
                            child: Text(
                              button,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
