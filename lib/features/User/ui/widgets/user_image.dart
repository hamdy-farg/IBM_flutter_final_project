import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserImage extends StatelessWidget {
  final String? image;

  const UserImage({super.key, this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(26)),
      child: SizedBox(
        height: 132.h,
        width: 132.w,
        child: Image.network(
          image ?? 'assets/images/user profile image.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
