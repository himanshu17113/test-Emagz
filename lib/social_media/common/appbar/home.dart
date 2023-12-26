import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/constant/data.dart';
import 'package:emagz_vendor/screens/notification/notification_screen.dart';
import 'package:emagz_vendor/social_media/controller/home/home_controller.dart';
import 'package:emagz_vendor/social_media/screens/chat/controllers/socketController.dart';
import 'package:emagz_vendor/templates/choose_template/webview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  const HomeAppBar({
    Key? key,
  })  : preferredSize = const Size.fromHeight(60.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePostsController>(
        id: "appbar",
        assignId: true,
        tag: "HomePostsController",
        autoRemove: false,
        init: HomePostsController(),
        builder: (homePostController) => AnimatedContainer(
            padding: const EdgeInsets.all(10),
            //    color: socialBack,
            duration: const Duration(milliseconds: 200),
            height: homePostController.isVisible ? 90 : 0,
            decoration: const BoxDecoration(color: socialBack, boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
                spreadRadius: -2.0, // This hides the shadow on other sides
                offset: Offset(0, 2.0), // This positions the shadow downwards
              ),
            ]),
            // lerpDouble(100.0, 50.0,
            //     homePostController.scrollController.offset / 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(
                  "assets/png/new_logo.png",
                  color: const Color(0xff1B47C1),
                  height: 38,
                  width: 36,
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const OwnWebView());
                    },
                    child: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        constuser?.profilePic.toString() ?? "",
                      ),
                      maxRadius: 15,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.to(() => const NotificationScreen()),
                  child: GetBuilder<SocketController>(
                    init: SocketController(),
                    tag: "notify",
                    id: "dot",
                    //  assignId: true,
                    //     initState: (_) {},
                    builder: (socketController) =>
                        Stack(alignment: Alignment.topRight, children: [
                      Image.asset(
                        "assets/png/notification_bell.png",
                        height: 28,
                        width: 28,
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: socketController.notifications.isNotEmpty
                            ? CircleAvatar(
                                radius: 8,
                                backgroundColor: Colors.red,
                                child: Text(
                                  socketController.notifications.length
                                      .toString(),
                                  style: const TextStyle(fontSize: 12),
                                ))
                            : const SizedBox.shrink(),
                      )
                    ]),
                  ),
                ),
              ],
            )));
  }
}
