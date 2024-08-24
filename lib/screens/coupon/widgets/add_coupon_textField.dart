import 'package:emagz_vendor/constant/colors.dart';
import 'package:flutter/material.dart';

class AddCouponTextfiled extends StatelessWidget {
final  TextEditingController? controller;
  final TextInputType? inputType;
 final String? hint;
 final int? maxLines;

  const AddCouponTextfiled({
    super.key,
    this.controller,
    this.hint,
    this.maxLines = 1,
    this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: maxLines == 1 ? 40 : null,
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        cursorColor: grayColor,
        keyboardType: inputType,
        // autofocus: true,
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Color(0xffD7D7D7)),
          fillColor: lightgrayColor,
          hintText: hint,
          filled: true,
          contentPadding: const EdgeInsets.only(left: 5),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: lightgrayColor,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: lightgrayColor),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: lightgrayColor),
          ),
        ),
      ),
    );
  }
}
