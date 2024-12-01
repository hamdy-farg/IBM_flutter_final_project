import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/widgets/custem_text_widget.dart';

class ComfortablePlaceIemsButton extends StatelessWidget {
  const ComfortablePlaceIemsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      splashColor: Colors.transparent,
      onPressed: () {},
      child: Container(
        width: 115.w,
        height: 28.h,
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
            horizantalSpace(10),
            CustemText(
              text: 'Book!',
              textStyle: TextStyles.font15WhiteBold,
            ),
            Container(
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
            ),
          ],
        ),
      ),
    );
  }
}
