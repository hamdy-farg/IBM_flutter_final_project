import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerScreen extends StatefulWidget {
  @override
  _DatePickerScreenState createState() => _DatePickerScreenState();
}

class _DatePickerScreenState extends State<DatePickerScreen> {
  String selectedDate = DateFormat('d - M - yyyy').format(DateTime.now());
  bool isTodaySelected = true;

  void _selectToday() {
    setState(() {
      selectedDate = 'Today';
      isTodaySelected = true;
    });
  }

  Future<void> _openCalendar(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000, 1, 1),
      lastDate: DateTime(2100, 12, 31),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = DateFormat('d - M - yyyy').format(pickedDate);
        isTodaySelected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DATE',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        SizedBox(height: 10),
        Text(
          selectedDate,
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _selectToday,
              style: ElevatedButton.styleFrom(
                backgroundColor: isTodaySelected ? Colors.blue : Colors.grey,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Today',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(width: 16),
            OutlinedButton(
              onPressed: () => _openCalendar(context),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.blue, width: 2),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    'Choose from Calendar',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
