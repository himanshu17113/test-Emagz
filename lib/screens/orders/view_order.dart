import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/common/common_top_bar.dart';
import 'package:emagz_vendor/screens/product/widgets/add_product_dropdown.dart';
import 'package:emagz_vendor/screens/product/widgets/add_product_textfield.dart';
import 'package:emagz_vendor/screens/product/widgets/search_container.dart';
import 'package:flutter/material.dart';

class ViewOrderScreen extends StatefulWidget {
  const ViewOrderScreen({Key? key}) : super(key: key);

  @override
  State<ViewOrderScreen> createState() => _ViewOrderScreenState();
}

class _ViewOrderScreenState extends State<ViewOrderScreen> {
  String orderStatus = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                const CommonTopBar(
                  title: 'Order',
                ),
                const SearchContainer(),
                const Text(
                  "View Order",
                  style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 115,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage(
                                "assets/png/quickImage.png",
                              ),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        height: 115,
                        // width: MediaQuery.of(context).size.width / 2.4,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: AssetImage(
                                "assets/png/quickImage.png",
                              ),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: const Text(
                              "Order ID",
                              style: TextStyle(
                                  color: blackButtonColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const AddProductTextField(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: const Text(
                              "Name",
                              style: TextStyle(
                                  color: blackButtonColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const AddProductTextField(),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: const Text(
                              "Customer Name",
                              style: TextStyle(
                                  color: blackButtonColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const AddProductTextField(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: const Text(
                              "Order Date",
                              style: TextStyle(
                                  color: blackButtonColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const AddProductTextField(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: const Text(
                              "Qty",
                              style: TextStyle(
                                  color: blackButtonColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const AddProductTextField(),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: const Text(
                              "Colour",
                              style: TextStyle(
                                  color: blackButtonColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const AddProductTextField(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: const Text(
                              "GST",
                              style: TextStyle(
                                  color: blackButtonColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const AddProductTextField(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: const Text(
                              "Price",
                              style: TextStyle(
                                  color: blackButtonColor,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const AddProductTextField(),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Delivery Address",
                  style: TextStyle(
                      color: blackButtonColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w500),
                ),
                const AddProductTextField(
                  maxLines: 5,
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "Delivery Address",
                  style: TextStyle(
                      color: blackButtonColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                    width: 150,
                    margin: const EdgeInsets.only(top: 5),
                    child: AddProductDropDown(
                      listData: const ['pending', "completed"],
                      // value: orderStatus,
                    ))
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
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
                    borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  "Manage Order",
                  style: TextStyle(color: whiteColor),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                // Get.to(() => const AddProductScreen());
              },
              child: Container(
                width: size.width / 2.15,
                alignment: Alignment.center,
                height: 45,
                decoration: BoxDecoration(
                    color: blueButtonColor,
                    borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  "Edit Order",
                  style: TextStyle(color: whiteColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
