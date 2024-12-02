import 'package:flutter/material.dart';

class CustemText extends StatelessWidget {
  final String? text;
  final TextStyle? textStyle;

  const CustemText({super.key, this.text, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      text ?? "place holder",
      style: textStyle,
    );
  }
}
