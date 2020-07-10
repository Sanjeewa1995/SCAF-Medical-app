import 'package:flutter/material.dart';

class MyRaisedButton extends StatelessWidget {
  final Function onPressed;
  final Color color;
  final Color textColor;
  final double size;
  final String label;
  final bool roundedBorde;

  MyRaisedButton({
    this.onPressed,
    this.color,
    this.textColor,
    this.size,
    this.label,
    this.roundedBorde = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size,
        height: 55.0,
        child: Card(
          elevation: 10.0,
          shape: RoundedRectangleBorder(
              borderRadius: roundedBorde
                  ? BorderRadius.circular(10.0)
                  : BorderRadius.circular(0.0)),
          child: RaisedButton(
            onPressed: onPressed,
            padding: const EdgeInsets.all(0.0),
            child: Container(
              margin: EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[
                      Color(0xFF19769F),
                      Color(0xFF35D6A6),
                    ],
                  ),
                  borderRadius: roundedBorde
                      ? BorderRadius.circular(10.0)
                      : BorderRadius.circular(0.0)),
              child: Center(
                child: Text(label, style: TextStyle(fontSize: 20)),
              ),
            ),
            color: color,
            textColor: textColor,
            shape: RoundedRectangleBorder(
                borderRadius: roundedBorde
                    ? BorderRadius.circular(10.0)
                    : BorderRadius.circular(0.0)),
          ),
        ),
      ),
    );
  }
}
