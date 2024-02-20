import 'package:emagz_vendor/constant/colors.dart';
import 'package:flutter/material.dart';

class SocialMediaSettingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  @override
  final Size preferredSize;
  const SocialMediaSettingAppBar({
    required this.title,
    Key? key,
  })  : preferredSize = const Size.fromHeight(60.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: socialBack,
      elevation: 0.0,
      // leading: null,
      centerTitle: false,
      title: Text(
        title,
        style: const TextStyle(color: blackButtonColor, fontSize: 22, fontWeight: FontWeight.w600),
      ),
      actions: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            alignment: Alignment.center,
            // height: 10,
            // width: 35,
            margin: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
            padding: const EdgeInsets.only(
              left: 15,
              right: 10,
            ),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: chipColor,
            ),
            child: const Icon(
              Icons.arrow_back_ios,
              //size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
