import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/common/appbar/common_app_bar.dart';
import 'package:emagz_vendor/social_media/screens/explore/post_details.dart';
import 'package:emagz_vendor/social_media/screens/explore/widgets/multi_choise_chip.dart';
import 'package:emagz_vendor/social_media/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
import '../../../user/models/product_model.dart';
import '../../controller/bottom_nav_controller.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<String> reportList = [
    "Travel",
    "Funny",
    "Photography",
    "News",
    "Pets",
    "Roadtrip",
  ];
  static const pattern = [
    QuiltedGridTile(2, 1),
    QuiltedGridTile(1, 2),
    QuiltedGridTile(1, 2),
    QuiltedGridTile(1, 2),
    QuiltedGridTile(1, 2),
  ];
  List<String> selectedReportList = [];
  final nav = Get.put(NavController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: socialBack,
      appBar: const SocialMediaAppBar(title: "Explore"),
      body: Stack(alignment: Alignment.centerLeft, children: [
        Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                const Text(
                  "Explore your \nWorld",
                  style: TextStyle(color: blackButtonColor, fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const Expanded(child: SizedBox()),
                InkWell(
                  onTap: () {
                    Get.to(() => const SearchScreen());
                  },
                  child: SvgPicture.asset(
                    "assets/svg/MagnifyingGlass.svg",
                    width: 25,
                    color: blackButtonColor,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: MultiSelectChip(
                reportList,
                onSelectionChanged: (selectedList) {
                  setState(() {
                    selectedReportList = selectedList;
                    debugPrint(selectedList.toList().toString());
                  });
                },
                maxSelection: 2,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: GridView.custom(
                // cacheExtent: 10,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                gridDelegate: SliverQuiltedGridDelegate(
                    crossAxisCount: 5, mainAxisSpacing: 6, crossAxisSpacing: 6, repeatPattern: QuiltedGridRepeatPattern.inverted, pattern: pattern),
                childrenDelegate: SliverChildBuilderDelegate(
                  childCount: imageList.length,
                  (context, index) {
                    final tile = pattern[index % pattern.length];
                    return InkWell(
                      onTap: () {
                        Get.to(() => const ExplorePostDetails());
                      },
                      child: ImageTile(
                        index: index,
                        width: tile.crossAxisCount * 100,
                        // width: 200,
                        // height: 300,
                        height: tile.mainAxisCount * 100,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        GestureDetector(
          onHorizontalDragUpdate: (details) {
            nav.page.value = 0;
            //Get.offAll(() => BottomNavBar());

            //Get.offAll(()=>SocialMediaHomePage());
          },
          child: const ColoredBox(
            color: Colors.transparent,
            child: SizedBox(
              height: double.maxFinite,
              width: 30,
            ),
          ),
        ),
      ]),
    );
  }
}

class ImageTile extends StatelessWidget {
  const ImageTile({
    super.key,
    required this.index,
    required this.width,
    required this.height,
  });

  final int index;
  final int width;
  final int height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 400,
      child: CachedNetworkImage(
        imageUrl: imageList[index],
        placeholder: (context, url) => Container(
          height: 400,
          width: 400,
          color: Colors.grey,
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        width: width.toDouble(),
        height: height.toDouble(),
        fit: BoxFit.cover,
      ),
    );
  }
}
