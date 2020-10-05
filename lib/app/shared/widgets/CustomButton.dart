import 'package:flutter/material.dart';
import 'package:petmais/app/shared/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color corText;
  final double elevation;
  final double width;
  final double height;
  final double paddingRaised;
  final BoxDecoration decoration;
  final bool isLoading;

  const CustomButton({
    @required this.onPressed,
    @required this.text,
    this.corText,
    this.elevation = 5.0,
    this.width = double.infinity,
    this.height,
    this.paddingRaised = 10,
    this.decoration,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeIn,
      alignment: Alignment.center,
      decoration: this.decoration,
      width: this.isLoading ? 50 : this.width,
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
            margin: EdgeInsets.all(this.paddingRaised),
            child: AnimatedCrossFade(
              duration: Duration(milliseconds: 100),
              firstCurve: Curves.easeInQuart,
              secondCurve: Curves.easeOutQuart,
              firstChild: Container(
                height: 20, width: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    this.corText ?? DefaultColors.primary,
                  ),
                ),
              ),
              secondChild: Text(
                this.text,
                style: TextStyle(
                  color: this.corText ?? DefaultColors.primary,
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "RussoOne",
                ),
              ),
              crossFadeState: isLoading
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            ),
          ),
        ),
      ),
    );
  }
}
