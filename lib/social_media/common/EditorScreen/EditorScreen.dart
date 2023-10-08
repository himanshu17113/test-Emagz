import 'dart:io';
import 'dart:ui';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:emagz_vendor/social_media/common/EditorScreen/colorfiltergenerater.dart';
import 'package:emagz_vendor/social_media/controller/post/post_controller.dart';
import 'package:emagz_vendor/social_media/screens/home/screens/post_view/widgets/glass.dart';
import 'package:emagz_vendor/social_media/screens/settings/post/pre_post_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';
import 'package:emagz_vendor/social_media/common/EditorScreen/widgets/DragabbleTextEditor.dart';
import '../../utils/photo_filter.dart';

class EditorScreen extends StatefulWidget {
  final Function(File editedImage)? onSubmit;
  // final Function(List<File> editedImage)? onSubmits;
  // final Function(List<Uint8List?> editedImage)? onSubmitS;

  final String? fileType;
  final String? fileExtension;
  final List<Uint8List?> image;

  const EditorScreen(
      {super.key,
      this.onSubmit,
      required this.image,
      this.fileType,
      required this.fileExtension,
      // this.onSubmits,
  //    this.onSubmitS
      });

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.white,
    backgroundColor: Colors.white24,
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(33)),
    ),
  );
  final postController = Get.find<PostController>();
///  List<ScreenshotController> screenshotController = [];
  ScreenshotController screenshotControlle = ScreenshotController();
  int nIm = 0;
  int itemindex = 0;
  List<int> rotate = [];
  List<bool> crop = [];
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
  //List<GlobalKey> _widgetKeys = [];

