import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
              width: 55.5.w,
              height: 55.5.h,
              child: SvgPicture.asset('assets/svgs/Logo.svg')),
          verticalSpace(10),
          Text('EventHub', style: TextStyles.font35BlackMeduim),
        ],
      ),
    );
  }
}
