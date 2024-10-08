import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/constant/data.dart' as text;
import 'package:emagz_vendor/templates/common/appbar/common_appbar.dart';
import 'package:emagz_vendor/user/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/fav_and_locate_widget.dart';

class TemplateFiveScreen extends StatefulWidget {
  const TemplateFiveScreen({super.key});

  @override
  State<TemplateFiveScreen> createState() => _TemplateFiveScreenState();
}

class _TemplateFiveScreenState extends State<TemplateFiveScreen> {
  int _current = 0;

  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: blackButtonColor,
        // extendBodyBehindAppBar: true,
        // appBar: TempleteAppBar(
        //   title: "",
        //   isBlack: false,
        // ),
        body: ListView(
          shrinkWrap: true,
          children: [
            const TempleteAppBar(
              title: "",
              isBlack: false,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Portfolio thats  makes your visit",
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(color: whiteColor, fontWeight: FontWeight.w400, fontSize: 32),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: templeteFiveDivider,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Set your fashion",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(color: whiteColor, fontWeight: FontWeight.w300, fontSize: 18),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: templeteFiveDivider,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Column(
                    children: [
                      Image.network(
                        uselessUrl,
                        height: 250,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Image.network(
                        uselessUrl,
                        height: 250,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 80,
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        height: 80,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Image.network(
                        uselessUrl,
                        height: 250,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Image.network(
                        uselessUrl,
                        height: 250,
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 250,
              decoration: const BoxDecoration(
                image: DecorationImage(image: CachedNetworkImageProvider(houseImage), fit: BoxFit.cover),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Capture the beautiful ",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(color: whiteColor, fontWeight: FontWeight.w300, fontSize: 28),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: Get.size.width / 5,
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: templeteFiveDivider,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Photography",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(color: whiteColor, fontWeight: FontWeight.w300, fontSize: 12),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: templeteFiveDivider,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 340,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    height: 280,
                    decoration: const BoxDecoration(
                      image: DecorationImage(image: CachedNetworkImageProvider(imageUrlThree), fit: BoxFit.cover),
                    ),
                  ),
                  Positioned(
                    top: 288,
                    child: Text(
                      "Our Story",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.playfairDisplay(color: whiteColor, fontWeight: FontWeight.w300, fontSize: 42),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                text.dummyText + dummyText,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(color: whiteColor, fontSize: 12, height: 1.1, fontWeight: FontWeight.w300),
              ),
            ),
            const FavouriteAndLocateWidget(
              isWhite: true,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Our Product",
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(color: whiteColor, fontWeight: FontWeight.w400, fontSize: 30),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: CarouselSlider.builder(
                itemCount: products.length,
                carouselController: _controller,
                itemBuilder: (context, index, realIndex) {
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        height: 120,
                        // width: 250,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(products[index].image.toString()), fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        height: 60,
                        color: const Color(0xff373737),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Product 01",
                                  textAlign: TextAlign.center,
                                  style:
                                      GoogleFonts.playfairDisplay(color: whiteColor, fontSize: 15, fontWeight: FontWeight.w600),
                                ),
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: tempStarColor,
                                      size: 6,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: tempStarColor,
                                      size: 6,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: tempStarColor,
                                      size: 6,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: tempStarColor,
                                      size: 6,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: grayColor,
                                      size: 6,
                                    ),
                                  ],
                                ),
                                const Text(
                                  "\$250.00",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: whiteColor, fontSize: 12, fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.shopping_bag_outlined,
                              color: whiteColor,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
                options: CarouselOptions(
                    reverse: false,
                    initialPage: 0,
                    viewportFraction: .41,
                    // enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                    autoPlay: true,
                    disableCenter: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: products.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 15,
                      height: 4,
                      // margin: const EdgeInsets.symmetric(horizontal: 2.0),
                      decoration: BoxDecoration(
                          // shape: BoxShape.circle,
                          color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.white)
                              .withOpacity(_current == entry.key ? 0.9 : 0.3)),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.center,
              height: 250,
              decoration: const BoxDecoration(
                image: DecorationImage(image: CachedNetworkImageProvider(speakerImage), fit: BoxFit.cover),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const Spacer(),
                    Text(
                      "Why Choose us ",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(color: whiteColor, fontWeight: FontWeight.w300, fontSize: 28),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        text.dummyText,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(color: whiteColor, fontWeight: FontWeight.w300, fontSize: 12),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 180,
              child: ListView.builder(
                itemCount: intrestImage .length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Image.network(
                      intrestImage[index],
                      width: 280,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
