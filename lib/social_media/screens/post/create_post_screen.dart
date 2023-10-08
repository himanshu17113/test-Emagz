import 'dart:io';
import 'dart:ui' as UI;
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/common/EditorScreen/EditorScreen.dart';
import 'package:emagz_vendor/social_media/screens/post/text-post.dart';
import 'package:emagz_vendor/social_media/screens/settings/post/pre_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import '../../../screens/auth/widgets/form_haeding_text.dart';
import '../../controller/post/post_controller.dart';
import '../../utils/photo_filter.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final List<List<double>> filters = [
    SEPIA_MATRIX,
    GREYSCALE_MATRIX,
    VINTAGE_MATRIX,
    FILTER_1,
    FILTER_2,
    FILTER_3,
    FILTER_4,
    FILTER_5,
  ];
  RxBool isLoading = RxBool(false);
  @override
  void initState() {
    postController.imagePaths.clear();
    postController.images.clear();
    super.initState();
  }

  final postController = Get.put(PostController());
  Uint8List? imagePath;
  String? fileExtension;

  int index = -1;
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
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      postController.setPost(pickedFile.path, PostType.text);

      Uint8List? image = await xFileToUint8List(pickedFile);
      Get.to(
          () => EditorScreen(
              fileExtension: fileExtension,
              image: [image],
              onSubmit: (editedImage) {
                //postController.setPost(editedImage.path, PostType.text);
                postController.imagePaths.add(editedImage.path);
                Get.off(() => PrePostScreen(
                    postType: PostType.text, image: editedImage.path));
              }),
          curve: Curves.bounceIn);
    }
  }

  final GlobalKey _imageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: socialBack,
        body: Stack(children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  // postController.imagePath == null
                  //     ? SizedBox(
                  //         height: 250,
                  //         child: Center(
                  //           child: FormHeadingText(
                  //             headings: "No Image Selected",
                  //             fontWeight: FontWeight.bold,
                  //             color: Colors.black,
                  //             fontSize: 14,
                  //           ),
                  //         ),
                  //       )
                  //     : postController.isSettingImage.value
                  //         ? const SizedBox(
                  //             height: 10,
                  //           )
                  //         : Container(
                  //             height: context.height * .33,
                  //             padding: const EdgeInsets.only(bottom: 10),
                  //             decoration: BoxDecoration(
                  //               image: DecorationImage(
                  //                   colorFilter: index == -1
                  //                       ? null
                  //                       : ColorFilter.matrix(filters[index]),
                  //                   image:
                  //                       MemoryImage(postController.imagePath!),
                  //                   fit: BoxFit.fitHeight),
                  //             ),
                  //           ),

                  // const Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       "Landscape",
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.black,
                  //         fontSize: 12,
                  //       ),
                  //     ),
                  //     Text("Portrait",
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.black,
                  //           fontSize: 12,
                  //         )),
                  //     Text("Rotate",
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.black,
                  //           fontSize: 12,
                  //         )),
                  //     Text("Scale",
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.black,
                  //           fontSize: 12,
                  //         )),
                  //   ],
                  // ),
                  // postController.imagePath == null
                  //     ? const SizedBox(
                  //         height: 10,
                  //       )
                  //     : SingleChildScrollView(
                  //         scrollDirection: Axis.horizontal,
                  //         child: postController.isSettingImage.value &&
                  //                 postController.imagePath != null
                  //             ? const SizedBox()
                  //             : Row(
                  //                 children: [
                  //                   InkWell(
                  //                     onTap: () {
                  //                       setState(() {
                  //                         index = -1;
                  //                       });
                  //                     },
                  //                     child: Container(
                  //                       margin:
                  //                           const EdgeInsets.only(right: 10),
                  //                       height: 70,
                  //                       width: 70,
                  //                       key: _imageKey,
                  //                       decoration: BoxDecoration(
                  //                         image: DecorationImage(
                  //                             image: MemoryImage(
                  //                                 postController.imagePath!),
                  //                             fit: BoxFit.cover),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   Row(
                  //                     children: List.generate(
                  //                       filters.length,
                  //                       (index) => InkWell(
                  //                         onTap: () async {
                  //                           setState(() {
                  //                             this.index = index;
                  //                           });
                  //                         },
                  //                         child: Container(
                  //                           margin: const EdgeInsets.only(
                  //                               right: 10),
                  //                           height: 70,
                  //                           width: 70,
                  //                           decoration: BoxDecoration(
                  //                             image: DecorationImage(
                  //                                 colorFilter:
                  //                                     ColorFilter.matrix(
                  //                                         filters[index]),
                  //                                 image: MemoryImage(
                  //                                     postController
                  //                                         .imagePath!),
                  //                                 fit: BoxFit.cover),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               )),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Post",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          height: 2, fontSize: 25, fontWeight: FontWeight.w600),
                    ),
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
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.center,
                            height: 42,
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
                          onTap: () => setState(
                              () => postController.assetType = PostType.poll),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            alignment: Alignment.center,
                            height: 42,
                            decoration: BoxDecoration(
                              color: const Color(0xffDFECFF),
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
                        InkWell(
                          onTap: () => setState(() =>
                              postController.assetType = PostType.gallery),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
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
                        InkWell(
                          onTap: () => setState(
                              () => postController.assetType = PostType.text),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.center,
                            height: 42,
                            decoration: BoxDecoration(
                              color: const Color(0xffDFECFF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              onTap: () => setState(() =>
                                  postController.assetType = PostType.gallery),
                              child: FormHeadingText(
                                headings: "v-Magz",
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff054BFF),
                                fontSize: 14,
                              ),
                            ),
                          ),
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
                  const Expanded(
                      child: GridGallery(
                          //     onPostTapped: (imageData, assetEntity) {
                          // //      setState(() {});
                          //       fileExtension = assetEntity.mimeType!.split("/")[1];
                          //       if (assetEntity.type == AssetType.image) {
                          //         postController.setPost(imageData, PostType.gallery);
                          //       } else if (assetEntity.type == AssetType.video) {
                          //         postController.setPost(imageData, PostType.gallery);
                          //       } else {
                          //         postController.setPost(imageData, PostType.gallery);
                          //       }
                          //     },
                          //     onPostSelected: (imageData, assetEntity) {
                          //       setState(() {});
                          //       fileExtension = assetEntity.mimeType!.split("/")[1];
                          //       if (assetEntity.type == AssetType.image) {
                          //         postController.setPost(imageData, PostType.gallery);
                          //       } else if (assetEntity.type == AssetType.video) {
                          //         postController.setPost(imageData, PostType.gallery);
                          //       } else {
                          //         postController.setPost(imageData, PostType.gallery);
                          //       }
                          //     },
                          ))
                ],
              ),
            ),
          ),
          // if (!postController.isSettingImage.value &&
          //     postController.imagePath != null)

          (postController.imagePaths.isNotEmpty ||
                  postController.images.isNotEmpty)
              ? Positioned(
                  bottom: 70,
                  right: 30,
                  child: ElevatedButton(
                    child: Obx(
                        () => Text(isLoading.value ? "loading..." : "next")),
                    onPressed: () async {
                      //  setState(() {
                      isLoading.value = true;
                      //   });

                      // UI.Image realImage =
                      //     await ScreenshotController.widgetToUiImage(index == -1
                      //         ? Image.memory(postController.imagePath!)
                      //         : ColorFiltered(
                      //             colorFilter:
                      //                 ColorFilter.matrix(filters[index]),
                      //             child:
                      //                 Image.memory(postController.imagePath!)));
                      // var buffer = await realImage.toByteData(
                      //     format: UI.ImageByteFormat.png);
                      // var imageData = buffer!.buffer.asUint8List();

                      // postController.setPost(
                      //     imageData, postController.assetType!);

                      // isLoading.value = false;

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditorScreen(
                                  fileExtension: fileExtension,
                                  image: postController.images,
                                  // onSubmit: (editedImage) {
                                  //   postController.uploadPost(editedImage.path);
                                  //   Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => PrePostScreen(
                                  //             postType: PostType.text,
                                  //             image: editedImage.path)),
                                  //   );
                                  // },
                                  // onSubmitS: (editedImage) {
                                  //   debugPrint(
                                  //       "image submit ${editedImage.length}");
                                  //   postController.images = editedImage;
                                  //   Get.to(() => PrePostScreen(
                                  //       postType: PostType.gallery,
                                  //       images: postController.images));
                                  //   // Navigator.push(
                                  //   //   context,
                                  //   //   MaterialPageRoute(
                                  //   //       builder: (context)=> PrePostScreen(
                                  //   //           postType: PostType.gallery,
                                  //   //           images: postController.images)

                                  //   //      ),
                                  //   // );
                                  // }
                                  ),
                              fullscreenDialog: true));
                    },
                  ),
                )
              : const SizedBox(),
        ]),
      ),
    );
  }
}

