import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/screens/home/temp_attech_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class SliverSocialMediaAppBar extends StatefulWidget {
  const SliverSocialMediaAppBar({super.key});

  @override
  State<SliverSocialMediaAppBar> createState() => _SliverSocialMediaAppBarState();
}

class _SliverSocialMediaAppBarState extends State<SliverSocialMediaAppBar> {
  Timer? timer;
  bool isFlip = false;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 2), (Timer t) => flipWidget());
  }

  flipWidget() {
    setState(() {
      cardKey.currentState!.toggleCard();
      // isFlip = !isFlip;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: socialBack,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          "assets/png/new_logo.png",
          color: const Color(0xff1B47C1),
          height: 38,
          width: 36,
        ),
      ),
      actions: [
        Image.asset(
          "assets/png/notification_bell.png",
          // height: 18,
          width: 22,
        ),
        const SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {
            Get.back();
            // ZoomDrawer.of(context)!.toggle();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlipCard(
              key: cardKey,
              front: InkWell(
                  onTap: () {
                    Get.to(() => TempAttachScreen());
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.all(12.0),
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xff1B47C1).withOpacity(.9),
                    ),
                    child: SvgPicture.asset("assets/svg/Ebusiness-Icon.svg"),
                  )),
              back: const CircleAvatar(
                radius: 30,
                backgroundImage: CachedNetworkImageProvider(
                    "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Z2lybHN8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60"),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
