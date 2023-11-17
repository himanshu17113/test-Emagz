import 'dart:io';

import 'package:emagz_vendor/social_media/controller/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../social_media/common/bottom_nav/bottom_nav.dart';

class CustomSnackbar {
  static void show(String message) {
    Get.snackbar(
      "Failed",
      message,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.red[800],
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
    );
  }

  static void showSucess(String message) {
    Get.snackbar(
      "Success",
      message,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 1),
      backgroundColor: const Color(0xFF18FF13),
      colorText: Colors.white,
      borderRadius: 10,
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
    );
  }
}

final homePostController = Get.find<HomePostsController>(tag: 'HomePostsController');
Widget customBackButton() {
  return Platform.isIOS
      ? IconButton(
          onPressed: () {
            homePostController.pageUpdate(0);
            Get.off(() => BottomNavBar());
          },
          icon: const Icon(Icons.arrow_back_ios))
      : const SizedBox.shrink();
}
