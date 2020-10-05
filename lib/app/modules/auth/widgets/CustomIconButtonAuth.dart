import 'package:flutter/material.dart';

class CustomIconButtonAuth extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final Color cor;

  const CustomIconButtonAuth({this.onPressed, this.icon, this.cor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPressed,
      child: Container(
        height: 40.0,
        width: 40.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Icon(
          this.icon,
          color: this.cor,
        ),
      ),
    );
  }
}
