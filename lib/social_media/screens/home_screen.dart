import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/controller/home/home_controller.dart';
import 'package:emagz_vendor/social_media/screens/home/story/story_view.dart';
import 'package:emagz_vendor/social_media/screens/home/widgets/SliverSocialMediaAppbar/SliverSocialMediaAppbar.dart';
import 'package:emagz_vendor/social_media/screens/home/widgets/posts/home_posts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SocialMediaHomePage extends StatefulWidget {
  const SocialMediaHomePage({Key? key}) : super(key: key);

  @override
  State<SocialMediaHomePage> createState() => _SocialMediaHomePageState();
}

class _SocialMediaHomePageState extends State<SocialMediaHomePage> {
  String? myUserId;
  var jwtController = Get.put(JWTController());
  var homePostController = Get.put(HomePostsController());

  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  asyncInit() async {
    myUserId = await jwtController.getUserId();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: socialBack,
        // appBar: ,
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [const SliverSocialMediaAppBar()];
          },
          body: RefreshIndicator(
            onRefresh: () {
              setState(() {});
              return homePostController.refreshResent();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const StoryView(),
                  const SizedBox(
                    height: 10,
                  ),
                  HomePosts(myUserId: myUserId ?? ""),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomePagePopupWidget extends StatelessWidget {
  final String title;
  final bool isBorder;
  const HomePagePopupWidget({
    super.key,
    required this.title,
    this.isBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      alignment: Alignment.center,
      height: 50,
      width: 260,
      decoration: BoxDecoration(
        color: isBorder == true ? null : Colors.white,
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: FormHeadingText(
        headings: title,
        fontSize: 18,
        color: isBorder == true ? Colors.white : Colors.black,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
