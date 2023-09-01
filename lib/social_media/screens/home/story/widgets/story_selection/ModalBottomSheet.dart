import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:emagz_vendor/social_media/common/EditorScreen/EditorScreen.dart';
import 'package:emagz_vendor/social_media/screens/home/story/controller/story_controller.dart';
import 'package:emagz_vendor/social_media/screens/home/story/story_editor_screen.dart';
import 'package:emagz_vendor/social_media/screens/post/create_post_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class StorySelectionBottomSheet extends StatelessWidget {
  const StorySelectionBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var storyController = Get.put(GetXStoryController());
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 500,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: FormHeadingText(
              headings: "Update eMagz",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.to(() => const StoryEditorScreen());
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xffDFECFF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FormHeadingText(
                      headings: "Text",
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff054BFF),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xffDFECFF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FormHeadingText(
                    headings: "Gallery",
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff054BFF),
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xffDFECFF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FormHeadingText(
                    headings: "Camera",
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff054BFF),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(child: GridGallery(
            onPostTapped: (imageData, assetEntity) {
              debugPrint("image Data : ${assetEntity.mimeType!.split("/")[1]}");
              Get.to(() => EditorScreen(
                    onSubmit: (editedImage) async {
                      final bool x = await storyController.postStory(
                          assetEntity.mimeType!.split("/")[0],
                          editedImage.path);
                      if (x) {
                        Get.close(2);
                      }
                    },
                    image: imageData,
                    fileType: assetEntity.mimeType!.split("/")[0],
                    fileExtension: assetEntity.mimeType!.split("/")[1],
                  ));
            },
          ))
        ],
      ),
    );
  }
}
