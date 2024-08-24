import 'package:emagz_vendor/constant/colors.dart';
import 'package:flutter/material.dart';


class AddCouponHeadingText extends StatelessWidget {
  final String headings;
  const AddCouponHeadingText({super.key, required this.headings});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1),
      child: Text(
        headings,
        style: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w400, color: blackButtonColor),
      ),
    );
  }
}
