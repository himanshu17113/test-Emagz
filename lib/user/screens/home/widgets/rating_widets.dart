import 'package:emagz_vendor/constant/colors.dart';
import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.star,
              color: tempStarColor,
              size: 12,
            ),
            SizedBox(
              width: 3,
            ),
            Icon(
              Icons.star,
              color: tempStarColor,
              size: 12,
            ),
            SizedBox(
              width: 3,
            ),
            Icon(
              Icons.star,
              color: tempStarColor,
              size: 12,
            ),
            SizedBox(
              width: 3,
            ),
            Icon(
              Icons.star,
              color: tempStarColor,
              size: 12,
            ),
            SizedBox(
              width: 3,
            ),
            Icon(
              Icons.star,
              color: grayColor,
              size: 12,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "4.0",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: blackButtonColor),
            )
          ],
        ),
        Icon(Icons.favorite_border_outlined)
      ],
    );
  }
}