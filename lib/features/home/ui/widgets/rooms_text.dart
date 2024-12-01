import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/User/ui/widgets/icon_button_widget.dart';

class RoomsText extends StatelessWidget {
  const RoomsText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 16.0), // Add padding if needed
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Rooms Near by You", style: TextStyles.font22BlackSemiBold),
          MaterialButton(
            onPressed: () {},
            child: Row(
              children: [
                Text("See All", style: TextStyles.font18GreyMeduim),
                Icon(
                  Icons.arrow_right,
                  color: ColorsManager.lightGrey,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
