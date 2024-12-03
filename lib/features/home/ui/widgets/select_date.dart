import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:intl/intl.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';

class CustomDatePicker extends StatefulWidget {
  final Function(String?) onDatePicked;
  final String? title;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final DateTime? startingDate;

  CustomDatePicker({
    Key? key,
    required this.onDatePicked,
    this.title,
    this.backgroundColor,
    this.textStyle,
    this.startingDate,
  }) : super(key: key);

  @override
  Custom_DatePickerState createState() => Custom_DatePickerState();
}

class Custom_DatePickerState extends State<CustomDatePicker> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.startingDate ?? DateTime.now(),
      firstDate: widget.startingDate ?? DateTime.now(),
      lastDate: DateTime(2025),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });

      widget.onDatePicked(DateFormat('yyyy-MM-dddd').format(selectedDate!));
    }
  }

  @override
  Widget build(BuildContext context) {
    String displayDate = selectedDate == null
        ? "Today"
        : selectedDate!.isSameDay(DateTime.now())
            ? "Today"
            : "Current Day";

    return Container(
      width: double.infinity.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            onPressed: () => _selectDate(context),
            style: TextButton.styleFrom(
              backgroundColor: widget.backgroundColor ?? ColorsManager.mainBlue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Text(
              displayDate,
              style: widget.textStyle ?? TextStyle(fontSize: 16.sp),
            ),
          ),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: ColorsManager.lightGrey),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/svgs/Calendar.svg'),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: ColorsManager.mainBlue,
                        size: 20,
                      ),
                      horizantalSpace(5),
                      Text(
                        selectedDate != null
                            ? DateFormat('dd-MM-yyyy').format(selectedDate!)
                            : "Choose from Calendar",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: ColorsManager.mainBlue,
                        size: 20,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Extension to compare dates without considering time
extension DateOnlyCompare on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}