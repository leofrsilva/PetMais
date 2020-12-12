import 'package:flutter/material.dart';
import 'package:petmais/app/shared/utils/colors.dart';

class CustomButtonOutline extends StatelessWidget {
  final Function onPressed;
  final String text;
  final double fontsize;
  final Color corText;
  final double elevation;
  final double width;
  final double height;
  final double paddingRaised;
  final BoxDecoration decoration;
  final Icon icon;

  const CustomButtonOutline({
    @required this.onPressed,
    @required this.text,
    this.fontsize = 18.0,
    this.corText,
    this.elevation = 5.0,
    this.width = double.infinity,
    this.height,
    this.paddingRaised = 7.5,
    this.decoration,
    this.icon,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  this.text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: this.corText ?? DefaultColors.secondary,
                    letterSpacing: 1.5,
                    fontSize: this.fontsize,
                    fontWeight: FontWeight.bold,
                    fontFamily: "RussoOne",
                  ),
                ),
                if (icon != null) this.icon
              ],
            ),
          ),
        ),
      ),
    );
  }
}
