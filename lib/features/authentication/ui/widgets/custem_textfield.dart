import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';

class CustemTextfield extends StatelessWidget {
  final String? text;
  final Icon? icon;
  final Icon? suffixIcon;
  final TextInputType? textInputType;
  final bool? obscuredText;
  final TextEditingController? textEditingController;
  final String? Function(String?) Validator;

  const CustemTextfield(
      {super.key,
      this.text,
      this.icon,
      this.textInputType,
      this.suffixIcon,
      this.obscuredText,
      required this.Validator,
      this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      obscureText: obscuredText ?? false,
      keyboardType: textInputType ?? TextInputType.emailAddress,
      validator: Validator,
      decoration: InputDecoration(
          fillColor: ColorsManager.mainGrey,
          hintText: text ?? 'abc@email.com',
          prefixIcon: icon ?? Icon(Icons.mail_outlined),
          suffixIcon: suffixIcon ?? null,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)))),
    );
  }
}
