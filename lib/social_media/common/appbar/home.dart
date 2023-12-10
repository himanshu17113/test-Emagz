import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/constant/data.dart';
import 'package:emagz_vendor/screens/notification/notification_screen.dart';
import 'package:emagz_vendor/social_media/controller/home/home_controller.dart';
import 'package:emagz_vendor/social_media/screens/chat/controllers/socketController.dart';
import 'package:emagz_vendor/templates/choose_template/webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        builder: (homePostController) => homePostController.isVisible
            ? AppBar(
               // toolbarHeight: homePostController.isVisible ? 50 : 0,
                systemOverlayStyle: const SystemUiOverlayStyle(
                    systemNavigationBarColor: socialBack),
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
                  GestureDetector(
                    onTap: () {
                      Get.to(() => OwnWebView(
                            token: globToken!,
                            userId: globUserId!,
                            personaUserId: globUserId!,
                            templateId: 'w',
                          ));
                    },
                    child: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        constuser?.ProfilePic.toString() ?? "",
                      ),
                      maxRadius: 15,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: GestureDetector(
                        onTap: () => Get.to(() => NotificationScreen()),
                        child: Stack(alignment: Alignment.topRight, children: [
                          Image.asset(
                            "assets/png/notification_bell.png",
                            height: 28,
                            width: 28,
                          ),
                          GetBuilder<SocketController>(
                            init: SocketController(),
                            initState: (_) {},
                            builder: (socketController) {
                              return Positioned(
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
                              );
                            },
                          )
                        ]),
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink());
  }
}
