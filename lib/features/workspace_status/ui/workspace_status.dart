import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/helpers/utils.dart';
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            logout(context);
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        backgroundColor: Colors.white,
        title: const Text("Search", style: TextStyle(color: Colors.black)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SearchingBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("  Workspaces",
                          style: TextStyles.font24BlackSemiBold),
                      BlocBuilder<GetAdminWorkSpacesCubit,
                          GetAdminWorkSpacesInitState>(
                        bloc: cubit,
                        builder: (context, state) {
                          log("$state");
                          if (state is GetAdminWorkSpacesLoudingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is GetAdminWorkSpacesFialierState) {
                            return Center(
                              child: Text(state.message),
                            );
                          } else if (state is GetAdminWorkSpacesSuccessState) {
                            return Column(
                              children: state.workSpaceModeList!
                                  .map((workSpace) =>
                                      WorkspaceItem(workspace: workSpace))
                                  .toList(),
                            );
                          } else {
                            return const SizedBox
                                .shrink(); // Fallback in case state is not handled
                          }
                        },
                      ),
                      verticalSpace(10),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: AppTextButton(
                          buttonText: "Add New Workspace",
                          buttonStyle: TextStyles.font16WhiteBold,
                          onPress: () async {
                            cubit.fetchData();
                            // context.pushNamed(Routes.addNewWorkSpace);
                          },
                        ),
                      )
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
