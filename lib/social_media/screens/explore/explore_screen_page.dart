import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/bottom_nav/bottom_nav.dart';
import '../../controller/bottom_nav_controller.dart';
import 'explpre_screen.dart';
class ExploreScreenPageScreen extends StatefulWidget {
  const ExploreScreenPageScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreenPageScreen> createState() => _ExploreScreenPageScreenState();
}

class _ExploreScreenPageScreenState extends State<ExploreScreenPageScreen> {
  final nav= Get.put(NavController());
  @override

  Widget build(BuildContext context) {

    return GestureDetector(
      onHorizontalDragStart: (details)
      {

          nav.page.value = 0;
          Get.offAll(() => BottomNavBar());


        //Get.offAll(()=>SocialMediaHomePage());
      },
          child: const ExploreScreen(),
      );

  }
}
