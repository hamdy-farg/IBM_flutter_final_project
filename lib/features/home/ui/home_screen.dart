import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/features/User/ui/User_screen.dart';
import 'package:ibm_flutter_final_project/features/adminControls/ui/booking_screen.dart';
import 'package:ibm_flutter_final_project/features/home/logic/homeCubit/home_cubit.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/app_bar_top.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/rooms_cards.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/rooms_text.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/work_space_text.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/work_spaces.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/logic/navigationBar/navigation_bar_cubit.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/logic/navigationBar/navigation_bar_state.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> navigationsScreens = [
      UserScreen(),
      HomeScreen(),
      BookingScreen(),
    ];

    final naviagtionCubit = getIt<NavigationBarCubit>();
    return Scaffold(
        bottomNavigationBar:
            BlocBuilder<NavigationBarCubit, NavigationBarState>(
          bloc: naviagtionCubit,
          builder: (context, state) {
            log("${state} log");

            return BottomNavigationBar(
              backgroundColor: Colors.white,
              onTap: (value) {
                naviagtionCubit.changeCurrentIndex(value);
              },
              currentIndex: naviagtionCubit.state.currentIndex,
              iconSize: 35.sp,
              selectedItemColor:
                  ColorsManager.mainBlue, // Highlight color for selected tab
              unselectedItemColor: Colors.grey, // Color for unselected tabs
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.explore),
                  label: 'Explore',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today),
                  label: 'Booked',
                ),
              ],
            );
          },
        ),
        body: SafeArea(
            child: BlocBuilder<NavigationBarCubit, NavigationBarState>(
                bloc: naviagtionCubit,
                builder: (context, state) {
                  return navigationsScreens[naviagtionCubit.state.currentIndex];
                })));
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppBarTop(),
          verticalSpace(10),
          WorkSpaceText(),
          // that is the listview photos for workspaces
          BlocBuilder<HomeWorkSpaceCubit, HomeWorkSpaceState>(
            bloc: getIt<HomeWorkSpaceCubit>(),
            builder: (context, state) {
              return (state is HomeWorkSpaceSuccesState)
                  ? WorkSpaces(workSpaceList: state.workSpaceModelList)
                  : (state is HomeWorkSpaceFialState)
                      ? Text("${state.errorMessage}")
                      : CircularProgressIndicator();
            },
          ),
          // this is the row for rooms near by user
          const RoomsText(),
          
          RoomsCards(),
        ],
      ),
    );
  }
}
