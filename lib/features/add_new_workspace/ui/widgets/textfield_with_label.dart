import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';

class TextFormFieldWithLabel extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final Color? backgroundColor;
  final String? hintText;
  final String? label;
  final bool? obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? minLines;
  final int? maxLines;
  final TextEditingController? controller;  // Added controller
  final String? Function(String?)? validator; // Added validator

  const TextFormFieldWithLabel({
    super.key,
    this.backgroundColor,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintText,
    this.obscureText,
    this.suffixIcon,
    this.prefixIcon,
    this.hintStyle,
    this.label,
    this.minLines,
    this.maxLines,
    this.controller,    // Added controller
    this.validator,     // Added validator
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Center(
            child: Text(
              label ?? "Enter text",
              style: TextStyles.font22blackMeduim,
            ),
          ),
          verticalSpace(5.h),
          TextFormField(
            controller: controller,  // Assign controller to TextFormField
            minLines: minLines,
            maxLines: maxLines,
            obscureText: obscureText ?? false,
            style: inputTextStyle,
            decoration: InputDecoration(
              filled: true,
              fillColor: backgroundColor ?? Colors.white,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              hintText: hintText,
              hintStyle: hintStyle ?? TextStyles.font15GreyBold,
              isDense: true,
              contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
              focusedBorder: focusedBorder ?? OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: ColorsManager.mainBlue, width: 1.3),
              ),
              enabledBorder: enabledBorder ?? OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: ColorsManager.semiWhite, width: 1.3),
              ),
            ),
            validator: validator,  // Assign validator to TextFormField
          ),
        ],
      ),
    );
  }
}
