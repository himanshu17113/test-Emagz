import 'dart:ui' as UI;
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/common/EditorScreen/EditorScreen.dart';
import 'package:emagz_vendor/social_media/screens/post/text-post.dart';
import 'package:emagz_vendor/social_media/screens/settings/post/pre_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:screenshot/screenshot.dart';
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
  bool isLoading = false;

  final postController = Get.put(PostController());
  ScreenshotController screenshotController = ScreenshotController();
  Uint8List? imagePath;
  String? fileExtension;

  int index = -1;

  // Future addText(String fontName) async {
  //   const int size = 120;
  //   final ImageEditorOption option = ImageEditorOption();
  //   final AddTextOption textOption = AddTextOption();
  //   textOption.addText(
  //     EditorText(
  //       offset: const Offset(0, 0),
  //       text: "deepak",
  //       fontSizePx: size,
  //       textColor: const Color(0xFF995555),
  //       fontName: fontName,
  //     ),
  //   );
  //   option.outputFormat = const OutputFormat.png();

  //   option.addOption(textOption);

  //   // final Uint8List u = await getAssetImage();
  //   final Uint8List? result = await ImageEditor.editImage(
  //     image: postController.imagePath!,
  //     imageEditorOption: option,
  //   );
  //   print(option.toString());

  //   if (result == null) {
  //     return;
  //   }
  //   // target = MemoryImage(result);
  //   setState(() {});
  // }

  final GlobalKey _imageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: socialBack,
        //   appBar: const SocialHomeScreenAppBar(title: "eMAGZ"),
        body: Stack(children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // Obx(() {
                  //   return postController.isSettingImage.value
                  //       ? Container()
                  //       : postController.imagePath == null
                  //           ? SizedBox(
                  //               height: 250,
                  //               child: Center(
                  //                 child: FormHeadingText(
                  //                   headings: "No Image Selected",
                  //                   fontWeight: FontWeight.bold,
                  //                   color: Colors.black,
                  //                   fontSize: 14,
                  //                 ),
                  //               ),
                  //             )
                  //           : InteractiveViewer(
                  //               minScale: 0.75,
                  //               maxScale: 2.0,
                  //               child: Container(
                  //                 height: 250,
                  //                 decoration: BoxDecoration(
                  //                   image: DecorationImage(
                  //                     colorFilter: index == -1 ? null : ColorFilter.matrix(filters[index]),
                  //                     image: MemoryImage(postController.imagePath!),
                  //                   ),
                  //                 ),
                  //               ),
                  //             );
                  // }),

                  postController.imagePath == null
                      ? SizedBox(
                          height: 250,
                          child: Center(
                            child: FormHeadingText(
                              headings: "No Image Selected",
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        )
                      : Obx(() {
                          return postController.isSettingImage.value
                              ? Container()
                              : Container(
                                  height: 250,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        colorFilter: index == -1
                                            ? null
                                            : ColorFilter.matrix(
                                                filters[index]),
                                        image: MemoryImage(
                                            postController.imagePath!),
                                        fit: BoxFit.cover),
                                  ),
                                );
                        }),
                  //   SizedBox.expand(),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FormHeadingText(
                        headings: "Landscape",
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 12,
                      ),
                      FormHeadingText(
                        headings: "Portrait",
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 12,
                      ),
                      FormHeadingText(
                        headings: "Scale",
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 12,
                      ),
                      FormHeadingText(
                        headings: "Rotate",
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  postController.imagePath == null
                      ? Container()
                      : Container(
                          color: const Color(0xffDFECFF),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Obx(() {
                              return postController.isSettingImage.value
                                  ? Container()
                                  : postController.imagePath == null
                                      ? Container()
                                      : Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  index = -1;
                                                });
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    right: 10),
                                                height: 50,
                                                width: 70,
                                                key: _imageKey,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      // colorFilter: index == -1
                                                      //     ? null
                                                      //     : ColorFilter.matrix(filters[index]),
                                                      image: MemoryImage(
                                                          postController
                                                              .imagePath!),
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                            ),
                                            postController.isSettingImage.value
                                                ? Container()
                                                : postController.imagePath ==
                                                        null
                                                    ? Container()
                                                    : Row(
                                                        children: List.generate(
                                                          filters.length,
                                                          (index) => InkWell(
                                                            onTap: () async {
                                                              setState(() {
                                                                this.index =
                                                                    index;
                                                              });
                                                            },
                                                            child: Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          10),
                                                              height: 50,
                                                              width: 70,
                                                              decoration:
                                                                  BoxDecoration(
                                                                image: DecorationImage(
                                                                    colorFilter:
                                                                        ColorFilter.matrix(filters[
                                                                            index]),
                                                                    image: MemoryImage(
                                                                        postController
                                                                            .imagePath!),
                                                                    fit: BoxFit
                                                                        .cover),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                          ],
                                        );
                            }),
                          ),
                        ),
                  const SizedBox(
                    height: 15,
                  ),
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
                          // onTap: () {
                          //   setState(() {
                          //     postController.currentType?.value = PostType.text;
                          //   });
                          // },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () => setState(() => postController
                              .currentType?.value = PostType.poll),
                          child: Container(
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
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () => setState(() => postController
                              .currentType?.value = PostType.gallery),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        InkWell(
                          onTap: () => setState(() => postController
                              .currentType?.value = PostType.camera),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            alignment: Alignment.center,
                            height: 42,
                            decoration: BoxDecoration(
                              color: const Color(0xffDFECFF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              onTap: () => setState(() => postController
                                  .currentType?.value = PostType.gallery),
                              child: FormHeadingText(
                                headings: "v-Magz",
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
                        InkWell(
                          onTap: () => setState(() => postController
                              .currentType?.value = PostType.camera),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    height: 20,
                  ),
                  Expanded(child: GridGallery(
                    onPostTapped: (imageData, assetEntity) {
                      setState(() {});
                      fileExtension = assetEntity.mimeType!.split("/")[1];
                      if (assetEntity.type == AssetType.image) {
                        postController.setPost(imageData, PostAssetType.image);
                      } else if (assetEntity.type == AssetType.video) {
                        postController.setPost(imageData, PostAssetType.video);
                      } else {
                        postController.setPost(imageData, PostAssetType.image);
                      }
                    },
                  ))
                ],
              ),
            ),
          ),
          Obx(
            () => postController.isSettingImage.value
                ? Container()
                : postController.imagePath == null
                    ? Container()
                    : Positioned(
                        bottom: 70,
                        right: 30,
                        child: AnimatedOpacity(
                          opacity: postController.imagePath == null ? 0 : 1,
                          duration: const Duration(milliseconds: 500),
                          child: ElevatedButton(
                            child: Text(isLoading ? "loading..." : "next"),
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });

                              UI.Image realImage = await ScreenshotController
                                  .widgetToUiImage(index == -1
                                      ? Image.memory(postController.imagePath!)
                                      : ColorFiltered(
                                          colorFilter: ColorFilter.matrix(
                                              filters[index]),
                                          child: Image.memory(
                                              postController.imagePath!)));
                              var buffer = await realImage.toByteData(
                                  format: UI.ImageByteFormat.png);
                              var imageData =
                                  buffer!.buffer.asUint8List();
                              // var image = await screenshotController.capture();
                              // realImage.();
                              postController.setPost(
                                  imageData, postController.assetType!);
                              isLoading = false;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditorScreen(
                                        imageHeight: realImage.height,
                                        imageWidth: realImage.width,
                                        fileExtension: fileExtension,
                                        image: postController.imagePath,
                                        onSubmit: (editedImage) {
                                          postController.setPost(
                                              editedImage.readAsBytesSync(),
                                              postController.assetType!);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PrePostScreen(
                                                        postType:
                                                            PostType.gallery,
                                                        image: postController
                                                            .imagePath)),
                                          );
                                          //Get.off(() => PrePostScreen(postType: PostType.gallery, image: postController.imagePath));
                                        }),
                                  ));
                            },
                          ),
                        ),
                      ),
          )
        ]),
      ),
    );
  }
}