//  final GlobalKey<ScreenshotController> _formKey = GlobalKey<FormState>();
  //final GlobalKey _key = GlobalKey(debugLabel: "kew");
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
  Uint8List? currentimage;
  List<Uint8List?> localImages = [];
  @override
  void initState() {
    currentimage = widget.image[0];

    nIm = widget.image.length;
 //   _widgetKeys = List.filled(nIm, GlobalKey());
    // screenshotController =
    //     List.filled(nIm, ScreenshotController(), growable: false);
    // screenshotController =
    //     List.generate(nIm, (i) => ScreenshotController(), growable: false);
    editableItems = List.filled(nIm, []);
    crop = List.filled(nIm, false);
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
    super.initState();
  }

  final PageController _pageController =
      PageController(); // Create a PageController

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
                  IconButton(
                      onPressed: () async {
                        
                      },
                      icon: const Icon(Icons.more_vert)),
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
                      onPressed: () async {
                        // Future<void> captureWidget(Widget widget) async {
                        //   RenderRepaintBoundary boundary =
                        //       RenderRepaintBoundary();
                        //   RenderBox renderBox = boundary.c
                        //       .findRenderObject() as RenderBox;
                        //   final image = await renderBox.toImage();
                        //   final byteData = await image.toByteData(
                        //       format: ImageByteFormat.png);
                        //   final pngBytes = byteData.buffer.asUint8List();

                        //   // Handle the pngBytes (save, share, etc.)
                        // }

                        for (int i = 0; i < nIm; i++) {
                          _pageController.jumpToPage(i);
                          // await Future.delayed(const Duration(
                          //     seconds:
                          //         1)); // Wait for the page to settle (optional)

                          screenshotControlle
                              .capture(delay: Duration.zero)
                              .then((capturedImage) async {
                            localImages.add(capturedImage);
                          });
                        }
                        //     postController.images = images;
                        Get.to(() => PrePostScreen(
                            postType: PostType.gallery, images: localImages));
                      },
                      icon: const Icon(
                        Icons.music_note,
                      ))
                ],
              )
            : null,
        actions: [
          IconButton(
              onPressed: () {
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
                images.clear();
//                 for (int i = 0; i < screenshotController.length; i++) {
//                   screenshotController[i]
//                       .capture(delay: Duration.zero)
//                       .then((capturedImage) async {
//                     images.add(capturedImage);
// //   Uint8List? editedImage = capturedImage; //
//                     File imageFile = File.fromRawPath(capturedImage!);
//                     // final tempDir = await getTemporaryDirectory();
//                     // final File file =
//                     //     await File("${tempDir.path}.jpeg").create();
//                     // await file.writeAsBytes(capturedImage);
//                     debugPrint("imag ${images.length}");
//                     // postController.imagePaths.add(file.path);
//                     postController.imagePaths.add(imageFile.path);

//                     if (images.length == screenshotController.length) {
//                       Navigator.of(context, rootNavigator: true).pop();
//                       debugPrint("images ${images.length}");
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => PrePostScreen(
//                                 postType: PostType.gallery,
//                                 images: postController.images)),
//                       );
//                       //   widget.onSubmitS!(images);
//                     }
//                     //   Uint8List? editedImage = capturedImage;
//                     //   final tempDir = await getTemporaryDirectory();
//                     // final  File file = await File("${tempDir.path}.jpeg").create();
//                     //   await file.writeAsBytes(editedImage!);
//                   }).catchError((onError) {
//                     debugPrint(onError.toString());
//                   });
//                 }
              },
              icon: const Icon(Icons.arrow_right_alt))
        ],
      ),
      body: Center(
          //    child: PageView.builder(
          child: Screenshot(
        controller: screenshotControlle,
        child: PageView(
            //       key: UniqueKey(),
            physics: const PageScrollPhysics(),
            scrollBehavior: const MaterialScrollBehavior(),
            scrollDirection: Axis.horizontal,
            //   itemCount: nIm,
            controller: _pageController,
            //PageController(),
            onPageChanged: (value) => setState(() {
                  currentimage = widget.image[value];
                  debugPrint("pageViewIndex  $value");
                  itemindex = value;
                }),
            // allowImplicitScrolling: true,
            // padEnds: false,
            // itemBuilder: (BuildContext context, int itemIndex) {
            //  return
            children: List.generate(
                nIm,
                growable: false,
                (itemIndex) =>
                    //  growable: true,)
                    InteractiveViewer(
                      //    key: _widgetKeys[itemIndex],
                      //   key: _key,
                      //  key: ValueKey(itemIndex),
                      // PageStorageKey(itemIndex),
                      //    key: UniqueKey(),
                      // _formKey,

                      //   UniqueKey(),
                      minScale: 1,
                      maxScale: 4,
                      child: Stack(
                        children: [
                          RotatedBox(
                            quarterTurns: rotate[itemIndex],
                            child: crop[itemIndex]
                                ? imagefilter(
                                    blur: blur[itemIndex],
                                    hue: hue[itemIndex] - 1,
                                    brightness: brightness[itemIndex] - 1,
                                    saturation: saturation[itemIndex] - 1,
                                    child: ColorFiltered(
                                      colorFilter: ColorFilter.matrix(
                                          filters[filter[itemIndex]]),
                                      child: Crop(
                                        initialSize: 0.9,
                                        //     interactive: true,
                                        //  maskColor: Colors.blue,
                                        baseColor: Colors.black12,
                                        controller: _controller,
                                        image: widget.image[itemIndex]!,
                                        onCropped: (cropped) {
                                          debugPrint("cropped");
                                          widget.image[itemIndex] = cropped;
                                          setState(() {
                                            crop[itemindex] = !crop[itemindex];
                                          });
                                          // any action using cropped data
                                        },
                                      ),
                                    ),
                                  )
                                : imagefilter(
                                    blur: blur[itemIndex],
                                    hue: hue[itemIndex] - 1,
                                    brightness: brightness[itemIndex] - 1,
                                    saturation: saturation[itemIndex] - 1,
                                    // colorFilter: ColorFilter.mode(
                                    //     Colors.white
                                    //         .withOpacity(brightness[itemIndex]),
                                    //     BlendMode.modulate),
                                    child: Container(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                          image: widget.image[itemIndex] != null
                                              ? DecorationImage(
                                                  colorFilter:
                                                      filter[itemIndex] == -1
                                                          ? null
                                                          : ColorFilter.matrix(
                                                              filters[filter[
                                                                  itemIndex]]),
                                                  image: MemoryImage(
                                                      widget.image[itemIndex]!),
                                                )
                                              : null),
                                    ),
                                  ),
                          ),
                          ...editableItems[itemIndex]
                        ],
                      ),
                    ))
            //   );
            // },
            ),
      )),
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
                            padding:
                                const EdgeInsets.only(bottom: 10, right: 25),
                            child: ElevatedButton(
                              style: raisedButtonStyle,
                              onPressed: () => setState(
                                  () => enablebrightness[itemindex] = false),
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
                        max: 2.0, // Adjust the range as needed
                        //divisions: 20, // Adjust divisions as needed
                        label: 'Brightness: $brightness',
                      ),
                    ],
                  )
                : enablehue[itemindex] ||
                        enablesaturation[itemindex] ||
                        enableBlur[itemindex]
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (enablehue[itemindex] ||
                              enablesaturation[itemindex]) ...[
                            Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10, right: 25),
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
                              style: TextStyle(
                                  color: Colors.white60, fontSize: 18),
                            ),
                          ),
                          Slider(
                            //   divisions: 10,
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
                            max: 2.0, // Adjust the range as needed
                            //divisions: 20, // Adjust divisions as needed
                            label: 'Hue : ${hue[itemindex]}',
                          ),
                          const Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "     Saturation",
                              textAlign: TextAlign.start,
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  color: Colors.white60, fontSize: 18),
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
                            max: 2.0, // Adjust the range as needed
                            //divisions: 20, // Adjust divisions as needed
                            label: 'Saturation: ${saturation[itemindex]}',
                          ),
                          const Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "     Blur",
                              textAlign: TextAlign.start,
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  color: Colors.white60, fontSize: 18),
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
                            max: 5, // Adjust the range as needed
                            //divisions: 20, // Adjust divisions as needed
                            label: 'blur: ${saturation[itemindex]}',
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (crop[itemindex]) ...[
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, right: 25),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: GlassmorphicContainer(
                                    borderRadius: 33,
                                    blur: 2.5,
                                    height: 40,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 16),
                                    colour: Colors.white24,
                                    child: TextButton.icon(
                                      style: const ButtonStyle(
                                        padding: MaterialStatePropertyAll(
                                            EdgeInsets.symmetric(
                                                horizontal: 15)),
                                        splashFactory: InkSparkle.splashFactory,
                                      ),
                                      onPressed: () =>
                                          setState(() => rotate[itemindex]++),
                                      icon: const Icon(Icons.rotate_right,
                                          color: Colors.white70),
                                      label: const Text(
                                        "Rotate ",
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 16),
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                    colour: Colors.white24,
                                    child: TextButton.icon(
                                      style: const ButtonStyle(
                                        padding: MaterialStatePropertyAll(
                                            EdgeInsets.symmetric(
                                                horizontal: 15)),
                                        splashFactory: InkSparkle.splashFactory,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          crop[itemindex] = !crop[itemindex];
                                        });
                                        // crop[itemindex] = true;
                                      },
                                      icon: const Icon(Icons.crop,
                                          color: Colors.white70),
                                      label: const Text(
                                        "Crop ",
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 16),
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 12),
                                    colour: Colors.white24,
                                    child: TextButton.icon(
                                      style: const ButtonStyle(
                                        padding: MaterialStatePropertyAll(
                                            EdgeInsets.symmetric(
                                                horizontal: 15)),
                                        splashFactory: InkSparkle.splashFactory,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          enablebrightness[itemindex] = true;
                                        });
                                      },
                                      icon: const Icon(Icons.wb_sunny_outlined,
                                          color: Colors.white70),
                                      label: const Text(
                                        "Adjustment ",
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 16),
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 12),
                                    colour: Colors.white24,
                                    child: TextButton.icon(
                                      style: const ButtonStyle(
                                        padding: MaterialStatePropertyAll(
                                            EdgeInsets.symmetric(
                                                horizontal: 15)),
                                        splashFactory: InkSparkle.splashFactory,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          enableEffect = true;
                                        });
                                      },
                                      icon: const Icon(Icons.colorize,
                                          color: Colors.white70),
                                      label: const Text(
                                        "Effects ",
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 16),
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                    colour: Colors.white24,
                                    child: TextButton.icon(
                                      style: const ButtonStyle(
                                        padding: MaterialStatePropertyAll(
                                            EdgeInsets.symmetric(
                                                horizontal: 15)),
                                        splashFactory: InkSparkle.splashFactory,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          enablehue[itemindex] =
                                              !enablehue[itemindex];
                                          enablesaturation[itemindex] =
                                              !enablesaturation[itemindex];
                                        });
                                        // crop[itemindex] = true;
                                      },
                                      icon: const Icon(Icons.adjust,
                                          color: Colors.white70),
                                      label: const Text(
                                        "Filter",
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: GlassmorphicContainer(
                                //     borderRadius: 33,
                                //     blur: 2.5,
                                //     height: 40,
                                //     padding: const EdgeInsets.symmetric(
                                //         vertical: 10, horizontal: 12),
                                //     colour: Colors.white24,
                                //     child: TextButton.icon(
                                //       style: const ButtonStyle(
                                //         padding: MaterialStatePropertyAll(
                                //             EdgeInsets.symmetric(
                                //                 horizontal: 15)),
                                //         splashFactory: InkSparkle.splashFactory,
                                //       ),
                                //       onPressed: () {},
                                //       icon: const Icon(
                                //           Icons.auto_awesome_mosaic,
                                //           color: Colors.white70),
                                //       label: const Text(
                                //         "Colleage ",
                                //         style: TextStyle(
                                //             color: Colors.white70,
                                //             fontSize: 16),
                                //       ),
                                //     ),
                                //   ),
                                // ),
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
                                border: filter[itemindex] != index
                                    ? null
                                    : Border.all(
                                        color: const Color.fromRGBO(
                                            53, 222, 217, 1),
                                        width: 2),
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Colors.purple.shade900,
                                    Colors.purple.shade100,
                                  ],
                                ),
                                image: DecorationImage(
                                    colorFilter:
                                        ColorFilter.matrix(filters[index]),
                                    image: MemoryImage(currentimage!),
                                    fit: BoxFit.cover),
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
        colorFilter:
            ColorFilter.matrix(Colorfiltergenerator.brightnessadjustmatrix(
          value: brightness,
        )),
        child: ColorFiltered(
            colorFilter:
                ColorFilter.matrix(Colorfiltergenerator.saturationadjustmatrix(
              value: saturation,
            )),
            child: ColorFiltered(
                colorFilter:
                    ColorFilter.matrix(Colorfiltergenerator.hueadjustmatrix(
                  value: hue,
                )),
                child: Stack(children: [
                  child,
                  BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur * 2),
                      child: const ColoredBox(
                        color: Colors.white10,
                        //child: child,
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
          child: SizedBox(
              width: context.width / 2,
              child: Text(widget.text, style: widget.style)),
        ),
      ),
    );
  }
}
