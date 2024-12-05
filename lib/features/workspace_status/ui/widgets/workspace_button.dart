import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';

class WorkspaceButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const WorkspaceButton({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        backgroundColor:
            isActive ? ColorsManager.mainBlue : ColorsManager.Inactive,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.sp,
          color: isActive ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
