import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../notification/notification_screen.dart';
import '../temp_attech_screen.dart';

class SocialHomeScreenAppBar extends StatefulWidget with PreferredSizeWidget {
  final String title;
  final Size preferredSize;
  final bool isColor;
  const SocialHomeScreenAppBar({
    this.title = "",
    this.isColor = true,
    Key? key,
  })  : preferredSize = const Size.fromHeight(70.0),
        super(key: key);

  @override
  State<SocialHomeScreenAppBar> createState() => _SocialHomeScreenAppBarState();
}

class _SocialHomeScreenAppBarState extends State<SocialHomeScreenAppBar> {
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
    return Container(
      color: widget.isColor == true ? socialBack : null,
      margin: const EdgeInsets.only(top: 15, right: 10, left: 10, bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Image.asset(
                  "assets/png/new_logo.png",
                  color: const Color(0xff1B47C1),
                  height: 38,
                  width: 36,
                ),
                const SizedBox(
                  width: 12,
                ),
              ],
            ),
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => const SocialNotificationScreen());
                },
                child: Image.asset(
                  "assets/png/notification_bell.png",
                  // height: 18,
                  width: 22,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                  // ZoomDrawer.of(context)!.toggle();
                },
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
            ],
          ),
        ],
      ),
    );
  }
}
