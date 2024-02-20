import 'package:emagz_vendor/constant/colors.dart';
import 'package:flutter/material.dart';

class FormHeadingText extends StatelessWidget {
  final String headings;
  final FontWeight? fontWeight;
  final double fontSize;
  final Color? color;
  final TextAlign textAlign;
  final FontStyle? isItalic;
  const FormHeadingText({
    Key? key,
    required this.headings,
    this.fontWeight,
    this.color,
    this.textAlign = TextAlign.start,
    this.fontSize = 15,
    this.isItalic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      headings,
   
      textAlign: textAlign,
      style: TextStyle(
          // height: .25,
          fontStyle: isItalic ?? FontStyle.normal,
          fontSize: fontSize,
          fontWeight: fontWeight ?? FontWeight.w400,
          color: color ?? blackButtonColor),
    );
  }
}
