import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';

class CustemLocationWidget extends StatelessWidget {
  const CustemLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      splashColor: Colors.transparent,
      onPressed: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome',
            style: TextStyles.font20WhiteBold,
          ),
          Text(
            'Yousef',
            style: TextStyles.font15WhiteRegular,
          ),
        ],
      ),
    );
  }
}
