import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/screens/notification/notification_screen.dart';
import 'package:emagz_vendor/social_media/screens/settings/personal_page/personal_page_setting.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:emagz_vendor/common/common_snackbar.dart';

class SocialMediaAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  @override
  final Size preferredSize;
  const SocialMediaAppBar({
    required this.title,
    Key? key,
  })  : preferredSize = const Size.fromHeight(50.0),
        super(key: key);
  final String url =
      "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Z2lybHN8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60";
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.only(top: 40, right: 10, left: 10),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                // InkWell(
                //   onTap: () {
                //     Get.back();
                //     // ZoomDrawer.of(context)!.toggle();
                //   },
                //   child: Image.asset(
                //     "assets/png/drawer.png",
                //     height: 20,
                //     width: 20,
                //   ),
                // ),
                const SizedBox(
                  width: 12,
                ),
                Row(
                  children: [
                    customBackButton(),
                    const SizedBox(width: 3,),
                    Text(
                      title,
                      style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  Get.to(() =>   NotificationScreen());
                },
                child: Image.asset(
                  "assets/png/notification_bell.png",
                  width: 22,
                  // color: blackButtonColor,
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              InkWell(
                  onTap: () {
                    Get.to(() => const PersonalPageSetting());
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: CachedNetworkImageProvider(url), fit: BoxFit.cover), borderRadius: BorderRadius.circular(5)),
                  )),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
