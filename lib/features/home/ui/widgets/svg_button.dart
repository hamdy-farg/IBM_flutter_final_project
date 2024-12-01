import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgButton extends StatelessWidget {
  final String? svgImage;

  const SvgButton({super.key, this.svgImage});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      splashColor: Colors.transparent,
      onPressed: () {},
      child: SvgPicture.asset(svgImage ?? 'assets/svgs/Combined Shape 2.svg'),
    );
  }
}
