import 'package:flutter/material.dart';

class DatePickerInTextField extends StatefulWidget {
  @override
  _DatePickerInTextFieldState createState() => _DatePickerInTextFieldState();
}

class _DatePickerInTextFieldState extends State<DatePickerInTextField> {
  // Controller for the TextField
  TextEditingController _dateController = TextEditingController();

  // Function to show the DatePicker dialog
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        // Format the date as needed, here using 'yyyy-MM-dd'
        _dateController.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _dateController,
          decoration: InputDecoration(
            icon: Icon(Icons.calendar_today),
            labelText: "Select Date",
          ),
          readOnly: true, // Prevents editing the field
          onTap: () {
            // Show the date picker when the TextField is tapped
            _selectDate(context);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dateController.dispose(); // Dispose the controller when no longer needed
    super.dispose();
  }
}
