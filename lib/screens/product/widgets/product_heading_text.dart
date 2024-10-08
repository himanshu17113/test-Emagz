import 'package:emagz_vendor/constant/colors.dart';
import 'package:flutter/material.dart';

class AddProductheadind extends StatelessWidget {
  final String tittle;
  final bool? isRequired;
  const AddProductheadind(
      {super.key, required this.tittle, this.isRequired = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: RichText(
        text: TextSpan(
          text: tittle,
          style: const TextStyle(
              color: headingColor, fontSize: 14, fontWeight: FontWeight.w400),
          children: [
            TextSpan(
              text: isRequired == true ? ' *' : "",
              style: const TextStyle(color: headingColor, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
