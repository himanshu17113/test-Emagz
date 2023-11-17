// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:emagz_vendor/social_media/screens/home/story/controller/story_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

import 'package:emagz_vendor/social_media/common/EditorScreen/colorfiltergenerater.dart';
import 'package:emagz_vendor/social_media/common/EditorScreen/widgets/DragabbleTextEditor.dart';
import 'package:emagz_vendor/social_media/screens/home/screens/post_view/widgets/glass.dart';
import 'package:emagz_vendor/social_media/screens/settings/post/pre_post_screen.dart';

import '../../utils/photo_filter.dart';

class EditorScreen extends StatefulWidget {
  // final Function(File editedImage)? onSubmit;
  final bool? isStory;
  final String? fileType;
  // final String? fileExtension;
  final List<Uint8List?> image;

  const EditorScreen({
    Key? key,
    this.isStory = false,
    this.fileType,
    required this.image,
  }) : super(key: key);

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  List<String> imagePaths = [];
  Future<List<String>> addPost(List<Uint8List> imagex) async {
    imagePaths.clear();
    List<String> path = [];
    for (var i = 0; i < imagex.length; i++) {
      final tempDir = await getTemporaryDirectory();
      File imageFile = await File('${tempDir.path}/image$i.jpg').create(); // this is the File object with the desired path and extension
      await imageFile.writeAsBytes(imagex[i]);
      // File imageFile = File.fromRawPath(
      //     imageBytes); // this creates a File object from the Uint8List
      path.add(imageFile.path);
      imagePaths.add(imageFile.path); // this adds the File object to the List
    }
    return path ?? imagePaths;
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: Colors.white24,
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(33)),
    ),
  );
  // final postController = Get.find<PostController>();
  final storyController = Get.find<GetXStoryController>(tag: "GetXStoryController");

  ScreenshotController screenshotControlle = ScreenshotController();
  List<ScreenshotController> screenshotController = [];
  int nIm = 0;
  int itemindex = 0;
  List<int> rotate = [];
  // List<GlobalKey> key = [];
  List<bool> crop = [];
  List<bool> transform = [];
  List<double> roatation = [];
  List<bool> enableRoatation = [];
  List<bool> enablebrightness = [];
  List<double> brightness = [];
  List<bool> enablehue = [];
  List<double> hue = [];
  List<bool> enablesaturation = [];
  List<double> saturation = [];
  List<bool> enableBlur = [];
  List<double> blur = [];
  List<int> filter = [];
  bool visibilty = true;
  bool crooped = false;
  final _controller = CropController();

  List<List<Widget>> editableItems = <List<Widget>>[];
  final List<List<double>> filters = [
    NONE,
    SEPIA_MATRIX,
    GREYSCALE_MATRIX,
    VINTAGE_MATRIX,
    FILTER_1,
    FILTER_2,
    FILTER_3,
    FILTER_4,
    FILTER_5,
  ];
  bool enableEffect = false;

  List<Uint8List> localImages = [];

  @override
  void initState() {
    nIm = widget.image.length;
    editableItems = List.generate(nIm, (i) => []);
    screenshotController = List.generate(nIm, (index) => ScreenshotController());
    //  key = List.generate(nIm, (index) => GlobalKey());
    crop = List.filled(nIm, false);
    transform = List.filled(nIm, false);
    rotate = List.filled(nIm, 0);
    filter = List.filled(nIm, 0);
    enablebrightness = List.filled(nIm, false);
    brightness = List.filled(nIm, 1.0);
    enablehue = List.filled(nIm, false);
    hue = List.filled(nIm, 1.0);
    enablesaturation = List.filled(nIm, false);
    saturation = List.filled(nIm, 1.0);
    enableBlur = List.filled(nIm, false);
    blur = List.filled(nIm, 0.0);
    enableRoatation = List.filled(nIm, false);
    roatation = List.filled(nIm, 0);

    super.initState();
  }

  final PageController _pageController = PageController();

  Future<Uint8List?> captureScreenshot(int i) async {
    await screenshotController[i].capture().then(
          (value) => localImages.addIf(value != null, value!),
        );
    return null;
  }

  // Future<Uint8List?> captureImage(int i) async {
  //   await Future.delayed(const Duration(milliseconds: 100));
  //   // RenderRepaintBoundary boundary = key[i].currentContext!.findRenderObject();
  //   //RenderRepaintBoundary bound = key[i].currentContext!.findRenderObject() as RenderRepaintBoundary;
  //   RenderRepaintBoundary bound =
  //   //    key[i].currentContext!.findRenderObject() as RenderRepaintBoundary;

  //   if (bound.debugNeedsPaint) {
  //     Timer(const Duration(seconds: 1), () => captureImage(i));
  //     return null;
  //   }
  //   ui.Image image = await bound.toImage();
  //   ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

  //   if (byteData != null) {
  //     Uint8List pngBytes = byteData.buffer.asUint8List();
  //     localImages.add(pngBytes);
  //     return pngBytes;
  //   }
  //   return null;
  // }

  Future<void> convertWidgetToImage() async {
    _pageController.jumpToPage(0);
    localImages.clear();
    for (int i = 0; i < nIm; i++) {
      await _pageController.animateToPage(i, duration: const Duration(milliseconds: 100), curve: Curves.easeInOut).then((value) async => await captureScreenshot(i));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        bottomOpacity: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: visibilty
            ? Row(
                children: [
                  // IconButton(
                  //     onPressed: () async {},
                  //     icon: const Icon(Icons.more_vert)),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          visibilty = false;
                        });
                        showDialog(
                          context: context,
                          builder: (context) {
                            return DraggableTextEditor(
                              text: "",
                              style: const TextStyle(),
                              onSubmit: (text, style) {
                                Navigator.pop(context);

                                editableItems[itemindex].add(DraggableText(
                                  text: text,
                                  style: style,
                                  position: const Offset(200, 200),
                                ));
                              },
                            );
                          },
                        ).then((value) => setState(() {
                              visibilty = true;
                            }));
                      },
                      icon: const Icon(Icons.text_fields)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.music_note,
                      ))
                ],
              )
            : null,
        actions: [
          IconButton(
            onPressed: () async {
              showDialog(
                useSafeArea: true,
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.amberAccent,
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              );
              await convertWidgetToImage();
              // .then((value) async {
              //   if (widget.isStory!) {
              //     //    await addPost(localImages);
              //     // storyController.postStory("images", imagePaths);
              //   } else {
              //     //Navigator.of(context, rootNavigator: true).pop();
              //     Get.to(() => PrePostScreen(postType: PostType.gallery, images: localImages));
              //   }
              // });
              if (widget.isStory!) {
                // var paths = await addPost(localImages);
                debugPrint("posting story");
                bool x = await storyController.postStory("images", localImages);
                if (x) {
                  Get.close(2);
                }
              } else {
                Navigator.of(context, rootNavigator: true).pop();
                Get.to(() => PrePostScreen(postType: PostType.gallery, images: localImages));
              }

              debugPrint("edited image length ${localImages.length}");
            },
            icon: SvgPicture.asset(
              "assets/png/nextforward.svg",
              height: 32,
              width: 32,
            ),
          )
        ],
      ),
      body: PageView(
          // clipBehavior: Clip.antiAliasWithSaveLayer,
          physics: const PageScrollPhysics(),
          scrollBehavior: const MaterialScrollBehavior(),
          scrollDirection: Axis.horizontal,
          controller: _pageController,
          onPageChanged: (value) => setState(() {
                //       currentimage = widget.image[value];
                debugPrint("pageViewIndex  $value");
                itemindex = value;
              }),
          children: List.generate(
              nIm,
              growable: false,
              (itemIndex) => Center(
                    child: Screenshot(
                      controller: screenshotController[itemIndex],
                      child: Stack(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        children: [
                          Transform.rotate(
                            angle: roatation[itemIndex],
                            child: Transform.flip(
                              flipX: transform[itemIndex],
                              //    flipY: transform[itemIndex],
                              child: RotatedBox(
                                quarterTurns: rotate[itemIndex],
                                child: crop[itemIndex]
                                    ? imagefilter(
                                        blur: blur[itemIndex],
                                        hue: hue[itemIndex] - 1,
                                        brightness: brightness[itemIndex] - 1,
                                        saturation: saturation[itemIndex] - 1,
                                        child: ColorFiltered(
                                          colorFilter: ColorFilter.matrix(filters[filter[itemIndex]]),
                                          child: Crop(
                                            initialSize: 0.9,
                                            baseColor: Colors.black12,
                                            controller: _controller,
                                            image: widget.image[itemIndex]!,
                                            onCropped: (cropped) {
                                              debugPrint("cropped");
                                              widget.image[itemIndex] = cropped;
                                              setState(() {
                                                crop[itemindex] = !crop[itemindex];
                                              });
                                            },
                                          ),
                                        ),
                                      )
                                    : Container(
                                        color: Colors.amber,
                                        child: imagefilter(
                                            blur: blur[itemIndex],
                                            hue: hue[itemIndex] - 1,
                                            brightness: brightness[itemIndex] - 1,
                                            saturation: saturation[itemIndex] - 1,
                                            child: ColorFiltered(colorFilter: ColorFilter.matrix(filters[filter[itemIndex]]), child: Image.memory(widget.image[itemIndex]!))),
                                      ),
                              ),
                            ),
                          ),
                          ...editableItems[itemIndex]
                        ],
                      ),
                    ),
                  ))),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: !enableEffect
            ? enablebrightness[itemindex]
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (enablebrightness[itemindex]) ...[
                        Padding(
                            padding: const EdgeInsets.only(bottom: 10, right: 25),
                            child: ElevatedButton(
                              style: raisedButtonStyle,
                              onPressed: () => setState(() => enablebrightness[itemindex] = false),
                              child: const Text(' Done '),
                            ))
                      ],
                      Slider(
                        secondaryActiveColor: Colors.cyanAccent,
                        thumbColor: Colors.white,
                        activeColor: Colors.white70,
                        inactiveColor: Colors.white24,
                        value: brightness[itemindex],
                        onChanged: (value) {
                          setState(() {
                            brightness[itemindex] = value;
                          });
                        },
                        min: 0.0,
                        max: 2.0,
                        label: 'Brightness: $brightness',
                      ),
                    ],
                  )
                : enablehue[itemindex] || enablesaturation[itemindex] || enableBlur[itemindex]
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (enablehue[itemindex] || enablesaturation[itemindex]) ...[
                            Padding(
                                padding: const EdgeInsets.only(bottom: 10, right: 25),
                                child: ElevatedButton(
                                  style: raisedButtonStyle,
                                  onPressed: () => setState(() {
                                    enablehue[itemindex] = false;

                                    enablesaturation[itemindex] = false;
                                  }),
                                  child: const Text(' Done '),
                                ))
                          ],
                          const Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "     Hue",
                              textAlign: TextAlign.start,
                              textDirection: TextDirection.ltr,
                              style: TextStyle(color: Colors.white60, fontSize: 18),
                            ),
                          ),
                          Slider(
                            secondaryActiveColor: Colors.cyanAccent,
                            thumbColor: Colors.white,
                            activeColor: Colors.white70,
                            inactiveColor: Colors.white24,
                            value: hue[itemindex],
                            onChanged: (value) {
                              setState(() {
                                hue[itemindex] = value;
                              });
                            },
                            min: 0.0,
                            max: 2.0,
                            label: 'Hue : ${hue[itemindex]}',
                          ),
                          const Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "     Saturation",
                              textAlign: TextAlign.start,
                              textDirection: TextDirection.ltr,
                              style: TextStyle(color: Colors.white60, fontSize: 18),
                            ),
                          ),
                          Slider(
                            secondaryActiveColor: Colors.cyanAccent,
                            thumbColor: Colors.white,
                            activeColor: Colors.white70,
                            inactiveColor: Colors.white24,
                            value: saturation[itemindex],
                            onChanged: (value) {
                              setState(() {
                                saturation[itemindex] = value;
                              });
                            },
                            min: 0.0,
                            max: 2.0,
                            label: 'Saturation: ${saturation[itemindex]}',
                          ),
                          const Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "     Blur",
                              textAlign: TextAlign.start,
                              textDirection: TextDirection.ltr,
                              style: TextStyle(color: Colors.white60, fontSize: 18),
                            ),
                          ),
                          Slider(
                            secondaryActiveColor: Colors.cyanAccent,
                            thumbColor: Colors.white,
                            activeColor: Colors.white70,
                            inactiveColor: Colors.white24,
                            value: blur[itemindex],
                            onChanged: (value) {
                              setState(() {
                                blur[itemindex] = value;
                              });
                            },
                            min: 0.0,
                            max: 5,
                            label: 'blur: ${saturation[itemindex]}',
                          ),
                        ],
                      )
                    : enableRoatation[itemindex]
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (enableRoatation[itemindex]) ...[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                                      child: GlassmorphicContainer(
                                        borderRadius: 33,
                                        blur: 2.5,
                                        height: 40,
                                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                                        colour: Colors.white24,
                                        child: IconButton(
                                          style: const ButtonStyle(
                                            padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 15)),
                                            splashFactory: InkSparkle.splashFactory,
                                          ),
                                          onPressed: () => setState(() => rotate[itemindex]++),
                                          icon: const Icon(Icons.rotate_right, color: Colors.white70),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(bottom: 10, right: 25),
                                        child: ElevatedButton.icon(
                                          style: raisedButtonStyle,
                                          onPressed: () => setState(() => transform[itemindex] = !transform[itemindex]),
                                          icon: const Icon(Icons.flip, color: Colors.white70),
                                          label: const Text(' Transform '),
                                        )),
                                    Padding(
                                        padding: const EdgeInsets.only(bottom: 10, right: 25),
                                        child: ElevatedButton(
                                          style: raisedButtonStyle,
                                          onPressed: () => setState(() => enableRoatation[itemindex] = false),
                                          child: const Text(' Done '),
                                        )),
                                  ],
                                )
                              ],
                              Slider(
                                secondaryActiveColor: Colors.cyanAccent,
                                thumbColor: Colors.white,
                                activeColor: Colors.white70,
                                inactiveColor: Colors.white24,
                                value: roatation[itemindex],
                                onChanged: (value) {
                                  setState(() {
                                    roatation[itemindex] = value;
                                  });
                                },
                                min: 0.0,
                                max: pi,
                                label: 'Roatation: ${roatation[itemindex]}',
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (crop[itemindex]) ...[
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10, right: 25),
                                  child: ElevatedButton(
                                    style: raisedButtonStyle,
                                    onPressed: () {
                                      _controller.crop();
                                    },
                                    child: const Text(' Done '),
                                  ),
                                )
                              ],
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: GlassmorphicContainer(
                                        borderRadius: 33,
                                        blur: 2.5,
                                        height: 40,
                                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                                        colour: Colors.white24,
                                        child: TextButton.icon(
                                          style: const ButtonStyle(
                                            padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 15)),
                                            splashFactory: InkSparkle.splashFactory,
                                          ),
                                          onPressed: () => setState(() => enableRoatation[itemindex] = true),
                                          icon: const Icon(Icons.rotate_right, color: Colors.white70),
                                          label: const Text(
                                            "Rotate ",
                                            style: TextStyle(color: Colors.white70, fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GlassmorphicContainer(
                                        borderRadius: 33,
                                        blur: 2.5,
                                        height: 40,
                                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                        colour: Colors.white24,
                                        child: TextButton.icon(
                                          style: const ButtonStyle(
                                            padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 15)),
                                            splashFactory: InkSparkle.splashFactory,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              crop[itemindex] = !crop[itemindex];
                                            });
                                          },
                                          icon: const Icon(Icons.crop, color: Colors.white70),
                                          label: const Text(
                                            "Crop ",
                                            style: TextStyle(color: Colors.white70, fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GlassmorphicContainer(
                                        borderRadius: 33,
                                        blur: 2.5,
                                        height: 40,
                                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                        colour: Colors.white24,
                                        child: TextButton.icon(
                                          style: const ButtonStyle(
                                            padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 15)),
                                            splashFactory: InkSparkle.splashFactory,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              enablebrightness[itemindex] = true;
                                            });
                                          },
                                          icon: const Icon(Icons.wb_sunny_outlined, color: Colors.white70),
                                          label: const Text(
                                            "Adjustment ",
                                            style: TextStyle(color: Colors.white70, fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GlassmorphicContainer(
                                        borderRadius: 33,
                                        blur: 2.5,
                                        height: 40,
                                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                        colour: Colors.white24,
                                        child: TextButton.icon(
                                          style: const ButtonStyle(
                                            padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 15)),
                                            splashFactory: InkSparkle.splashFactory,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              enableEffect = true;
                                            });
                                          },
                                          icon: const Icon(Icons.colorize, color: Colors.white70),
                                          label: const Text(
                                            "Effects ",
                                            style: TextStyle(color: Colors.white70, fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GlassmorphicContainer(
                                        borderRadius: 33,
                                        blur: 2.5,
                                        height: 40,
                                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                        colour: Colors.white24,
                                        child: TextButton.icon(
                                          style: const ButtonStyle(
                                            padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 15)),
                                            splashFactory: InkSparkle.splashFactory,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              enablehue[itemindex] = !enablehue[itemindex];
                                              enablesaturation[itemindex] = !enablesaturation[itemindex];
                                            });
                                          },
                                          icon: const Icon(Icons.adjust, color: Colors.white70),
                                          label: const Text(
                                            "Filter",
                                            style: TextStyle(color: Colors.white70, fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: InkWell(
                        onTap: () => setState(() {
                              enableEffect = false;
                            }),
                        child: const CircleAvatar(
                          backgroundColor: Colors.white24,
                          child: Icon(
                            Icons.undo_rounded,
                            color: Colors.white,
                          ),
                        )),
                  ),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          filters.length,
                          (index) => InkWell(
                            onTap: () {
                              setState(() {
                                filter[itemindex] = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: filter[itemindex] != index ? null : Border.all(color: const Color.fromRGBO(53, 222, 217, 1), width: 2),
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Colors.purple.shade900,
                                    Colors.purple.shade100,
                                  ],
                                ),
                                image: DecorationImage(colorFilter: ColorFilter.matrix(filters[index]), image: MemoryImage(widget.image[itemindex]!), fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ),
                      )),
                ],
              ),
      ),
    );
  }

  Widget imagefilter({brightness, saturation, hue, child, blur}) {
    return ColorFiltered(
        colorFilter: ColorFilter.matrix(Colorfiltergenerator.brightnessadjustmatrix(
          value: brightness,
        )),
        child: ColorFiltered(
            colorFilter: ColorFilter.matrix(Colorfiltergenerator.saturationadjustmatrix(
              value: saturation,
            )),
            child: ColorFiltered(
                colorFilter: ColorFilter.matrix(Colorfiltergenerator.hueadjustmatrix(
                  value: hue,
                )),
                child: Stack(children: [
                  child,
                  BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur * 2),
                      child: const ColoredBox(
                        color: Colors.white10,
                      )),
                ]))));
  }
}

class DraggableText extends StatefulWidget {
  String text;
  TextStyle style;
  Offset position;
  DraggableText({
    Key? key,
    required this.text,
    required this.style,
    required this.position,
  }) : super(key: key);

  @override
  State<DraggableText> createState() => _DraggableTextState();
}

class _DraggableTextState extends State<DraggableText> {
  Offset position = const Offset(200, 600);

  Offset startPosition = const Offset(200, 400);

  @override
  Widget build(BuildContext context) {
    debugPrint(position.toString());
    return AnimatedPositioned(
      top: widget.position.dy,
      left: widget.position.dx,
      duration: const Duration(milliseconds: 50),
      child: GestureDetector(
        onPanStart: (details) {
          startPosition = details.globalPosition - widget.position;
        },
        onPanUpdate: (details) {
          setState(() {
            widget.position = details.globalPosition - startPosition;
          });
        },
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return DraggableTextEditor(
                    onSubmit: (text, style) {
                      widget.text = text;
                      widget.style = style;

                      Navigator.pop(context);
                    },
                    text: widget.text,
                    style: widget.style);
              },
            );
          },
          child: SizedBox(width: context.width / 2, child: Text(widget.text, style: widget.style)),
        ),
      ),
    );
  }
}
