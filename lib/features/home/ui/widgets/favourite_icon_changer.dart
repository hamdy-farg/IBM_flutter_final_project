import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorChangingIcon extends StatefulWidget {
  _ColorChangingIconState createState() => _ColorChangingIconState();
  final double? size;

  const ColorChangingIcon({super.key, this.size});
}

class _ColorChangingIconState extends State<ColorChangingIcon> {
  Color _iconColor = Colors.grey; // Initial color of the icon

  void _changeColor() {
    setState(() {
      // Toggle between black and red color on tap
      _iconColor = (_iconColor == Colors.grey) ? Colors.red : Colors.grey;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _changeColor,
      child: Icon(
        Icons.bookmark_rounded,
        color: _iconColor,
        size: widget.size ?? 27.sp,
      ),
    );
  }
}
