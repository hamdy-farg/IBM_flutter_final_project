import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/app_bar_top.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/rooms_cards.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/rooms_text.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/work_space_text.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/work_spaces.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 35.sp,
        selectedItemColor: Colors.blue, // Highlight color for selected tab
        unselectedItemColor: Colors.grey, // Color for unselected tabs
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Booked',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBarTop(),
              verticalSpace(10),
              WorkSpaceText(),
              // that is the listview photos for workspaces
              WorkSpaces(),
              // this is the row for rooms near by user
              const RoomsText(),
              RoomsCards(),
            ],
          ),
        ),
      ),
    );
  }
}
