// ignore: file_names
import 'package:emagz_vendor/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SliderCard extends StatelessWidget {
  const SliderCard({
    super.key,
    required this.images,
  });

  final String images;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          // padding: EdgeInsets.only(right: 10),
          width: MediaQuery.of(context).size.width / 2,
          height: 340,
          child: Image.network(
            images,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 150,
          left: MediaQuery.of(context).size.width / 4.2,
          child: Container(
            height: 150,
            width: 190,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: tempOneSliderback,
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
                      color: const Color(0xff424242),
                      fontSize: 6,
                      height: 1.5,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 5,
                ),
                const Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: tempStarColor,
                      size: 15,
                    ),
                    Icon(
                      Icons.star,
                      color: tempStarColor,
                      size: 15,
                    ),
                    Icon(
                      Icons.star,
                      color: tempStarColor,
                      size: 15,
                    ),
                    Icon(
                      Icons.star,
                      color: tempStarColor,
                      size: 15,
                    ),
                    Icon(
                      Icons.star,
                      color: grayColor,
                      size: 15,
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}