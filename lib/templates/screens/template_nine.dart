import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/user/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common/appbar/common_appbar.dart';

class TemplateNineScreen extends StatefulWidget {
  const TemplateNineScreen({super.key});

  @override
  State<TemplateNineScreen> createState() => _TemplateNineScreenState();
}

class _TemplateNineScreenState extends State<TemplateNineScreen> {
  // final controller = PageController(initialPage: 0);
  final controller = CarouselSliderController();
  final controllerTwo = CarouselSliderController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: TempleteAppBar(
      //   title: "",
      //   // isBlack: false,
      // ),
      body: ListView(
        // padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const TempleteAppBar(
            title: "",
            // isBlack: false,
          ),
          SizedBox(
            height: Get.size.height * .02,
          ),
          Container(
            height: 300,
            width: double.infinity,
            decoration:
                BoxDecoration(image: DecorationImage(image: CachedNetworkImageProvider(foodImage[0].toString()), fit: BoxFit.cover)),
          ),
          SizedBox(
            height: Get.size.height * .05,
          ),
          Text(
            "High Quality Honey\nFor Your Breakfast",
            textAlign: TextAlign.center,
            style: GoogleFonts.bellefair(color: tempStarColor, fontSize: 35, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              dummyText,
              textAlign: TextAlign.center,
              style: GoogleFonts.aBeeZee(color: templeteEightHeading, fontSize: 13, height: 1.4, fontWeight: FontWeight.w300),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 60,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                    // color: blackButtonColor,
                    border: Border.all(color: templeteEightHeading)),
                child: Text(
                  "Favourite",
                  style: GoogleFonts.inter(
                      color: templeteEightHeading,
                      fontSize: 16,
                      // height: 1.4,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                height: 60,
                decoration: BoxDecoration(border: Border.all(color: blackButtonColor)),
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: blackButtonColor,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Locate us",
                      style: GoogleFonts.inter(
                          color: blackButtonColor,
                          fontSize: 16,
                          // height: 1.4,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 20,
                  ),
                  height: 220,
                  decoration:
                      BoxDecoration(image: DecorationImage(image: CachedNetworkImageProvider(foodImage[1].toString()), fit: BoxFit.cover)),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                    right: 20,
                  ),
                  height: 220,
                  decoration:
                      BoxDecoration(image: DecorationImage(image: CachedNetworkImageProvider(foodImage[2].toString()), fit: BoxFit.cover)),
                ),
              )
            ],
          ),
          Container(
            height: 150,
            margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
            decoration:
                BoxDecoration(image: DecorationImage(image: CachedNetworkImageProvider(foodImage[3].toString()), fit: BoxFit.cover)),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "Our Products",
            textAlign: TextAlign.center,
            style: GoogleFonts.bellefair(color: tempStarColor, fontSize: 30, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              dummyText,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(color: blackButtonColor, fontSize: 14, height: 1.5, fontWeight: FontWeight.w300),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () {
                  controllerTwo.previousPage(duration: const Duration(seconds: 1), curve: Curves.linear);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 15,
                ),
              ),
              Expanded(
                child: CarouselSlider.builder(
                    carouselController: controllerTwo,
                    itemCount: foodImage.length,
                    itemBuilder: (context, index, realIndex) {
                      return Stack(
                        children: [
                          SizedBox(
                            height: 280,
                            child: Image.network(
                              foodImage[index].toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 170,
                            left: 12,
                            child: Container(
                              height: 180,
                              width: 200,
                              padding: const EdgeInsets.only(top: 8, right: 15, left: 15),
                              decoration: BoxDecoration(
                                color: lightgrayColor,
                                border: Border.all(width: 5, color: whiteColor),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Product 01",
                                    style: GoogleFonts.inter(
                                        color: const Color(0xff424242),
                                        fontSize: 15,
                                        // height: 1.8,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ipsum augue amet, mi tellus proin ornare quam fermentum neque. Risus amet, commodo eget viverra ornare magna. Non dictumst purus felis ridiculus mi scelerisque mauris nisl, dui.",
                                    style: GoogleFonts.inter(
                                        color: const Color(0xff424242), fontSize: 7, height: 1.5, fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: tempStarColor,
                                        size: 8,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: tempStarColor,
                                        size: 8,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: tempStarColor,
                                        size: 8,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: tempStarColor,
                                        size: 8,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: grayColor,
                                        size: 8,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    "Add Qty",
                                    style: TextStyle(color: blackButtonColor, fontSize: 10, height: 1.5, fontWeight: FontWeight.w400),
                                  ),
                                  const Row(
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        // crossAxisAlignment: CrossA,
                                        children: [
                                          Text(
                                            "-",
                                            style:
                                                TextStyle(color: blackButtonColor, fontSize: 15, height: 1.5, fontWeight: FontWeight.w300),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "01",
                                            style:
                                                TextStyle(color: blackButtonColor, fontSize: 12, height: 1.5, fontWeight: FontWeight.w400),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "+",
                                            style:
                                                TextStyle(color: blackButtonColor, fontSize: 15, height: 1.5, fontWeight: FontWeight.w300),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Icon(
                                            Icons.shopping_bag_outlined,
                                            color: Colors.black,
                                          ),
                                          SizedBox(
                                            width: 2,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    },
                    options: CarouselOptions(height: 380, viewportFraction: .6, enlargeCenterPage: true)),
              ),
              const SizedBox(
                width: 3,
              ),
              const SizedBox(
                width: 3,
              ),
              InkWell(
                onTap: () {
                  controllerTwo.nextPage(duration: const Duration(seconds: 1), curve: Curves.linear);
                },
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
              ),
              const SizedBox(
                width: 3,
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () {
                  controller.previousPage(duration: const Duration(seconds: 1), curve: Curves.linear);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 15,
                ),
              ),
              Expanded(
                child: CarouselSlider.builder(
                    carouselController: controller,
                    itemCount: foodImage.length,
                    itemBuilder: (context, index, realIndex) {
                      return SizedBox(
                        width: Get.size.width,
                        child: Image.network(
                          foodImage[index].toString(),
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                    options: CarouselOptions(
                      viewportFraction: 1,
                      height: 150,
                      // viewportFraction: .8,
                    )),
              ),
              const SizedBox(
                width: 3,
              ),
              // const SizedBox(
              //   width: 3,
              // ),
              InkWell(
                onTap: () {
                  controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.linear);
                },
                child: const Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
              ),
              const SizedBox(
                width: 3,
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            "How we produce it ?",
            textAlign: TextAlign.center,
            style: GoogleFonts.simonetta(color: tempStarColor, fontSize: 30, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              dummyText + dummyText,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: headingColor, fontSize: 13, height: 1.5, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
