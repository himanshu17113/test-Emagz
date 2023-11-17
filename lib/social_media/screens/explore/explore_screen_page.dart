import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/common/appbar/common_app_bar.dart';
import 'package:emagz_vendor/social_media/screens/explore/post_details.dart';
import 'package:emagz_vendor/social_media/screens/explore/widgets/multi_choise_chip.dart';
import 'package:emagz_vendor/social_media/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';

import '../../../user/models/product_model.dart';
import '../../common/bottom_nav/bottom_nav.dart';
import '../../controller/bottom_nav_controller.dart';
import '../home_screen.dart';
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
          child: ExploreScreen(),
      );

  }
}
