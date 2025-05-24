import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatefulWidget {
  final TextEditingController controller;
  final Color labelColor;

  const DatePickerField({
    Key? key,
    required this.controller,
    this.labelColor = Colors.black,
  }) : super(key: key);

  @override
  _DatePickerFieldState createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      widget.controller.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Date", style: TextStyle(color: widget.labelColor)),
        SizedBox(height: 8.0),
        TextFormField(
          controller: widget.controller,
          readOnly: true,
          decoration: InputDecoration(
            suffixIcon: Icon(Icons.calendar_today, color: widget.labelColor),
            border: OutlineInputBorder(),
          ),
          onTap: () => _selectDate(context),
        ),
      ],
    );
  }
}
