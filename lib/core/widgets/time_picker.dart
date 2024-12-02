import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibm_flutter_final_project/core/helpers/spacing.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart'; // Ensure the import is correct

class CustomTimePicker extends StatefulWidget {
  final Function(String?)
      onTimePicked; // Callback function to send the picked time
  final String? title;
  final Color? backgroundColor; // Optional background color for the button
  final TextStyle? textStyle;
  final TimeOfDay? startingTime;
  final String? oldTime;

  // Constructor accepting the callback, backgroundColor, and title
  CustomTimePicker({
    Key? key,
    required this.onTimePicked,
    this.title,
    this.backgroundColor,
    this.textStyle,
    this.startingTime,
    this.oldTime,
  }) : super(key: key);

  @override
  _CustomTimePickerState createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  TimeOfDay? selectedTime; // Store selected time

  // Function to show the time picker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: widget.startingTime ?? TimeOfDay(hour: 0, minute: 00),
      // Default to current time
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });

      // Format time to display only the hour (24-hour format)
      final formattedTime = "${picked.hour.toString().padLeft(2, '0')}:00:00";
      // Pass the formatted time back through the callback
      widget.onTimePicked(formattedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Time Picker Button
        Container(
          width: 160.w,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: TextButton(
            onPressed: () => _selectTime(context),
            style: TextButton.styleFrom(
              backgroundColor: widget.backgroundColor ?? ColorsManager.mainBlue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              widget.title ?? "Pick Time", // Title for the button
              style: widget.textStyle ?? TextStyle(fontSize: 16),
            ),
          ),
        ),
        // Time Display Container
        GestureDetector(
          onTap: () => _selectTime(context),
          child: Container(
            width: 160.w, // Ensure the container takes the full width
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: ColorsManager.semiWhite),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Time Icon
                Icon(Icons.access_time, color: ColorsManager.mainBlue),
                horizantalSpace(10), // Space between icon and text
                // Display selected time or placeholder
                Text(
                  selectedTime != null
                      ? "${selectedTime!.hour.toString().padLeft(2, '0')}:00" // Display only the hour (HH:00)
                      : widget.oldTime != null
                          ? widget.oldTime ?? ""
                          : "HH:00", // Placeholder if no time is selected
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
