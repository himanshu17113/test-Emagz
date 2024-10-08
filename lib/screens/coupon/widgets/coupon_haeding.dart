import 'package:emagz_vendor/constant/colors.dart';
import 'package:flutter/material.dart';

class CouponHeading extends StatelessWidget {
  const CouponHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: const Text(
              "Code",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: orderHeadingColor),
            ),
          ),
          // SizedBox(
          //   width: 20,
          // ),
          Container(
            margin: const EdgeInsets.only(left: 14),
            child: const Text(
              "Value",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: orderHeadingColor),
            ),
          ),
          const Text(
            "No. Users",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: orderHeadingColor),
          ),
          Container(
            margin: const EdgeInsets.only(right: 16, left: 8),
            child: const Text(
              "Status",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: orderHeadingColor),
            ),
          ),

          // Container(
          //   margin: const EdgeInsets.only(right: 17, left: 8),
          //   child: Text(
          //     "Status",
          //     style: TextStyle(
          //         fontSize: 14,
          //         fontWeight: FontWeight.w500,
          //         color: orderHeadingColor),
          //   ),
          // ),
        ],
      ),
    );
  }
}
