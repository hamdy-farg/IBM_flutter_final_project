import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserImage extends StatelessWidget {
  final String? image;

  const UserImage({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(26)),
      child: Container(
          height: 132.h,
          width: 132.w,
          child: Image.asset(
            image ?? 'assets/images/user profile image.jpg',
            fit: BoxFit.cover,
          )),
    );
  }
}
