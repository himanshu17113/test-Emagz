import 'package:emagz_vendor/screens/notification/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UserTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  @override
  final Size preferredSize;
  const UserTopBar({
    required this.title,
    super.key,
  })  : preferredSize = const Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25, right: 10, left: 10),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                    // ZoomDrawer.of(context)!.toggle();
                  },
                  child: Image.asset(
                    "assets/png/temp_icon.png",
                    height: 20,
                    width: 20,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  // Get.to(() => ProfileScreen());
                },
                child: SvgPicture.asset(
                  "assets/svg/MagnifyingGlass.svg",
                  width: 25,
             //     color: blackButtonColor,
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => const NotificationScreen());
                },
                child: SvgPicture.asset(
                  "assets/svg/Notify.svg",
                  width: 40,
              //    color: blackButtonColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
