import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/auth/widgets/my_custom_textfiled.dart';
import 'package:emagz_vendor/user/models/product_model.dart';
import 'package:flutter/material.dart';

class RatingCard extends StatelessWidget {
  const RatingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(image: CachedNetworkImageProvider(products[2].image.toString()), fit: BoxFit.cover))),
              const SizedBox(
                width: 10,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "The Product ",
                    style: TextStyle(color: blackButtonColor, fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    "Qty 01",
                    style: TextStyle(color: blackButtonColor, fontSize: 8.5, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    "Deliver on  22 Juy 2021",
                    style: TextStyle(color: Color(0xff9A9A9A), fontSize: 8.5, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Rate now ",
                    style: TextStyle(color: blackButtonColor, fontSize: 8, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 3,
                  ),
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
                    ],
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Write Your Reviews",
            style: TextStyle(color: blackButtonColor, fontSize: 8, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 5,
          ),
          const SizedBox(height: 35, child: MyCustomTextfiled()),
        ],
      ),
    );
  }
}
