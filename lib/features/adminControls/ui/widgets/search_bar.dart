import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBarTop extends StatelessWidget {
  const SearchBarTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
       
        child: Container(
          width: 358.w,
          height: 48.h,
          decoration: BoxDecoration(
            color: Colors.grey[200], // Background color for the search bar
            borderRadius: BorderRadius.circular(20), // Rounded corners
          ),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'what you need?',
              prefixIcon: Icon(Icons.search, color: Colors.grey), // Search icon
              contentPadding: EdgeInsets.symmetric(vertical: 12), // Vertical padding
            ),
          ),
        ),
           
    ) ;
  }
}