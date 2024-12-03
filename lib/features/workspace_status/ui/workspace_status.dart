import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/extensions.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/helpers/utils.dart';
import 'package:ibm_flutter_final_project/core/routing/routes.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/core/widgets/app_text_button.dart';
import 'package:ibm_flutter_final_project/features/User/ui/User_screen.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/logic/workSpaceCubit/work_space_cubit.dart';
import 'package:ibm_flutter_final_project/features/add_new_workspace/logic/workSpaceCubit/work_space_state.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/logic/cubit/get_admin_work_spaces_cubit.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/logic/cubit/get_admin_work_spaces_state.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/logic/navigationBar/navigation_bar_cubit.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/logic/navigationBar/navigation_bar_state.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/ui/widgets/search_bar.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/ui/widgets/workspace_item.dart';

List<Widget> NavigationBarWidgets = [
  const UserScreen(),
  const ExploreScreen(),
  const SizedBox(),
];

class WorkspaceStatus extends StatelessWidget {
  const WorkspaceStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationBarCubit = getIt<NavigationBarCubit>();
    final newWorkSpaceCubit = getIt<WorkSpaceCubit>();

    return Scaffold(
      body: BlocBuilder<NavigationBarCubit, NavigationBarState>(
        bloc: navigationBarCubit,
        builder: (context, state) {
          return NavigationBarWidgets[navigationBarCubit.state.currentIndex];
        },
      ),
      floatingActionButton: BlocBuilder<NavigationBarCubit, NavigationBarState>(
        bloc: navigationBarCubit,
        builder: (context, state) {
          return state.currentIndex == 1
              ? AppTextButton(
                  buttonWidth: 120.w,
                  buttonText: "Add New ",
                  buttonStyle: TextStyles.font16WhiteBold,
                  onPress: () async {
                    newWorkSpaceCubit
                        .workSpaceStatusChange(WorkSpaceStatus.addNew);
                    newWorkSpaceCubit.clearAll();

                    context.pushNamed(Routes.addNewWorkSpace);
                  },
                )
              : const SizedBox();
        },
      ),
      bottomNavigationBar: BlocBuilder<NavigationBarCubit, NavigationBarState>(
          bloc: navigationBarCubit,
          builder: (context, state) {
            return BottomNavigationBar(
              currentIndex: navigationBarCubit.state.currentIndex,
              iconSize: 35,
              backgroundColor: Colors.white,
              onTap: (value) {
                navigationBarCubit.changeCurrentIndex(value);
              },
              selectedItemColor:
                  ColorsManager.mainBlue, // Highlight color for selected tab
              unselectedItemColor: Colors.grey, // Color for unselected tabs
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.explore),
                  label: 'Explore',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month_rounded),
                  label: 'Booked',
                ),
              ],
            );
          }),
    );
  }
}

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<GetAdminWorkSpacesCubit>();

    final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
        GlobalKey<RefreshIndicatorState>();

    Future<void> refreshData() async {
      await cubit.fetchData();
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            verticalSpace(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    logout(context);
                    context.pushReplacementNamed(Routes.loginScreen);
                  },
                  child: const Text(
                    "logout",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            const SearchingBar(),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                "  Workspaces",
                style: TextStyles.font24BlackSemiBold,
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                key: refreshIndicatorKey,
                onRefresh: refreshData,
                child: BlocBuilder<GetAdminWorkSpacesCubit,
                    GetAdminWorkSpacesInitState>(
                  bloc: cubit,
                  builder: (context, state) {
                    if (state is GetAdminWorkSpacesLoudingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GetAdminWorkSpacesFialierState) {
                      // Still allow refresh even in failure
                      return ListView(
                        children: [
                          Center(
                            child: Text(state.message),
                          ),
                        ],
                      );
                    } else if (state is GetAdminWorkSpacesSuccessState) {
                      // Display the list of workspaces
                      return ListView(
                        children: state.workSpaceModeList!
                            .map((workSpace) =>
                                WorkspaceItem(workspace: workSpace))
                            .toList(),
                      );
                    } else {
                      // Handle unhandled states with an empty scrollable ListView
                      return ListView(
                        children: const [
                          Center(
                            child: Text('No data available'),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
