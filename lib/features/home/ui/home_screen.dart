import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/features/home/ui/app_bar_top.dart';
import 'package:ibm_flutter_final_project/features/home/ui/rooms_cards.dart';
import 'package:ibm_flutter_final_project/features/home/ui/rooms_text.dart';
import 'package:ibm_flutter_final_project/features/home/ui/work_space_text.dart';
import 'package:ibm_flutter_final_project/features/home/ui/work_spaces.dart';






class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       bottomNavigationBar: BottomNavigationBar(
       iconSize: 35,
        
        selectedItemColor: Colors.blue, // Highlight color for selected tab
        unselectedItemColor: Colors.grey, // Color for unselected tabs
        items: [
         
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Booked',
          ),
        ],
      ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
                padding:  EdgeInsets.only(
                    top: 5.h,
                    bottom: 5.h
                    ),
                child: Column(
                    children: [
                    SizedBox(
                    height: 200,
                    width: double.infinity,
                            // this is the screen that carry the first part of first screen that is  top blue container 
                            child: AppBarTop()
                            ),
                           // this is the text row 
                            SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: WorkSpaceText()),
                     // that is the listview photos for workspaces

                     SizedBox(
                        height: 210,
                       
                        child: WorkSpaces(),
                    ),

                    // this is the row for rooms near by user

                     SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: RoomsText()),

                                SizedBox(
                                height: 500,
                                width: double.infinity,
                                child: RoomsCards(),
                                ),
                             
                               
                    ],
                ),
              ),
          ),
        ),
        
    );
  }
}