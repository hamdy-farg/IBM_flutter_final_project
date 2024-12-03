import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 
class roomPhoto extends StatelessWidget {
  const roomPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity.w,
      height: 250.h, // Responsive height
      decoration: const BoxDecoration(
         image: DecorationImage(
          image: AssetImage("assets/images/most_reservation.png"),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
