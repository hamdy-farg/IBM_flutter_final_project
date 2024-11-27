import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/widgets/custem_text_widget.dart';

class HyperText extends StatelessWidget {
  final String? text;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;

  const HyperText({super.key, this.text, this.textStyle, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: CustemText(
          text: text,
          textStyle: textStyle ?? TextStyles.font16Black400Wight,
        ));
  }
}
