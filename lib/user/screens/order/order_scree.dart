import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/user/common/user_top_bar.dart';
import 'package:emagz_vendor/user/screens/order/order_details.dart';
import 'package:emagz_vendor/user/screens/order/widgets/order_list_card.dart';
import 'package:emagz_vendor/user/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UserTopBar(title: "Order"),
      body: Column(
        children: [
          ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      Get.to(() => const OrderDetailsScreen());
                    },
                    child: const OrderListCard());
              }),
          const Expanded(
            child: SizedBox(),
          ),
          InkWell(
            onTap: () {
              Get.to(() => const ProfileScreenUser());
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
        ],
      ),
    );
  }
}
