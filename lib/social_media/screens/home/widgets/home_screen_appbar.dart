import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/notification/notification_screen.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../constant/data.dart';
 import '../temp_attech_screen.dart';

class SocialHomeScreenAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  @override
  final Size preferredSize;
  final bool isColor;
  const SocialHomeScreenAppBar({
    this.title = "",
    this.isColor = true,
    Key? key,
  })  : preferredSize = const Size.fromHeight(50.0),
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
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      color:
          //Colors.amberAccent,
          widget.isColor ? socialBack : null,
      padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            "assets/png/new_logo.png",
            color: const Color(0xff1B47C1),
            height: 38,
            width: 36,
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              Get.to(() => NotificationScreen());
            },
            child: Image.asset(
              "assets/png/notification_bell.png",
              // height: 18,
              width: 22,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: InkWell(
              onTap: () {
                Get.back();
                // ZoomDrawer.of(context)!.toggle();
              },
              child: FlipCard(
                key: cardKey,
                front: InkWell(
                    onTap: () {
                      Get.to(() => const TempAttachScreen());
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
                back: CircleAvatar(radius: 30, backgroundImage: CachedNetworkImageProvider(globProfilePic ?? "")),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
