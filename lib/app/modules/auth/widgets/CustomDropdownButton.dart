import 'package:flutter/material.dart';
import 'package:petmais/app/shared/utils/font_style.dart';
// import 'package:modulo_login/app/modules/auth/utils/StylesTexts.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  final double height;
  final List<DropdownMenuItem<T>> items;
  final T value;
  final Function(T) onChanged;
  final String label;
  final Color color;
  final IconData icon;
  final String hint;
  final Function(T) onSaved;
  final String Function(T) validator;
  final EdgeInsetsGeometry contentPadding;
  final Widget sufixIcon;

  const CustomDropdownButton({
    this.icon,
    this.sufixIcon,
    @required this.items,
    @required this.value,
    @required this.label,
    @required this.onChanged,
    this.height,
    this.hint,
    this.color = Colors.black26,
    this.onSaved,
    this.validator,
    this.contentPadding = const EdgeInsets.only(top: 15.0),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          this.label,
          style: kLabelTitleStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          //decoration: kBoxDecorationStyle,
          height: this.height,
          child: DropdownButtonFormField<T>(
            items: this.items,
            value: this.value,
            onChanged: this.onChanged,
            onSaved: this.onSaved,
            validator: this.validator,
            hint: this.hint != null
                ? Text(
                    this.hint,
                    style: TextStyle(color: Colors.black26),
                  )
                : null,
            style: TextStyle(
              color: this.color,
              fontFamily: "OpenSans",
              fontWeight: FontWeight.bold,
            ),
            icon: Icon(Icons.arrow_drop_down, color: Colors.black26),
            decoration: InputDecoration(
              fillColor: Colors.blue,
              border: InputBorder.none,
              contentPadding: this.contentPadding,
              prefixIcon: this.icon != null
                  ? Icon(
                      this.icon,
                      color: this.color,
                    )
                  : null,
              hintText: this.hint,
              // hintStyle: kHintTextStyle,
              suffix: this.sufixIcon,
            ),
          ),
        ),
      ],
    );
  }
}
