import 'dart:developer';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibm_flutter_final_project/core/di/dependancy_injection.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/features/add-new-room/logic/cubit/add_new_room_cubit.dart';
import 'package:ibm_flutter_final_project/features/add-new-room/ui/add_new_room.dart';
import 'package:intl/intl.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart'; // Ensure the import is correct

class CustomDatePicker extends StatefulWidget {
  final Function(String?) onDatePicked;
  final String? title;

  final Color? backgroundColor;
  final TextStyle? textStyle;
  final DateTime? startingDate; // Use this to restrict the date selection

  CustomDatePicker({
    Key? key,
    required this.onDatePicked,
    this.title,
    this.backgroundColor,
    this.textStyle,
    this.startingDate, // Ensure the starting date is passed for restrictions
  }) : super(key: key);

  @override
  Custom_DatePickerState createState() => Custom_DatePickerState();
}

class Custom_DatePickerState extends State<CustomDatePicker> {
  final cubit = getIt<AddNewRoomCubit>();
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    log(" ---- Start Date is ${cubit.state.startDate}");
    log(" ---- End Date is ${cubit.state.endDate}");
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.startingDate ?? DateTime.now(),
      firstDate: widget.startingDate ??
          DateTime.now(), // Restrict end date to start date
      lastDate: DateTime(2025),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });

      // Return the picked date through the callback function
      widget.onDatePicked(DateFormat('yyyy-MM-dd').format(selectedDate!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Start Date Button
        TextButton(
          onPressed: () => cubit.state.startDate != null
              ? _selectDate(context)
              :      CherryToast.error(
        toastDuration: const Duration(seconds: 3),
        animationDuration: const Duration(seconds: 1),
        title: Text(
         "Please Select end Date First",
          style: const TextStyle(color: ColorsManager.mainBlue),
        ),
      ).show(context) ,
          style: TextButton.styleFrom(
            backgroundColor: widget.backgroundColor ?? ColorsManager.mainBlue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: Text(
            widget.title ?? "Pick Date",
            style: widget.textStyle ?? TextStyle(fontSize: 16.sp),
          ),
        ),
        // Date Display Container
        GestureDetector(
          onTap: () => cubit.state.startDate != null
              ? _selectDate(context)
              :      CherryToast.error(
        toastDuration: const Duration(seconds: 3),
        animationDuration: const Duration(seconds: 1),
        title: Text(
         "Please Select end Date First",
          style: const TextStyle(color: ColorsManager.mainBlue),
        ),
      ).show(context) ,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: ColorsManager.lightGrey),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Calendar Icon
                SvgPicture.asset('assets/svgs/Calendar.svg'),
                horizantalSpace(10),
                // Selected Date or Placeholder
                Text(
                  selectedDate != null
                      ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                      : "No date Selected", // Placeholder when no date is selected
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
