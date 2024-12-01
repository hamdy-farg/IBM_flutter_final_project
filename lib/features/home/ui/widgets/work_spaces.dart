import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/features/home/data/model/work_spaces.dart';
import 'package:ibm_flutter_final_project/features/home/ui/single_item_screen.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/favourite_icon_changer.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/sliding_widget.dart';
import 'package:ibm_flutter_final_project/features/home/ui/widgets/work_spaces.dart';

class WorkSpaces extends StatelessWidget {
  final List<WorkSpacess> workSpaces = [
    WorkSpacess(
        itemName: 'Titen Office Center',
        imagePath: '',
        location: 'cairo ,nacer city'),
    WorkSpacess(
        itemName: 'Titen Office Center',
        imagePath: '',
        location: 'cairo ,nacer city'),
    WorkSpacess(
        itemName: 'Titen Office Center',
        imagePath: '',
        location: 'cairo ,nacer city'),
    WorkSpacess(
        itemName: 'Titen Office Center',
        imagePath: '',
        location: 'cairo ,nacer city'),
    WorkSpacess(
        itemName: 'Titen Office Center',
        imagePath: '',
        location: 'cairo ,nacer city'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 198.h,
      child: ListView.builder(
        itemCount: workSpaces.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final entry = workSpaces[index];
          return SlidingWidget(
            itemName: entry.itemName ?? 'Titen Office Center',
            location: entry.location ?? 'cairo ,nacer city',
          );
        },
      ),
    );
  }
}
