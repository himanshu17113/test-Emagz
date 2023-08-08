import 'package:emagz_vendor/constant/colors.dart';
import 'package:flutter/material.dart';

class FormHeadingText extends StatelessWidget {
  final String headings;
  FontWeight? fontWeight;
  final double fontSize;
  Color? color;
  final TextAlign textAlign;
  FormHeadingText(
      {Key? key,
      required this.headings,
      this.fontWeight,
      this.color,
      this.textAlign = TextAlign.start,
      this.fontSize = 15})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1),
      child: Text(
        headings,
        textAlign: textAlign,
        style: TextStyle(

            // height: .25,
            fontSize: fontSize,
            fontWeight: fontWeight ?? FontWeight.w400,
            color: color ?? blackButtonColor),
      ),
    );
  }
}