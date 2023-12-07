import 'dart:io';
import 'dart:typed_data';

import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:emagz_vendor/social_media/common/EditorScreen/EditorScreen.dart';
import 'package:emagz_vendor/social_media/screens/home/story/controller/story_controller.dart';
import 'package:emagz_vendor/social_media/screens/home/story/story_editor_screen.dart';
import 'package:emagz_vendor/social_media/screens/post/create_post_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StorySelectionBottomSheet extends StatelessWidget {
  StorySelectionBottomSheet({super.key});
  //var storyCoontroller = Get.put(PostController());
  
  var storyController = Get.put(GetXStoryController(), tag: "GetXStoryController");
  Future<Uint8List?> xFileToUint8List(XFile xFile) async {
    File file = File(xFile.path);
    if (await file.exists()) {
      List<int> imageBytes = await file.readAsBytes();
      return Uint8List.fromList(imageBytes);
    } else {
      return null;
    }
  }

  Future _capturePhoto() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      Uint8List? image = await xFileToUint8List(pickedFile);
      Get.to(
          () => EditorScreen(
                isStory: true,
                // fileExtension: fileExtension,
                image: [image],
                // onSubmit: (editedImage) {
                //   postController.imagePaths.add(editedImage.path);
                //   Get.off(() => PrePostScreen(postType: PostType.text, image: editedImage.path));
                // }
              ),
          curve: Curves.bounceIn);
    }
  }

  @override
  Widget build(BuildContext context) {
     return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: Get.height * .85 ?? 500,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: FormHeadingText(
              headings: "Update e-Magz",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.to(() => StoryEditorScreen());
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xffDFECFF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const FormHeadingText(
                      headings: "Text",
                      fontWeight: FontWeight.bold,
                      color: Color(0xff054BFF),
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
                  child: const FormHeadingText(
                    headings: "Gallery",
                    fontWeight: FontWeight.bold,
                    color: Color(0xff054BFF),
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () async {
                  await _capturePhoto();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xffDFECFF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const FormHeadingText(
                    headings: "Camera",
                    fontWeight: FontWeight.bold,
                    color: Color(0xff054BFF),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: Stack(
            children: [
              const GridGallery(
                isStory: true,
              ),
              Obx(() => Visibility(
                    visible: storyController.imagesNotEmpty.value,
                    child: Positioned(
                      bottom: 70,
                      right: 30,
                      child: IconButton(
                        icon: const CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.blue,
                          child: Icon(
                            Icons.check_sharp,
                          ),
                        ),
                        onPressed: () {
                          storyController.images.isNotEmpty
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditorScreen(
                                            isStory: true,
                                            image: storyController.images,
                                          ),
                                      fullscreenDialog: true))
                              : null;
                        },
                      ),
                    ),
                  )),
            ],
          ))
        ],
      ),
    );
  }
}
