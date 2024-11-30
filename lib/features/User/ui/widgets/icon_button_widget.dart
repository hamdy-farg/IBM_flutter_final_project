import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';

class IconButtonWidget extends StatelessWidget {
  final Icon? icon;
  final double? iconsize;
  final Color? color;
  final VoidCallback? onPressed;

  const IconButtonWidget(
      {super.key, this.icon, this.iconsize, this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {},
        icon: icon ??
            Icon(
              Icons.arrow_back,
              size: 23 ?? iconsize,
              color: ColorsManager.mainBlack ?? color,
            ));
  }
}
