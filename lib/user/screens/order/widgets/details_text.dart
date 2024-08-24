import 'package:emagz_vendor/constant/colors.dart';
import 'package:flutter/material.dart';

class DetailsText extends StatelessWidget {
  final String title;
  const DetailsText({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 12, color: blackButtonColor),
    );
  }
}