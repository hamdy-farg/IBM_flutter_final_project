import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/data/model/in_progress_model.dart';
import 'workspace_button.dart';

class WorkspaceDetails extends StatelessWidget {
  final Workspace workspace;
  final bool isAvailableActive;
  final void Function(bool) toggleAvailability;

  const WorkspaceDetails({
    super.key,
    required this.workspace,
    required this.isAvailableActive,
    required this.toggleAvailability,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(workspace.name, style: TextStyles.fonst18BlackBold),
        verticalSpace(8.h),
        Text('- ${workspace.description}',
            style: TextStyles.font14GreyRegular),
        verticalSpace(12.h),
        Row(
          children: [
            WorkspaceButton(
              label: "Available",
              isActive: isAvailableActive,
              onTap: () => toggleAvailability(true),
            ),
            horizantalSpace(8.w),
            WorkspaceButton(
              label: "Hide",
              isActive: !isAvailableActive,
              onTap: () => toggleAvailability(false),
            ),
          ],
        ),
      ],
    );
  }
}
