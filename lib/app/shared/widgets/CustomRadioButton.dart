import 'package:flutter/material.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/utils/font_style.dart';

class CustomRadioButton<T> extends StatelessWidget {
  final String label;
  final String primaryTitle;
  final String secondyTitle;
  final dynamic primaryValue;
  final dynamic secondyValue;
  final dynamic groupValue;
  final Function(T) primaryOnChanged;
  final Function(T) secondyOnChanged;
  final Color activeColor;
  final double width;

  const CustomRadioButton({
    this.label,
    @required this.primaryTitle,
    @required this.secondyTitle,
    @required this.primaryValue,
    @required this.secondyValue,
    @required this.groupValue,
    this.primaryOnChanged,
    this.secondyOnChanged,
    this.activeColor,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        this.label != null
            ? Text(
                this.label,
                style: kLabelTitleStyle,
              )
            : Container(),
        Container(
          alignment: AlignmentDirectional.centerStart,
          width: this.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Theme(
                data: ThemeData(unselectedWidgetColor: Colors.black26),
                child: RadioListTile<T>(
                  dense: true,
                  activeColor:
                      this.activeColor ?? DefaultColors.secondarySmooth,
                  title: Text(this.primaryTitle, style: kLabelStyle),
                  selected: this.groupValue == this.primaryValue ? true : false,
                  value: this.primaryValue,
                  groupValue: this.groupValue,
                  onChanged: this.primaryOnChanged,
                ),
              ),
              Theme(
                data: ThemeData(unselectedWidgetColor: Colors.black26),
                child: RadioListTile<T>(
                  dense: true,
                  activeColor:
                      this.activeColor ?? DefaultColors.secondarySmooth,
                  title: Text(this.secondyTitle, style: kLabelStyle),
                  selected: this.groupValue == this.secondyValue ? true : false,
                  value: this.secondyValue,
                  groupValue: this.groupValue,
                  onChanged: this.secondyOnChanged,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
