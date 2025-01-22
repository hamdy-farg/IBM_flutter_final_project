import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/widgets/custem_text_widget.dart';

class CustemButtonAuthentication extends StatelessWidget {
  final String? text;
  final double? height;
  final double? width;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;

  const CustemButtonAuthentication(
      {super.key,
      this.text,
      this.onPressed,
      this.height,
      this.width,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      splashColor: Colors.transparent,
      onPressed: onPressed,
      child: Container(
        width: width ?? 271.w,
        height: height ?? 58.h,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorsManager.mainPurble,
                ColorsManager.mainPurble,
                ColorsManager.mainPurbleGradient,
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(15.sp))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(),
            CustemText(
              text: text ?? 'Sign in',
              textStyle: textStyle ?? TextStyles.font20WhiteBold,
            ),
            Container(
              width: 25.w,
              height: 25.w,
              child: const Icon(
                Icons.arrow_forward_rounded,
                color: ColorsManager.mainWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
