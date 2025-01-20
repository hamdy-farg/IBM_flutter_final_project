import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';

class ClientBookingScreen extends StatelessWidget {
  const ClientBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      width: double.infinity,
      child: Column(
        children: [
          verticalSpace(20.h),
          Text(
            "Your Booking",
            style: TextStyles.font22BlackBold,
          ),
          verticalSpace(40.h),
          
        ],
      ),
    ));
  }
}
