import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/common/bottom_nav/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusinessAccountConfirmationScreen extends StatelessWidget {
  const BusinessAccountConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/png/social_back.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Center(
              child: Image.asset(
                "assets/png/new_logo.png",
                width: 200,
                color: Colors.white.withOpacity(.8),
              ),
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              // height: 280,
              width: size.width,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: blackButtonColor.withOpacity(.15),
                    blurRadius: 6,
                    offset: const Offset(
                      2,
                      6,
                    ),
                    spreadRadius: 1)
              ], borderRadius: BorderRadius.circular(10), color: whiteColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Congratulations",
                    style: TextStyle(
                        color: blackButtonColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "your Professional persona is created successfully",
                    style: TextStyle(
                        color: lightBlack,
                        fontSize: 7,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 40,
                        decoration: BoxDecoration(
                            color: const Color(0xffFCFCFC),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          "View Insights",
                          style: TextStyle(
                              color: lightBlack,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 40,
                        decoration: BoxDecoration(
                            color: const Color(0xffFCFCFC),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          "Analysis your post",
                          style: TextStyle(
                              color: lightBlack,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          decoration: BoxDecoration(
                              color: const Color(0xffFCFCFC),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            "Personalized Professional persona",
                            style: TextStyle(
                                color: lightBlack,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          decoration: BoxDecoration(
                              color: const Color(0xffFCFCFC),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            "Redirect to store",
                            style: TextStyle(
                                color: lightBlack,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "View Audience Base",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: lightBlack,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 40,
                        decoration: BoxDecoration(
                            color: const Color(0xffFCFCFC),
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          "Promote Posts",
                          style: TextStyle(
                              color: lightBlack,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          height: 40,
                          decoration: BoxDecoration(
                              color: const Color(0xffFCFCFC),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            "Upload product images",
                            style: TextStyle(
                                color: lightBlack,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => const BottomNavBar());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 48,
                      decoration: BoxDecoration(
                          color: chipColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                            color: whiteColor,
                            fontSize: 9,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            // Spacer(),
          ],
        ),
      ),
    );
  }
}
