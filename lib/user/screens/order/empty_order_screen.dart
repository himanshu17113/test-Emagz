import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/user/common/user_top_bar.dart';
import 'package:emagz_vendor/user/screens/wishlist/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyOrderScreen extends StatelessWidget {
  const EmptyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UserTopBar(title: "Order"),
      body: Column(
        children: [
          const Expanded(
            child: SizedBox(),
          ),
          Image.asset(
            "assets/png/empty_order.png",
            height: 115,
          ),
          const Text(
            "Nothing To Be Shown",
            style: TextStyle(
                color: blackButtonColor,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
          const Text(
            "Let’s get some order for you so you can check me later",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: blackButtonColor,
                fontSize: 9.5,
                fontWeight: FontWeight.w500),
          ),
          InkWell(
            onTap: () {
              Get.to(() => const WishListScreen());
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
              alignment: Alignment.center,
              height: 45,
              decoration: BoxDecoration(
                  color: blueButtonColor,
                  borderRadius: BorderRadius.circular(1)),
              child: const Text(
                "Continue Shoping",
                style: TextStyle(color: whiteColor),
              ),
            ),
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
