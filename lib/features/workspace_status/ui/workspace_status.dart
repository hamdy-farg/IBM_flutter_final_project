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
import 'package:ibm_flutter_final_project/features/workspace_status/logic/cubit/get_admin_work_spaces_cubit.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/logic/cubit/get_admin_work_spaces_state.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/ui/widgets/search_bar.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/ui/widgets/workspace_item.dart';

class WorkspaceStatus extends StatelessWidget {
  const WorkspaceStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<GetAdminWorkSpacesCubit>();
    cubit.fetchData();

    return Scaffold(
      body: SafeArea(
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
                          color: Colors.red),
                    ),
                  ),
                ],
              ),
              const SearchingBar(),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child:
                    Text("  Workspaces", style: TextStyles.font24BlackSemiBold),
              ),
              Expanded(
                child: BlocBuilder<GetAdminWorkSpacesCubit,
                    GetAdminWorkSpacesInitState>(
                  bloc: cubit,
                  builder: (context, state) {
                    if (state is GetAdminWorkSpacesLoudingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GetAdminWorkSpacesFialierState) {
                      return Center(
                        child: Text(state.message),
                      );
                    } else if (state is GetAdminWorkSpacesSuccessState) {
                      return SingleChildScrollView(
                        child: Column(
                          children: state.workSpaceModeList!
                              .map((workSpace) =>
                                  WorkspaceItem(workspace: workSpace))
                              .toList(),
                        ),
                      );
                    } else {
                      return const SizedBox
                          .shrink(); // Fallback in case state is not handled
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: AppTextButton(
        buttonWidth: 120.w,
        buttonText: "Add New ",
        buttonStyle: TextStyles.font16WhiteBold,
        onPress: () async {
          context.pushNamed(Routes.addNewWorkSpace);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        iconSize: 35,
        backgroundColor: Colors.white,
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
      ),
    );
  }
}
