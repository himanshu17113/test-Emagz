import 'package:emagz_vendor/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RDOBInputField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final String? time;

  const RDOBInputField({
    Key? key,
    required this.label,
    this.controller,
    this.time,
  }) : super(key: key);

  @override
  State<RDOBInputField> createState() => _RDOBInputFieldState();
}

class _RDOBInputFieldState extends State<RDOBInputField> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now().subtract(const Duration(days: 6574)),
        firstDate: DateTime(1900),
        lastDate: DateTime.now().subtract(const Duration(days: 6574)));

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;

        widget.controller!.text = DateFormat('dd-MM-yyyy').format(_selectedDate!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _selectDate(context);
      },
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: const Color(0xffF2F2F2),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Spacer(),
            const Icon(
              Icons.calendar_today,
              color: signInHeading,
              size: 16,
            ),
            const Spacer(
              flex: 1,
            ),
            Text(
              _selectedDate == null ? widget.time ?? widget.label : DateFormat('dd-MM-yyyy').format(_selectedDate!),
              style: _selectedDate == null
                  ? const TextStyle(
                      color: signInHeading,
                      fontSize: 14,
                    )
                  : const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
            ),
            const Spacer(
              flex: 12,
            ),
          ],
        ),
      ),
    );
  }
}