class GridGallery extends StatefulWidget {
  final ScrollController? scrollCtr;
  final void Function(Uint8List? imageData, AssetEntity assetEntity)?
      onPostTapped;
  const GridGallery({
    Key? key,
    this.onPostTapped,
    this.scrollCtr,
  }) : super(key: key);

  @override
  _GridGalleryState createState() => _GridGalleryState();
}

class _GridGalleryState extends State<GridGallery> {
  final List<Widget> _mediaList = [];
  int currentPage = 0;
  int? lastPage;
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
      List<AssetEntity> media = await albums[0]
          .getAssetListPaged(size: 60, page: currentPage); //preloading files
      List<Widget> temp = [];
      for (var asset in media) {
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
                        onTap: widget.onPostTapped == null
                            ? () async {
                                if (asset.type == AssetType.image) {
                                  postController.setPost(
                                      snapshot.data, PostAssetType.image);
                                } else if (asset.type == AssetType.video) {
                                  postController.setPost(
                                      snapshot.data, PostAssetType.video);
                                } else {
                                  postController.setPost(
                                      snapshot.data, PostAssetType.image);
                                }
                                postController.currentType?.value =
                                    PostType.gallery;
                                // File filr = File.fromRawPath(snapshot.data!);
                                // debugPrint(postController.imagePath.toString());

                                // debugPrint(snapshot.data.toString());
                                // setState(() {

                                if (mounted) {}
                                // await Navigator.push(
                                //todo look after
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => ImageEditor(
                                //       image: snapshot.data, // <-- Uint8List of image
                                //     ),
                                //   ),
                                // ).then((value) async {
                                //   await postController.setImage(value);
                                //   setState(() {
                                //     // postController.imagePath = snapshot.data;
                                //   });
                                // });
                                // });

                                //todo : STORY IMAGE VIEW

                                // Get.to(() => ImageStoryView(
                                //       snapshot: snapshot.data!,
                                //     ));
                              }
                            : () {
                                widget.onPostTapped!(snapshot.data, asset);
                              },
                        child: Image.memory(
                          snapshot.data!,
                          fit: BoxFit.cover,
                        ),
                      ),
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
                  ],
                );
              }
              return Container();
            },
          ),
        );
      }
      setState(() {
        _mediaList.addAll(temp);
        currentPage++;
      });
    } else {
      // fail
      /// if result is fail, you can call `PhotoManager.openSetting();`  to open android/ios applicaton's setting to get permission
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
