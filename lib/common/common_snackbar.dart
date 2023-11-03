import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../social_media/common/bottom_nav/bottom_nav.dart';
import '../social_media/controller/bottom_nav_controller.dart';

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
final nav= Get.put(NavController());
Widget customBackButton() {
  return Platform.isIOS?IconButton(onPressed: (){nav.page=0.obs;Get.off(()=>BottomNavBar());}, icon: const Icon(Icons.arrow_back_ios)):const SizedBox.shrink();
}
