 

import 'package:emagz_vendor/social_media/controller/post/post_controller.dart';
import 'package:emagz_vendor/social_media/screens/home/story/controller/story_controller.dart';
import 'package:emagz_vendor/social_media/screens/settings/post/pre_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vs_story_designer/vs_story_designer.dart';


class TextPostScreen extends StatefulWidget {
  const TextPostScreen({super.key});

  @override
  State<TextPostScreen> createState() => _TextPostScreenState();
}

class _TextPostScreenState extends State<TextPostScreen> {
  var storyController = Get.put(GetXStoryController());
  var postController = Get.put(PostController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VSStoryDesigner(
        fileName: "savedTextFile",
        middleBottomWidget: Container(),
        onDoneButtonStyle: Container(
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.all(10),
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Text(
            "Add to Post",
            style: TextStyle(color: Colors.white),
          ),
        ),
        centerText: "",
        onDone: (v) {
          debugPrint("Story address : $v");
          postController.setPost(v, PostType.text);
          //   storyController.postStory("text", v);
          // showDialog(
          //   useSafeArea: true,
          //   barrierDismissible: false,
          //   context: context,
          //   builder: (context) {
          //     return Center(
          //       child: Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 50.0),
          //         child:
          //          Column(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             Obx(
          //               () => LinearProgressIndicator(
          //                 value: storyController.storyUploadPercentage.value,
          //               ),
          //             ),
          //             Obx(
          //               () => Material(
          //                 color: Colors.transparent,
          //                 child: Text(
          //                   "${(storyController.storyUploadPercentage.value * 100).toInt()} %",
          //                   style: const TextStyle(color: Colors.white),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          // );
          // Get.off(
          //   EditorScreen(
          //       // imageHeight: realImage.height,
          //       // imageWidth: realImage.width,
          //        fileExtension: fileExtension,
          //       image: postController.imagePath,
          //       onSubmit: (editedImage) {
          //         postController.setPost(editedImage.readAsBytesSync(), postController.assetType!);
          //         Get.off(PrePostScreen(postType: PostType.gallery, image: postController.imagePath));
          //       }),
          // );
          Get.off(() => PrePostScreen(
                postType: PostType.text,
                image:  v,
              ));
        },
      ),
    );
  }
}
