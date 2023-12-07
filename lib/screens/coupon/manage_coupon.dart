import 'package:dotted_line/dotted_line.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/coupon/widgets/add_coupon_heading.dart';
import 'package:emagz_vendor/screens/coupon/widgets/add_coupon_textField.dart';
import 'package:emagz_vendor/screens/product/widgets/search_container.dart';
import 'package:emagz_vendor/user/screens/coupon/widgets/user_coupon_clippath.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/common_top_bar.dart';

class ManageCouponScreen extends StatefulWidget {
  const ManageCouponScreen({Key? key}) : super(key: key);

  @override
  State<ManageCouponScreen> createState() => _ManageCouponScreenState();
}

class _ManageCouponScreenState extends State<ManageCouponScreen> {
  int selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15,
                ),
                const CommonTopBar(
                  title: 'Coupon',
                ),
                const SearchContainer(),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "View Coupon",
                  style: TextStyle(fontSize: 16.5, fontWeight: FontWeight.w600, color: orderHeadingColor),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: ClipPath(
                    clipper: UserCoupon(bottom: 34, holeRadius: 28),
                    child: Container(
                      // margin: EdgeInsets.only(left: 20),
                      padding: const EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
                      height: 90,
                      width: 205,
                      decoration: BoxDecoration(color: const Color(0xff2C199E), borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 6,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    "Coupon Code",
                                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: whiteColor),
                                  ),
                                  const SizedBox(
                                    width: 112,
                                    child: Text(
                                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In quis a, magna ante id libero eleifend consectetur. Odio nibh fringilla sit varius ut orci libero. Posuere sed sit turpis ac congue viverra.",
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 3, fontWeight: FontWeight.w500, color: whiteColor),
                                    ),
                                  ),
                                  const Text(
                                    "Expire Date  02/05/21",
                                    style: TextStyle(fontSize: 4, fontWeight: FontWeight.w500, color: whiteColor),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 15,
                                    width: 85,
                                    decoration: BoxDecoration(color: const Color(0xff3C83E6), borderRadius: BorderRadius.circular(2)),
                                    child: const Text(
                                      "Apply Code",
                                      style: TextStyle(fontSize: 4, fontWeight: FontWeight.w600, color: whiteColor),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Expanded(
                            flex: 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                DottedLine(
                                  dashGapLength: 2,
                                  direction: Axis.vertical,
                                  dashColor: whiteColor,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      " 25%",
                                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600, color: whiteColor),
                                    ),
                                    Text(
                                      "   Off",
                                      style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: whiteColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                // Center(child: UserCouponWidget()),
                // Center(child: MyCustomCuppon()),
                const SizedBox(
                  height: 15,
                ),
                const Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AddCouponHeadingText(
                            headings: "Coupon Code",
                          ),
                          AddCouponTextfiled()
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AddCouponHeadingText(
                            headings: "Coupon Value",
                          ),
                          AddCouponTextfiled()
                        ],
                      ),
                    ),
                  ],
                ),
                const AddCouponHeadingText(
                  headings: "Select Category",
                ),
                const AddCouponTextfiled(),
                const AddCouponHeadingText(
                  headings: "Select Sub Category",
                ),
                const AddCouponTextfiled(),
                const Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AddCouponHeadingText(
                            headings: "Discount Type",
                          ),
                          AddCouponTextfiled()
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AddCouponHeadingText(
                            headings: "Max User",
                          ),
                          AddCouponTextfiled()
                        ],
                      ),
                    ),
                  ],
                ),
                const Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AddCouponHeadingText(
                            headings: "Starts From",
                          ),
                          AddCouponTextfiled(
                            hint: " DD/MM/YY",
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AddCouponHeadingText(
                            headings: "Ends On",
                          ),
                          AddCouponTextfiled(
                            hint: " DD/MM/YY",
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      children: [
                        const AddCouponHeadingText(
                          headings: "Color",
                        ),
                        _colorPallete(),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AddCouponHeadingText(
                          headings: "Status",
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          width: 150,
                          alignment: Alignment.center,
                          height: 40,
                          decoration: BoxDecoration(color: const Color(0xff4BB642), borderRadius: BorderRadius.circular(50)),
                          child: const Text(
                            "Ongoing",
                            style: TextStyle(color: whiteColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          width: size.width / 2.21,
                          alignment: Alignment.center,
                          height: 45,
                          decoration: BoxDecoration(color: blackButtonColor, borderRadius: BorderRadius.circular(10)),
                          child: const Text(
                            "Delete Coupon",
                            style: TextStyle(color: whiteColor),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => const ManageCouponScreen());
                        },
                        child: Container(
                          width: size.width / 2.21,
                          alignment: Alignment.center,
                          height: 45,
                          decoration: BoxDecoration(color: blueButtonColor, borderRadius: BorderRadius.circular(10)),
                          child: const Text(
                            "Update Status",
                            style: TextStyle(color: whiteColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    height: 20,
                    child: const Text(
                      "Back",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: InkWell(
      //   onTap: () {
      //     Get.back();
      //   },
      //   child: Container(
      //     color: Colors.white,
      //     height: 20,
      //     child: const Text(
      //       "Back",
      //       textAlign: TextAlign.center,
      //       style: TextStyle(
      //           color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500),
      //     ),
      //   ),
      // ),
    );
  }

  _colorPallete() {
    return Wrap(
      children: List.generate(
        1,
        (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedColor = index;
                //debugPrint(_selectedColor);
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0, top: 10),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                    gradient: index == 0
                        ? myGradient
                        : index == 1
                            ? orangeGradient
                            : index == 2
                                ? redGradient
                                : greenGradient,
                    shape: BoxShape.circle),
                // child: _selectedColor == index
                //     ? const Icon(
                //         Icons.done,
                //         color: Colors.white,
                //         size: 18,
                //       )
                //     : Container(),
              ),
            ),
          );
        },
      ),
    );
  }
}
