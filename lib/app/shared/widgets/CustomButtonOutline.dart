import 'package:flutter/material.dart';
import 'package:petmais/app/shared/utils/colors.dart';

class CustomButtonOutline extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color corText;
  final double elevation;
  final double width;
  final double height;
  final double paddingRaised;
  final BoxDecoration decoration;

  const CustomButtonOutline({
    @required this.onPressed,
    @required this.text,
    this.corText,
    this.elevation = 5.0,
    this.width = double.infinity,
    this.height,
    this.paddingRaised = 7.5,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: this.width,
      height: this.height,
      child: Material(
        elevation: 0.0,
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: this.onPressed,
          child: Container(
            width: this.width,
            alignment: Alignment.center,
            padding: EdgeInsets.all(this.paddingRaised),
      decoration: this.decoration,
            // decoration: ,
            child: Text(
              this.text,
              style: TextStyle(
                color: this.corText ?? DefaultColors.secondary,
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: "RussoOne",
              ),
            ),
          ),
        ),
      ),
    );
  }
}