class GridGallery extends StatefulWidget {
  final ScrollController? scrollCtr;
  final void Function(Uint8List? imageData, AssetEntity assetEntity)?
      onPostTapped;
  final void Function(Uint8List? imageData, AssetEntity assetEntity)?
      onPostSelected;
  const GridGallery({
    Key? key,
    this.onPostTapped,
    this.scrollCtr,
    this.onPostSelected,
  }) : super(key: key);

  @override
  _GridGalleryState createState() => _GridGalleryState();
}

class _GridGalleryState extends State<GridGallery> {
  final List<Widget> _mediaList = [];
  int currentPage = 0;
  int? lastPage;
  RxBool longPressed = RxBool(false);
  final postController = Get.put(PostController());
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
      List<AssetPathEntity> albums =
          await PhotoManager.getAssetPathList(onlyAll: true);
      List<AssetEntity> media =
          await albums[0].getAssetListPaged(size: 60, page: currentPage);
      RxList temp = <Widget>[].obs;
      for (var asset in media) {
        RxBool isSelected = RxBool(false);
        temp.add(
          FutureBuilder(
            future: asset.thumbnailDataWithSize(
              const ThumbnailSize(720, 1080),
            ),
            builder:
                (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: InkWell(
                          onTap: () {
                            isSelected.value = !isSelected.value;
                            if (isSelected.value) {
                              postController.images.add(snapshot.data);
                            } else {
                              postController.images.remove(snapshot.data);
                            }
                            //   if (asset.type == AssetType.image) {
                            //     postController.setPost(
                            //         snapshot.data, PostType.gallery);
                            //   } else if (asset.type == AssetType.video) {
                            //     postController.setPost(
                            //         snapshot.data, PostType.gallery);
                            //   } else {
                            //     postController.setPost(
                            //         snapshot.data, PostType.gallery);
                            //   }
                            //   postController.assetType = PostType.gallery;
                          },
                          child: snapshot.data != null
                              ? Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: MemoryImage(
                                            snapshot.data!,
                                          ),
                                          fit: BoxFit.cover),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8)),
                                      border: Border.all(
                                          width: 4,
                                          color: longPressed.value
                                              ? Colors.amber
                                              : Colors.transparent)),
                                  // child: Image.memory(
                                  //   snapshot.data!,
                                  //   fit: BoxFit.cover,
                                  // ),
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
                              child: Icon(
                                Icons.circle,
                                color: Colors.grey,
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
          controller: widget.scrollCtr,
          itemCount: _mediaList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 5, crossAxisSpacing: 5),
          itemBuilder: (BuildContext context, int index) {
            return _mediaList[index];
          }),
    );
  }
}
