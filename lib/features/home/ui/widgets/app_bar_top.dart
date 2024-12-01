import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/User/ui/widgets/icon_button_widget.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/custem_location_widget.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/custem_textfield_home.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/svg_button.dart';

class AppBarTop extends StatelessWidget {
  const AppBarTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.w,
      height: 181.h,
      decoration: const BoxDecoration(
        color: ColorsManager.mainBlue,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(33),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgButton(),
              CustemLocationWidget(),
              SvgButton(
                svgImage: 'assets/svgs/nottfication.svg',
              ),
            ],
          ),
          SizedBox(height: 20),
          CustemTextfieldHome(),
        ],
      ),
    );
  }
}
