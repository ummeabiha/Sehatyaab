import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sehatyaab/validations/ProfileFormValidator.dart';
import 'package:sehatyaab/widgets/TextFormField.dart';

class DatePickerField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final Function(DateTime)? onDateSelected;
  final String? Function(String? value)? validator;

  const DatePickerField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.onDateSelected,
    this.validator,
  });

  @override
  _DatePickerFieldState createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: theme.copyWith(
            textTheme: theme.textTheme.copyWith(
              bodyLarge: theme.textTheme.bodyLarge!.copyWith(
                fontSize: 18,
              ),
              titleMedium: theme.textTheme.titleMedium!.copyWith(
                color: Colors.black,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        widget.controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });

      if (widget.onDateSelected != null) {
        widget.onDateSelected!(picked);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: CustomTextFormField(
          controller: widget.controller,
          validator: ProfileFormValidator.validateDob,
          labelText: 'Date of Birth',
          hintText: 'Select Date of Birth',
          suffixIcon: Icons.calendar_today,
          enabled: true,
        ),
      ),
    );
  }
}
