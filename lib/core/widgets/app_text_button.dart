import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
 
class AppTextButton extends StatelessWidget {
  AppTextButton(
      {super.key,
      this.backgroundColor,
      this.horizontalPadding,
      this.verticalPadding,
      this.buttonHeight,
      this.buttonWidth,
      this.onPress,
      this.buttonText,
      this.buttonStyle});
  final Color? backgroundColor;
  final double? verticalPadding;
  final double? horizontalPadding;
  final double? buttonHeight;
  final double? buttonWidth;
  final VoidCallback? onPress;
  final String? buttonText;
  final TextStyle? buttonStyle;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
                backgroundColor ?? ColorsManager.mainBlue),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.symmetric(
                  horizontal: horizontalPadding?.w ?? 12.w,
                  vertical: verticalPadding?.h ?? 14.h),
            ),
            fixedSize: MaterialStateProperty.all(
                Size(buttonWidth ?? double.maxFinite, buttonHeight ?? 50.h))),
        onPressed: onPress,
        child: Text(
          buttonText??"Click Me ",
          style: buttonStyle,
        ));
  }
}
