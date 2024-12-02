import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';

class WorkSpaceText extends StatelessWidget {
  const WorkSpaceText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20)
          .w, // Add padding around the row
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left text
          Text("Work Spaces", style: TextStyles.font24Black5Meduim),
          // Right text and icon
          Row(
            children: [
              Text("See All", style: TextStyles.font18GreyMeduim),
              Icon(
                Icons.arrow_right,
                color: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
