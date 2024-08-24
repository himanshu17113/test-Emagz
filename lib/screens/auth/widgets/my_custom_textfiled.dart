import 'package:emagz_vendor/constant/colors.dart';
import 'package:flutter/material.dart';

class MyCustomTextfiled extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? inputType;
  final String? hint;
  final int? maxLines;
  final Function? onTap;
  final Function(String text)? onChange;

  const MyCustomTextfiled({super.key, this.controller, this.hint, this.maxLines = 1, this.onTap, this.inputType, this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // color: const Color(0xffF2F2F2),
          borderRadius: BorderRadius.circular(10)),
      height: maxLines == 1 ? 44 : null,
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        cursorColor: grayColor,
        onChanged: (value) {
          onChange == null ? null : onChange!(value);
        },
        keyboardType: inputType,
        minLines: maxLines,
        // autofocus: true,
        // scrollPadding: EdgeInsets.zero,

        // autofocus: true,
        decoration: InputDecoration(
            fillColor: const Color(0xffF2F2F2),
            isDense: true,
            contentPadding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            hintText: hint,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xffF2F2F2),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xffF2F2F2),
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xffF2F2F2),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xffF2F2F2),
              ),
            ),
            hintStyle: const TextStyle(
              fontSize: 10,
              color: hintColor,
            )),
      ),
    );
  }
}

class PassTextfiled extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? inputType;
  final String? hint;

  final Function? onTap;
  final Function(String text)? onChange;

  const PassTextfiled({super.key, this.controller, this.hint, this.onTap, this.inputType, this.onChange});

  @override
  Widget build(BuildContext context) {
    bool visibility = false;
    return Container(
      decoration: BoxDecoration(
          // color: const Color(0xffF2F2F2),
          borderRadius: BorderRadius.circular(10)),
      height: 44,
      child: StatefulBuilder(
        builder: (BuildContext context, setState) => TextFormField(
          controller: controller,
          maxLines: 1,
          cursorColor: grayColor,
          onChanged: (value) {
            onChange == null ? null : onChange!(value);
          },
          keyboardType: inputType,
          minLines: 1,
          obscureText: !visibility,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () => setState(() => visibility = !visibility),
                  icon: Icon(visibility ? Icons.visibility : Icons.visibility_off)),
              fillColor: const Color(0xffF2F2F2),
              isDense: true,
              contentPadding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
              hintText: hint,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xffF2F2F2),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xffF2F2F2),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xffF2F2F2),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xffF2F2F2),
                ),
              ),
              hintStyle: const TextStyle(
                fontSize: 10,
                color: hintColor,
              )),
        ),
      ),
    );
  }
}
