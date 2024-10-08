import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/user/common/user_top_bar.dart';
import 'package:emagz_vendor/user/screens/bag/widget/bag_item_card.dart';
import 'package:emagz_vendor/user/screens/order/order_scree.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BagScreen extends StatelessWidget {
  BagScreen({super.key});

  final String quanity = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const UserTopBar(title: "Bag"),
      body: Column(
        children: [
          const SizedBox(height: 15),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) {
                return const BagItemcard();
              }),
          const Expanded(child: SizedBox()),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Price",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: blackButtonColor),
                    ),
                    Text(
                      "₹ 499.00",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: blackButtonColor),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                color: blackButtonColor,
                height: .58,
              ),
              Container(
                height: 130,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffF2F2F2)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: size.width / 2.5),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Price", style: style),
                              Text("₹ 499.00", style: style),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Discount", style: style),
                              Text("₹ 0          ", style: style),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Delivery", style: style),
                              Text(
                                "Free        ",
                                style: style.copyWith(
                                  color: const Color(0xff598D4B),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("GST", style: style),
                              Row(
                                children: [
                                  Text("₹ 50.00  ", style: style),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        // Get.back();
                      },
                      child: Container(
                        width: size.width / 2.15,
                        alignment: Alignment.center,
                        height: 45,
                        decoration: BoxDecoration(
                            color: blackButtonColor,
                            borderRadius: BorderRadius.circular(1)),
                        child: const Text("Save For Later",
                            style: TextStyle(color: whiteColor)),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => const OrderScreen());
                        // Get.to(() => const EmptyBagScreen());
                      },
                      child: Container(
                        width: size.width / 2.15,
                        alignment: Alignment.center,
                        height: 45,
                        decoration: BoxDecoration(
                            color: blueButtonColor,
                            borderRadius: BorderRadius.circular(1)),
                        child: const Text(
                          "Order Now",
                          style: TextStyle(color: whiteColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.arrow_back_sharp,
              size: 20,
            ),
            Text("Continue Shoping",
                style: style.copyWith(color: const Color(0xff535353))),
          ],
        ),
      ),
    );
  }

  TextStyle style = const TextStyle(
      fontSize: 12.5, fontWeight: FontWeight.w600, color: blackButtonColor);
}
