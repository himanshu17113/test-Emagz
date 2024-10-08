import 'package:flutter/material.dart';

import '../../../constant/colors.dart';

class IncomeCard extends StatelessWidget {
  final LinearGradient gradient;
  final String imagepath;
  final String title;
  final String totalCount;
  const IncomeCard(
      {super.key,
      required this.gradient,
      required this.title,
      required this.totalCount,
      required this.imagepath});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      // margin: EdgeInsets.only(left: 15),
      height: 110,
      width: 110,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imagepath), fit: BoxFit.cover),
        // gradient: gradient,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              totalCount,
              style: const TextStyle(
                  color: whiteColor, fontSize: 14, fontWeight: FontWeight.w600),
            ),
            Text(
              title,
              style: const TextStyle(
                  color: whiteColor,
                  fontSize: 9.5,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
