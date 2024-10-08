import 'package:emagz_vendor/constant/colors.dart';
import 'package:flutter/material.dart';

class ManageAddressHeading extends StatelessWidget {
  final String title;
  const ManageAddressHeading({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1),
      child: Text(
        title,
        style: const TextStyle(
            color: blackButtonColor, fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }
}
