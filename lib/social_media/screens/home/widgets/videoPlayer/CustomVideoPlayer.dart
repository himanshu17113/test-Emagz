import 'package:emagz_vendor/social_media/controller/video_player_controller/video_player_controller.dart';
import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatelessWidget {
  final Post post;
  final double aspectRatio;
  final String videoUrl;
  CustomVideoPlayer(
      {super.key,
      required this.post,
      required this.videoUrl,
      required this.aspectRatio});

  var videoPlayerController = Get.put(GetXVideoPlayerController());

  @override
  Widget build(BuildContext context) {
    debugPrint(videoUrl);
    return Obx(
      () => (post.sId == videoPlayerController.currentId.value)
          ? InkWell(
              onTap: () {
                videoPlayerController.togglePlay();
              },
              child: Stack(alignment: Alignment.center, children: [
                AspectRatio(
                  aspectRatio: aspectRatio ??
                      videoPlayerController.controller?.value.aspectRatio ??
                      1,
                  child: VideoPlayer(
                    videoPlayerController.controller!,
                  ),
                ),
                Obx(() => videoPlayerController.isPlayed.value
                    ? Container()
                    : Stack(
                        alignment: Alignment.center,
                        children: [
                          const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 50,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.80)),
                          )
                        ],
                      ))
              ]),
            )
          : InkWell(
              onTap: () async {
                videoPlayerController.setVideoController(videoUrl, post.sId!);
              },
              child: Container(
                color: Colors.black.withOpacity(0.50),
                child: Center(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.play_arrow,
                      size: 60,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "video thumbnail",
                      style: TextStyle(color: Colors.white, fontSize: 28),
                    ),
                    Text(
                      "will be replaced when it will be received ",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                )),
              ),
            ),
    );
  }
}
