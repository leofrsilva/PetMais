import 'package:flutter/material.dart';
// import 'package:modulo_login/app/modules/auth/utils/StylesTexts.dart';

class CustomDropdownButton extends StatelessWidget {
  final double height;
  final List<DropdownMenuItem<String>> items;
  final String value;
  final Function(String) onChanged;
  final String label;
  final Color color;
  final IconData icon;
  final String hint;
  final Function(String) onSaved;
  final String Function(String) validator;
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
          //style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          //decoration: kBoxDecorationStyle,
          height: this.height,
          child: DropdownButtonFormField<String>(
            items: this.items,
            value: this.value,
            onChanged: this.onChanged,
            onSaved: this.onSaved,
            validator: this.validator,
            hint: Text(this.hint),            
            style: TextStyle(
              color: this.color,
              fontFamily: "OpenSans",
              fontWeight: FontWeight.bold,
            ),
            icon: Icon(Icons.arrow_drop_down, color: Colors.white),
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