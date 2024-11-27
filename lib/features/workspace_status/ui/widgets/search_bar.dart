import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchingBar extends StatelessWidget {
  const SearchingBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: Container(
        width: double.infinity.w, // Full width of the screen

        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none, // Remove underline
            hintText: "Search...",
            prefixIcon: SvgPicture.asset(
              'assets/svgs/search.svg',
              width: 5.w,
              height: 5.h,
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.h), // Padding for text
          ),
        ),
      ),
    );
  }
}
