import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petmais/app/shared/utils/colors.dart';
import 'package:petmais/app/shared/utils/font_style.dart';

class CustomTextField extends StatelessWidget {
  final double height;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onChanged;
  final String label;
  final Color color;
  final TextInputType textInputType;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter> inputFormatters;
  final TextInputAction textInputAction;
  final Function(String) onFieldSubmitted;
  final Function onTap;
  final IconData icon;
  final String hint;
  final bool readOnly;
  final bool isPass;
  final bool isDense;
  final Function onPressedVisiblePass;
  final Function(String) onSaved;
  final String Function(String) validator;
  final EdgeInsetsGeometry contentPadding;
  final Widget sufixIcon;
  final int numLines;
  final int maxCaracteres;

  const CustomTextField({
    this.controller,
    this.focusNode,
    this.icon,
    this.sufixIcon,
    @required this.label,
    this.onChanged,
    this.hint,
    this.textInputType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.textInputAction,
    this.onFieldSubmitted,
    this.onTap,
    this.color = Colors.black26,
    this.readOnly = false,
    this.isPass = false,
    this.isDense,
    this.onPressedVisiblePass,
    this.onSaved,
    this.validator,
    this.contentPadding = const EdgeInsets.only(top: 15.0, bottom: 5.0),
    this.numLines,
    this.maxCaracteres,
    @required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          this.label,
          style: kLabelTitleStyle,
        ),
        Container(
          alignment: Alignment.center,
          height: this.height,
          child: TextFormField(
            onTap: this.onTap,
            readOnly: this.readOnly,
            obscureText: this.isPass,
            onChanged: this.onChanged,
            focusNode: this.focusNode,
            controller: this.controller,
            inputFormatters: this.inputFormatters,
            keyboardType: this.textInputType,
            textCapitalization: this.textCapitalization,
            textInputAction: this.textInputAction,
            onFieldSubmitted: this.onFieldSubmitted,
            cursorColor: Colors.grey,
            onSaved: this.onSaved,
            validator: this.validator,
            maxLines: this.numLines ?? 1,
            maxLength: this.maxCaracteres,

            style: TextStyle(
              color: DefaultColors.secondarySmooth ?? this.color,
              fontFamily: "Changa",
            ),
            decoration: InputDecoration(
              isDense: this.isDense,
              border: this.numLines != null
                  ? OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]),
                    )
                  : UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]),
                    ),
              focusedBorder: this.numLines != null
                  ? OutlineInputBorder(
                      borderSide: BorderSide(color: DefaultColors.secondary),
                    )
                  : UnderlineInputBorder(
                      borderSide: BorderSide(color: DefaultColors.secondary),
                    ),
              contentPadding: this.contentPadding,
              prefixIcon: this.icon != null
                  ? Icon(
                      this.icon,
                      color: this.color,
                    )
                  : null,
              hintText: this.hint,
              hintStyle: kHintTextStyle,
              suffix: this.sufixIcon,
              suffixIcon: this.onPressedVisiblePass != null
                  ? IconButton(
                      onPressed: this.onPressedVisiblePass,
                      icon: Icon(
                        isPass == true
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      color: this.color,
                    )
                  : null,
            ),
          ),
        ),
      ],
    );
  }
}
