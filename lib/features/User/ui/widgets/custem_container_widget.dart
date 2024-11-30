import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/features/User/ui/widgets/custem_user_row.dart';

class CustemContainerWidget extends StatelessWidget {
  const CustemContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.w,
      height: 420.h,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
        color: ColorsManager.mainWhite,
        border: Border.all(
          color: ColorsManager.mainGrey,
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 20.w, vertical: 16.h), // Adjust padding
        child: Column(
          children: [
            const CustemUserRow(), // Default row
            SizedBox(height: 25.h), // Vertical space
            const CustemUserRow(
              text: 'Settings',
              image: 'assets/images/settings.png',
            ),
            SizedBox(height: 25.h),
            const CustemUserRow(
              text: 'Change password',
              image: 'assets/images/loack.png',
            ),
            SizedBox(height: 25.h),
            const CustemUserRow(
              text: 'About',
              image: 'assets/images/about.png',
            ),
          ],
        ),
      ),
    );
  }
}
