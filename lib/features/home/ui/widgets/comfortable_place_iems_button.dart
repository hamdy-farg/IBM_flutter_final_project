// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/widgets/custem_text_widget.dart';

class ComfortablePlaceIemsButton extends StatelessWidget {
  final double? buttonHight;
  final double? buttonWidth;
  final String? text;
  final bool? hasIcon;
  final void Function()? onTap;
  final MainAxisAlignment? mainAxisAlignment;

  const ComfortablePlaceIemsButton({
    Key? key,
    this.buttonHight,
    this.buttonWidth,
    this.text = "",
    this.hasIcon = true,
    this.mainAxisAlignment,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: buttonWidth?.w ?? 115.w,
        height: buttonHight?.h ?? 28.h,
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
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceEvenly,
          children: [
            CustemText(
              text: text,
              textStyle: TextStyles.font15WhiteBold,
            ),
            hasIcon!
                ? Container(
                    width: 12.73.w,
                    height: 14.48.h,
                    decoration: const BoxDecoration(
                        color: Color(0xFF3D56F0),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      color: ColorsManager.mainWhite,
                      size: 12,
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
