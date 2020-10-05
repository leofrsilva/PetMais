import 'package:flutter/material.dart';

class ProgressHighlighterPage extends StatelessWidget {
  final bool isNow;

  ProgressHighlighterPage(this.isNow);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.isNow ? 7 : 5,
      width: 75,
      margin: const EdgeInsets.symmetric(horizontal: 2.5),
      color: this.isNow ? Colors.black26 : Colors.black12,
    );
  }
}