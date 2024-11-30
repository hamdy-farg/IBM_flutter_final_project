import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';

class AppBarTop extends StatelessWidget {
  const AppBarTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF4B3FFF),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.filter_list,
                  color: ColorsManager.mainWhite,
                  size: 40,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Current Location',
                          style: TextStyles.font18WhiteBold,
                        ),
                        const Icon(
                          Icons.arrow_drop_down_outlined,
                          color: ColorsManager.mainWhite,
                        )
                      ],
                    ),
                    Text(
                      'New York, USA',
                      style: TextStyles.font20WhiteBold,
                    ),
                  ],
                ),
                const Icon(
                  Icons.circle_notifications_outlined,
                  color: ColorsManager.mainWhite,
                  size: 40,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            Row(
              children: [
                Icon(
                  Icons.search_sharp,
                  color: Colors.white.withOpacity(0.7),
                  size: 30,
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 30,
                  width: 100,
                  child: TextField(
                    style: const TextStyle(color: ColorsManager.mainWhite),
                    decoration: InputDecoration(
                      hintText: "Search....",
                      hintStyle: TextStyles.font18WhiteBold,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
