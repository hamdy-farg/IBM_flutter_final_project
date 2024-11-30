import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/data/model/work_space_model.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/ui/widgets/workspace_details.dart';

class WorkspaceItem extends StatefulWidget {
  final WorkSpaceModel workspace;
  const WorkspaceItem({super.key, required this.workspace});

  @override
  State<WorkspaceItem> createState() => _WorkspaceItemState();
}

class _WorkspaceItemState extends State<WorkspaceItem> {
  bool isAvailableActive = true;

  void _toggleAvailability(bool value) {
    setState(() {
      isAvailableActive = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: ColorsManager.mainBlue,
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(12.0.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100.w,
              height: 120.h,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          widget.workspace.image))), // just an example
            ),
            horizantalSpace(16.w),
            Expanded(
              child: WorkspaceDetails(
                workspace: widget.workspace,
                isAvailableActive: isAvailableActive,
                toggleAvailability: _toggleAvailability,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
