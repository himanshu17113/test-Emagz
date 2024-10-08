import 'package:emagz_vendor/constant/colors.dart';
import 'package:flutter/material.dart';

class ManageAddressTextfiled extends StatelessWidget {
 final TextEditingController? controller;
 final TextInputType? inputType;
 final String? hint;
 final int? maxLines;

  const ManageAddressTextfiled({
    super.key,
    this.controller,
    this.hint,
    this.maxLines = 1,
    this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xffF5F5F5), borderRadius: BorderRadius.circular(8)),
      height: maxLines == 1 ? 30 : null,
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        cursorColor: grayColor,
        keyboardType: inputType,
        minLines: maxLines,
        // scrollPadding: EdgeInsets.zero,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
