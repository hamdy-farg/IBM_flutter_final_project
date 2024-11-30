import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/authentication/ui/widgets/custem_text_widget.dart';

class CustemUserRow extends StatelessWidget {
  final String? text;
  final String? image;
  final VoidCallback? onPressed;

  const CustemUserRow({super.key, this.text, this.image, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.amber,
      onTap: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Adjusts spacing
        crossAxisAlignment: CrossAxisAlignment.center, // Aligns vertically
        children: [
          Container(
            width: 50.w,
            height: 50.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: ColorsManager.userGrey2,
            ),
            child: SizedBox(
              height: 24.h,
              width: 24.w,
              child: Image.asset(image ?? 'assets/images/authinticatin.png'),
            ),
          ),
          SizedBox(width: 16.w), // Space between image and text
          Expanded(
            child: CustemText(
              text: text ?? 'Verification',
              textStyle: TextStyles.font24Black5Meduim,
            ),
          ),
          Icon(Icons.arrow_forward_ios_rounded,
              size: 16.h), // Right-aligned icon
        ],
      ),
    );
  }
}
