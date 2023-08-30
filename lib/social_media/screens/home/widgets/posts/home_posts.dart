import 'package:emagz_vendor/social_media/controller/home/home_controller.dart';
import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:emagz_vendor/social_media/screens/home/widgets/post_card.dart';
import 'package:emagz_vendor/social_media/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

class HomePosts extends StatefulWidget {
  String? myUserId;
  HomePosts({Key? key, this.myUserId}) : super(key: key);

  @override
  State<HomePosts> createState() => _HomePostsState();
}

class _HomePostsState extends State<HomePosts> {
  var homePostController = Get.put(HomePostsController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: homePostController.getPost(),
      builder: (context, snapshot) {
        // if(snapshot.hasError){
        //   return Center(child: Text(snapshot.error.toString()));
        // }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        // if(!snapshot.hasError){
        //   debugPrint(snapshot.data![0]);
        //   debugPrint(snapshot.error);
        //   return const Center(child: Text("Facing technical error while loading ... "));
        // }

        return Center(
          // fit: FlexFit.loose,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80.0),
            child: ListView.builder(
              shrinkWrap: true,
              controller: homePostController.scrollController,
              physics: const ScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      // Get.to(() => ExploreScreen());
                    },
                    onLongPress: () {
                      showDialog(
                          barrierColor: Colors.black.withOpacity(.5),
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              insetPadding: EdgeInsets.zero,
                              iconPadding: EdgeInsets.zero,
                              titlePadding: EdgeInsets.zero,
                              buttonPadding: EdgeInsets.zero,
                              actionsPadding: EdgeInsets.zero,
                              contentPadding: EdgeInsets.zero,
                              elevation: 0.0,
                              actionsAlignment: MainAxisAlignment.center,
                              alignment: Alignment.center,
                              backgroundColor: Colors.transparent,
                              content: SizedBox(
                                height: 250,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    HomePagePopupWidget(
                                      isBorder: false,
                                      title: "View Post",
                                    ),
                                    HomePagePopupWidget(
                                      title: "View Stats",
                                    ),
                                    HomePagePopupWidget(
                                      title: "Download",
                                    ),
                                    HomePagePopupWidget(
                                      title: "Share",
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: VisibilityDetector(
                      key: widget.key ?? Key("$index+@4+1999"),
                      onVisibilityChanged: (info) {
                        if (index - 9 >= homePostController.skip.value) {
                          // debugPrint(info.visibleFraction);
                          // setState(() {});
                        }
                      },
                      child: snapshot.data?[index] == null
                          ? const SizedBox()
                          : PostCard(
                              isLiked: snapshot.data![index].likes!
                                  .contains(widget.myUserId),
                              myUserId: widget.myUserId,
                              post: snapshot.data![index],
                              url: snapshot.data![index].mediaUrl ?? "",
                            ),
                    ));
              },
            ),
          ),
        );
      },
    );
  }
}
