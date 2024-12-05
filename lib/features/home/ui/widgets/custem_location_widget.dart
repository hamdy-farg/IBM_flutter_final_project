import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';

class CustemLocationWidget extends StatelessWidget {
  String fullName;
  CustemLocationWidget({required this.fullName, super.key});

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
            '${fullName}',
            style: TextStyles.font15WhiteRegular,
          ),
        ],
      ),
    );
  }
}
