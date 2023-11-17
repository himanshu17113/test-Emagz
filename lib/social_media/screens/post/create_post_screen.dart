import 'dart:io';
import 'package:emagz_vendor/social_media/common/EditorScreen/EditorScreen.dart';
import 'package:emagz_vendor/social_media/screens/home/story/controller/story_controller.dart';
import 'package:emagz_vendor/social_media/screens/post/text-post.dart';
import 'package:emagz_vendor/social_media/screens/settings/post/pre_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../../screens/auth/widgets/form_haeding_text.dart';
import '../../controller/bottom_nav_controller.dart';
import '../../controller/post/post_controller.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  RxBool isLoading = RxBool(false);
  @override
  void initState() {
    postController.imagePaths.clear();
    postController.images.clear();
    super.initState();
  }

  final postController = Get.put(PostController(), tag: "PostController");

  //String? fileExtension;
  bool isPoll = false;
  RxBool ispoll = RxBool(false);
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
      postController.setPost(pickedFile.path, PostType.text);

      Uint8List? image = await xFileToUint8List(pickedFile);
      Get.to(
          () => EditorScreen(
                image: [image],
              ),
          curve: Curves.bounceIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "  Post  ",
                        textAlign: TextAlign.left,
                        style: TextStyle(height: 2, fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                      GestureDetector(
                        onTap: () => (postController.imagePaths.isNotEmpty || postController.images.isNotEmpty)
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    maintainState: true,
                                    builder: (context) => EditorScreen(
                                          image: postController.images,
                                        ),
                                    fullscreenDialog: true))
                            : null,
                        child: SvgPicture.asset(
                          "assets/png/nextforward.svg",
                          height: 32,
                          width: 32,
                        ),
                      )
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => const TextPostScreen());
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.center,
                            height: 36,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(
                                255,
                                223,
                                236,
                                255,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              "Text",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff054BFF),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => setState(() {
                            isPoll = !isPoll;
                            if (!isPoll) {
                              postController.assetType = PostType.gallery;
                            } else {
                              postController.assetType = PostType.poll;
                            }
                          }),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.center,
                            height: 36,
                            decoration: BoxDecoration(
                              border: isPoll ? Border.all(color: const Color(0xff054BFF), width: 2.5) : null,
                              color: const Color(0xFFDFECFF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: FormHeadingText(
                              headings: "Poll",
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff054BFF),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        // InkWell(
                        //   onTap: () => setState(() => postController.assetType = PostType.gallery),
                        //   child: Container(
                        //     padding: const EdgeInsets.symmetric(horizontal: 30),
                        //     margin: const EdgeInsets.symmetric(horizontal: 10),
                        //     alignment: Alignment.center,
                        //     height: 36,
                        //     decoration: BoxDecoration(
                        //       color: const Color(0xffDFECFF),
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //     child: FormHeadingText(
                        //       headings: "Gallery",
                        //       fontWeight: FontWeight.bold,
                        //       color: const Color(0xff054BFF),
                        //       fontSize: 14,
                        //     ),
                        //   ),
                        // ),

                        // InkWell(
                        //   onTap: () => setState(() => postController.assetType = PostType.text),
                        //   child: Container(
                        //     padding: const EdgeInsets.symmetric(horizontal: 30),
                        //     margin: const EdgeInsets.symmetric(horizontal: 10),
                        //     alignment: Alignment.center,
                        //     height: 36,
                        //     decoration: BoxDecoration(
                        //       color: const Color(0xffDFECFF),
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //     child: InkWell(
                        //       onTap: () => setState(() => postController.assetType = PostType.gallery),
                        //       child: FormHeadingText(
                        //         headings: "v-Magz",
                        //         fontWeight: FontWeight.bold,
                        //         color: const Color(0xff054BFF),
                        //         fontSize: 14,
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        InkWell(
                          onTap: () async {
                            await _capturePhoto();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.center,
                            height: 36,
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
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Expanded(child: GridGallery())
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class GridGallery extends StatefulWidget {
  final bool isStory;
  const GridGallery({super.key, this.isStory = false});

  @override
  State<GridGallery> createState() => _GridGalleryState();
}

class _GridGalleryState extends State<GridGallery> {
  final List<Widget> _mediaList = [];
  int currentPage = 0;
  int? lastPage;
  RxBool longPressed = RxBool(false);
  final postController = Get.find<PostController>(tag: "PostController");
  final storyController = Get.find<GetXStoryController>(tag: "GetXStoryController");

  @override
  void initState() {
    super.initState();
    _fetchNewMedia();
  }

  _handleScrollEvent(ScrollNotification scroll) {
    if (scroll.metrics.pixels / scroll.metrics.maxScrollExtent > 0.33) {
      if (currentPage != lastPage) {
        _fetchNewMedia();
      }
    }
  }

  _fetchNewMedia() async {
    lastPage = currentPage;
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(onlyAll: true);
      List<AssetEntity> media = await albums[0].getAssetListPaged(size: 60, page: currentPage);
      RxList temp = <Widget>[].obs;
      for (var asset in media) {
        RxBool isSelected = RxBool(false);
        temp.add(
          FutureBuilder(
            future: asset.thumbnailDataWithSize(
              const ThumbnailSize(720, 1080),
            ),
            builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: InkWell(
                          onTap: () {
                            isSelected.value = !isSelected.value;
                            if (widget.isStory) {
                              if (isSelected.value) {
                                storyController.images.addIf(snapshot.data != null, snapshot.data!);
                                if (storyController.images.length == 1) {
                                  storyController.imagesNotEmpty.value = true;
                                }
                              } else {
                                storyController.images.remove(snapshot.data);
                                if (storyController.images.isEmpty) {
                                  storyController.imagesNotEmpty.value = false;
                                }
                              }
                            } else {
                              if (isSelected.value) {
                                postController.images.addIf(snapshot.data != null, snapshot.data!);
                              } else {
                                postController.images.remove(snapshot.data);
                              }
                            }
                          },
                          child: snapshot.data != null
                              ? Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: MemoryImage(
                                            snapshot.data!,
                                          ),
                                          fit: BoxFit.cover),
                                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                                      border: Border.all(width: 4, color: longPressed.value ? Colors.amber : Colors.transparent)),
                                )
                              : const SizedBox()),
                    ),
                    if (asset.type == AssetType.video)
                      const Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 5, bottom: 5),
                          child: Icon(
                            Icons.videocam,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    Obx(() => isSelected.value
                        ? const Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: 5, bottom: 5),
                              child: CircleAvatar(
                                radius: 13,
                                backgroundColor: Colors.blue,
                                child: Icon(
                                  Icons.check,
                                  size: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox())
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        );
      }
      setState(() {
        _mediaList.addAll(temp as Iterable<Widget>);
        currentPage++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scroll) {
        _handleScrollEvent(scroll);
        return false;
      },
      child: GridView.builder(
          itemCount: _mediaList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 5, crossAxisSpacing: 5),
          itemBuilder: (BuildContext context, int index) {
            return _mediaList[index];
          }),
    );
  }
}
