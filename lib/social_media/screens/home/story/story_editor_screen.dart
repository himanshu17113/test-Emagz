import 'package:emagz_vendor/social_media/screens/home/story/controller/story_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vs_story_designer/vs_story_designer.dart';

class StoryEditorScreen extends StatefulWidget {
  const StoryEditorScreen({super.key});

  @override
  State<StoryEditorScreen> createState() => _StoryEditorScreenState();
}

class _StoryEditorScreenState extends State<StoryEditorScreen> {
  var storyController = Get.put(GetXStoryController());

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
            "Add to story",
            style: TextStyle(color: Colors.white),
          ),
        ),
        centerText: "",
        onDone: (v) {
          debugPrint("Story address : $v");
          storyController.postStory("image", v);
          showDialog(
            useSafeArea: true,
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(
                        () => LinearProgressIndicator(
                          value: storyController.storyUploadPercentage.value,
                        ),
                      ),
                      Obx(
                        () => Material(
                          color: Colors.transparent,
                          child: Text(
                            "${(storyController.storyUploadPercentage.value * 100).toInt()} %",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
