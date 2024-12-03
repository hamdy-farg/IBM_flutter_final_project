import 'package:flutter/material.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';

class CheckInCheckoutWidget extends StatefulWidget {
  final List<List<int>> availableHours;
  final Function(String) checkInCallback;
  final Function(String) checkOutCallback;

  const CheckInCheckoutWidget({
    Key? key,
    required this.checkInCallback,
    required this.checkOutCallback,
    required this.availableHours,
  }) : super(key: key);

  @override
  _CheckInCheckoutWidgetState createState() => _CheckInCheckoutWidgetState();
}

class _CheckInCheckoutWidgetState extends State<CheckInCheckoutWidget> {
  String? selectedCheckInHour;
  String? selectedCheckOutHour;

  // Helper function to format 24-hour time to 12-hour time
  String formatTo12HourClock(int hour) {
    final period = hour >= 12 ? "PM" : "AM";
    final formattedHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return "$formattedHour:00 $period";
  }

  // Helper function to convert 12-hour time to 24-hour time in HH:mm:ss format
  String convertTo24HourFormat(String hour12) {
    int hour = int.parse(hour12.split(':')[0]);
    String period = hour12.contains("PM") ? "PM" : "AM";

    if (period == "PM" && hour != 12) {
      hour += 12; // Convert PM hours to 24-hour format
    } else if (period == "AM" && hour == 12) {
      hour = 0; // Handle midnight
    }

    // Return the time in HH:mm:ss format
    return "${hour.toString().padLeft(2, '0')}:00:00";
  }

  @override
  Widget build(BuildContext context) {
    // Collect all available check-in hours and check-out hours
    List<String> checkInHours = [];
    List<String> checkOutHours = [];

    // Track the ranges
    List<List<int>> ranges = widget.availableHours;

    for (var range in ranges) {
      for (int i = range[0]; i < range[1]; i++) {
        checkInHours.add(formatTo12HourClock(i)); // Format to 12-hour display
        checkOutHours
            .add(formatTo12HourClock(i + 1)); // Format to 12-hour display
      }
    }

    // Filter the check-out hours to ensure they are greater than the selected check-in hour,
    // but also constrained to the range of the selected check-in hour
    List<String> filteredCheckOutHours = [];
    if (selectedCheckInHour != null) {
      int checkInHourInt = int.parse(selectedCheckInHour!.split(':')[0]);
      if (selectedCheckInHour!.contains("PM") && checkInHourInt != 12) {
        checkInHourInt += 12; // Convert to 24-hour format
      } else if (selectedCheckInHour!.contains("AM") && checkInHourInt == 12) {
        checkInHourInt = 0; // Handle midnight
      }

      // Find the range the selected check-in hour belongs to
      for (var range in ranges) {
        if (checkInHourInt >= range[0] && checkInHourInt < range[1]) {
          // Limit check-out hours to the range of the selected check-in hour
          for (int i = checkInHourInt + 1; i <= range[1]; i++) {
            filteredCheckOutHours
                .add(formatTo12HourClock(i)); // Format to 12-hour display
          }
          break; // No need to check further ranges
        }
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          child: Text(
            "Check-in",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        // Check-in Row
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: checkInHours.map((hour) {
              return _buildHourContainer(hour, 'Check-in', selectedCheckInHour,
                  (selectedHour) {
                setState(() {
                  selectedCheckInHour = selectedHour;
                });

                // Return in 24-hour HH:mm:ss format
                widget.checkInCallback(convertTo24HourFormat(selectedHour));
              });
            }).toList(),
          ),
        ),
         

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          child: Text(
            "Check-out",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
         

        // Check-out Row (filtered based on selected check-in hour and within the same range)
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: filteredCheckOutHours.map((hour) {
              return _buildHourContainer(
                  hour, 'Check-out', selectedCheckOutHour, (selectedHour) {
                setState(() {
                  selectedCheckOutHour = selectedHour;
                });

                // Return in 24-hour HH:mm:ss format
                widget.checkOutCallback(convertTo24HourFormat(selectedHour));
              });
            }).toList(),
          ),
        ),
      ],
    );
  }

  // Helper function to create a container for each hour
  Widget _buildHourContainer(String hour, String type, String? selectedHour,
      Function(String) onTapCallback) {
    bool isSelected = selectedHour == hour;

    return InkWell(
      onTap: () {
        onTapCallback(hour);
      },
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: isSelected ? ColorsManager.mainBlue : Colors.transparent,
          border: Border.all(
            color: isSelected ? ColorsManager.mainBlue : ColorsManager.mainBlack,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            hour,
            style: TextStyle(
              color: isSelected ? Colors.white : ColorsManager.mainBlack,
              fontSize: 16,
              fontWeight: FontWeight.w400
              ,
            ),
          ),
        ),
      ),
    );
  }
}