import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/User/ui/widgets/icon_button_widget.dart';

class CustemTextfieldHome extends StatelessWidget {
  const CustemTextfieldHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButtonWidget(
          icon: Icon(
            Icons.search_sharp,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            style: const TextStyle(color: ColorsManager.mainWhite),
            decoration: InputDecoration(
              hintText: "Search....",
              hintStyle: TextStyles.font18WhiteBold,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
