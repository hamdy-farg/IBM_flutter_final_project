import 'package:flutter/material.dart';

class ColorChangingIcon extends StatefulWidget {
  _ColorChangingIconState createState() => _ColorChangingIconState();
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
    return IconButton(
      icon: Icon(Icons.bookmark),
      color: _iconColor, // Change icon color based on state
      onPressed: _changeColor, // Change color on tap
      iconSize: 26, // Optional: Set icon size
    );
  }
}