// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/sliding_widget.dart';
import 'package:ibm_flutter_final_project/features/workspace_status/data/model/work_space_model.dart';

class WorkSpaces extends StatelessWidget {
  List<WorkSpaceModel> workSpaceList;
  WorkSpaces({
    Key? key,
    required this.workSpaceList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 198.h,
      child: ListView.builder(
        itemCount: workSpaceList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final entry = workSpaceList[index];
          return SlidingWidget(
            itemName: entry.title ?? 'Titen Office Center',
            location: entry.location ?? 'cairo ,nacer city',
          );
        },
      ),
    );
  }
}
