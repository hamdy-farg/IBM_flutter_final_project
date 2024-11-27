import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/helpers/extensions.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/routing/routes.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/core/widgets/app_text_button.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/data/model/in_progress_model.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/ui/widgets/search_bar.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/ui/widgets/workspace_item.dart';

class WorkspaceStatus extends StatelessWidget {
  const WorkspaceStatus({super.key});

  @override
  Widget build(BuildContext context) {
    //Dummy Data :)
    Map<String, Workspace> workspaces = {
      'workspace1': Workspace(
          name: 'X-Space',
          image: 'assets/images/ex.png',
          description: " this is Example for description! :) "),
      'workspace2': Workspace(
          name: 'I-Tech',
          image: 'assets/images/ex.png',
          description: "Flexible leasing options to fit your need "),
      'workspace3': Workspace(
          name: 'IBM',
          image: 'assets/images/ex.png',
          description: "Prime location with easy access to transportation :) "),
    };

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_rounded),
        backgroundColor: Colors.white,
        title: const Text("Search", style: TextStyle(color: Colors.black)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SearchingBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("  Workspaces", style: TextStyles.font24BlackSemiBold),
                    ...workspaces.values
                        .map((workspace) => WorkspaceItem(workspace: workspace))
                        .toList(),
                    verticalSpace(10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: AppTextButton(
                        buttonText: "Add New Workspace",
                        buttonStyle: TextStyles.font16WhiteBold,
                        onPress: () {
                          context.pushNamed(Routes.addNewWorkSpace);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
