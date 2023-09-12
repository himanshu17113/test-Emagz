import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/controller/home/home_controller.dart';
import 'package:emagz_vendor/social_media/screens/home/story/controller/story_controller.dart';
import 'package:emagz_vendor/social_media/screens/home/widgets/posts/home_posts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SocialMediaHomePage extends StatelessWidget {
  SocialMediaHomePage({Key? key}) : super(key: key);

  final jwtController = Get.put(JWTController());

  //final bool _showAppbar = true;

  final homePostController = Get.put(HomePostsController());
  final GetXStoryController storyController = Get.put(GetXStoryController());
  // final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    // if (myUserId == null)async {
    //   myUserId = await jwtController.getUserId();
    // }
    return SafeArea(
      child: Scaffold(
        backgroundColor: socialBack,
        appBar:
            // _showAppbar
            //     ?
            AppBar(
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
            Image.asset(
              "assets/png/notification_bell.png",
              // height: 18,
              width: 22,
            ),
            const SizedBox(
              width: 10,
            ),
            // InkWell(
            //   onTap: () {
            //     Get.back();
            //     // ZoomDrawer.of(context)!.toggle();
            //   },
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: FlipCard(
            //       // key: cardKey,
            //       front: InkWell(
            //           onTap: () {
            //             Get.to(() => const TempAttachScreen());
            //           },
            //           child: Container(
            //             margin: const EdgeInsets.only(right: 10),
            //             padding: const EdgeInsets.all(12.0),
            //             height: 55,
            //             width: 55,
            //             decoration: BoxDecoration(
            //               shape: BoxShape.circle,
            //               color: const Color(0xff1B47C1).withOpacity(.9),
            //             ),
            //             child:
            //                 SvgPicture.asset("assets/svg/Ebusiness-Icon.svg"),
            //           )),
            //       back: const CircleAvatar(
            //         radius: 30,
            //         backgroundImage: CachedNetworkImageProvider(
            //             "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Z2lybHN8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60"),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        )
        // : null
        ,
        //    scrollBehavior: const MaterialScrollBehavior(),
        //       controller: scrollController,
        // floatHeaderSlivers: true,
        // headerSliverBuilder: (context, innerBoxIsScrolled) {
        //   return [const SliverSocialMediaAppBar()];
        // },
        body: RefreshIndicator(
          onRefresh: () {
            homePostController.skip.value = -10;
            homePostController.posts?.clear();
            storyController.stories?.clear();
            storyController.getStories();
            return homePostController.getPost();
          },
          child: HomePosts(myUserId: jwtController.userId ?? homePostController.userId),
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
