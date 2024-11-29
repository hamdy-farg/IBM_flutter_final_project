import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/features/User/ui/widgets/user_image.dart';

class ImgePickerWidget extends StatelessWidget {
  const ImgePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      splashColor: Colors.transparent,
      onPressed: () {},
      child: Stack(
        children: [
          UserImage(),
          Positioned(
            top: 80.sp,
            left: 80.sp,
            child: Container(
              width: 47.w,
              height: 47.h,
              decoration: BoxDecoration(
                  color: ColorsManager.userGrey2,
                  borderRadius: BorderRadius.all(Radius.circular(11))),
              child: Image.asset('assets/images/photo-camera.png'),
            ),
          ),
        ],
      ),
    );
  }
}
