import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/user/common/user_top_bar.dart';
import 'package:emagz_vendor/user/screens/bag/widget/empty_bag_gridview.dart';
import 'package:emagz_vendor/user/screens/order/order_scree.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyBagScreen extends StatelessWidget {
  const EmptyBagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const UserTopBar(title: "Bag"),
      body: Column(
        children: [
          SizedBox(
            height: size.height / 8,
          ),
          InkWell(
            onTap: () {
              Get.to(() => const OrderScreen());
            },
            child: Image.asset(
              "assets/png/Cart.png",
              height: size.height / 6,
              fit: BoxFit.cover,
              // width: 362,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Please Fill Me",
            style: TextStyle(
                color: blackButtonColor,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
          const Text(
            "It looks like your have not shop anything \nyet",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: blackButtonColor,
                fontSize: 10,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 30,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Products For You",
                  style: TextStyle(
                      color: blackButtonColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  "View More",
                  style: TextStyle(
                      color: Color(0xff292929),
                      fontSize: 10,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Expanded(child: EmptyBagGridView()),
        ],
      ),
    );
  }
}
