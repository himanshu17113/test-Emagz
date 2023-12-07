import 'package:emagz_vendor/constant/colors.dart';
import 'package:flutter/material.dart';

class ApprovalTextField extends StatelessWidget {
 final TextEditingController? controller;
 final TextInputType? inputType;
 final String? hint;
final  int? maxLines;
final  Widget? sufixIcon;

  const ApprovalTextField({
    Key? key,
    this.hint,
    this.inputType,
    this.maxLines = 1,
    this.controller,
    this.sufixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          color: whiteColor.withOpacity(.22),
          borderRadius: BorderRadius.circular(8)),
      height: maxLines == 1 ? 40 : null,
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        cursorColor: grayColor,
        keyboardType: inputType,
        // autofocus: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 5),
          suffixIcon: sufixIcon,
          hintText: hint,
          // filled: true,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
