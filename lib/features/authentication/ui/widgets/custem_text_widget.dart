import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustemText extends StatelessWidget {
  final String? text;
  final TextStyle? textStyle;

  const CustemText({super.key, this.text, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "place holder",
      style: textStyle,
    );
  }
}
