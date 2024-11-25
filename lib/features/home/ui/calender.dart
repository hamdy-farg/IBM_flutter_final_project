import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class DatePickerScreen extends StatefulWidget {
  @override
  _DatePickerScreenState createState() => _DatePickerScreenState();
}

class _DatePickerScreenState extends State<DatePickerScreen> {
  // Variable to store the selected date
  DateTime? _selectedDate;

  // Function to open date picker dialog
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(), // Default to current date
      firstDate: DateTime(2020), // Start date range
      lastDate: DateTime(2101), // End date range
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Button to open date picker
          ElevatedButton(
            onPressed: () => _selectDate(context),
            child: Text('Pick a Date'),
          ),
          SizedBox(height: 10),
          // Display the selected date without time
          Text(
            _selectedDate == null
                ? 'No date selected'
                : 'Selected date: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}', // Format date to exclude time
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}