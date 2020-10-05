import 'package:flutter/material.dart';
import 'package:petmais/app/shared/utils/font_style.dart';

class CustomFlatButtonAuth extends StatelessWidget {
  final AlignmentGeometry align;
  final String text;
  final Function onPressed;

  const CustomFlatButtonAuth({
    @required this.align,
    @required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: this.align,
      child: FlatButton(
        // visualDensity: VisualDensity(vertical: VisualDensity.minimumDensity),
        onPressed: this.onPressed,
        padding: const EdgeInsets.only(right: 0.0),
        child: Text(
          this.text,
          style: kLabelStyle,
        ),
      ),
    );
  }
}
