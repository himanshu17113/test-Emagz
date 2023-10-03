import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:emagz_vendor/social_media/screens/home/screens/post_view/widgets/glass.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:emagz_vendor/social_media/common/EditorScreen/widgets/DragabbleTextEditor.dart';
import '../../utils/photo_filter.dart';

class EditorScreen extends StatefulWidget {
  final Function(File editedImage) onSubmit;

  final String? fileType;
  final String? fileExtension;
  final List<Uint8List?> image;

  const EditorScreen(
      {super.key,
      required this.onSubmit,
      required this.image,
      this.fileType,
      required this.fileExtension});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  List<ScreenshotController> screenshotController = [];
  int nIm = 0;
  int itemindex = 0;
  List<int> rotate = [];
  List<bool> crop = [];
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
  Uint8List? currentimage;
  @override
  void initState() {
    currentimage = widget.image[0];

    nIm = widget.image.length;
    screenshotController = List.generate(nIm, (i) => ScreenshotController());
    editableItems = List.generate(nIm, (i) => []);
    crop = List.filled(nIm, false);
    rotate = List.filled(nIm, 0);
    filter = List.filled(nIm, 0);

    super.initState();
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
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.more_vert)),
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

                screenshotController[0]
                    .capture(delay: const Duration(milliseconds: 0))
                    .then((capturedImage) async {
                  Uint8List? editedImage = capturedImage;
                  final tempDir = await getTemporaryDirectory();
                  File file = await File("${tempDir.path}.jpeg").create();
                  await file.writeAsBytes(editedImage!);

                  Navigator.of(context, rootNavigator: true).pop();

                  widget.onSubmit(file);
                }).catchError((onError) {
                  debugPrint(onError);
                });
              },
              icon: const Icon(Icons.arrow_right_alt))
        ],
      ),
      body: Stack(children: [
        InteractiveViewer(
            minScale: 1,
            maxScale: 4,
            child: Center(
                child: PageView.builder(
              scrollBehavior: const MaterialScrollBehavior(),
              scrollDirection: Axis.horizontal,
              itemCount: nIm,
              onPageChanged: (value) => setState(() {
                currentimage = widget.image[value];
              }),
              // allowImplicitScrolling: true,
              // padEnds: false,
              itemBuilder: (BuildContext context, int itemIndex) {
                debugPrint("pageViewIndex  $itemIndex");
                itemindex = itemIndex;
                //   currentimage = widget.image[itemIndex];

                return Screenshot(
                  controller: screenshotController[itemIndex],
                  child: RotatedBox(
                    quarterTurns: 0,
                    child: Stack(
                      children: [
                        RotatedBox(
                          quarterTurns: rotate[itemIndex],
                          child: crop[itemIndex]
                              ? Container(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  // decoration: BoxDecoration(
                                  //     image: DecorationImage(
                                  //         colorFilter: filter[itemIndex] == -1
                                  //             ? null
                                  //             : ColorFilter.matrix(
                                  //                 filters[filter[itemIndex]]))),
                                  child: ColorFiltered(
                                    colorFilter: ColorFilter.matrix(
                                        filters[filter[itemIndex]]),
                                    child: Crop(
                                      //  maskColor: Colors.blue,
                                      baseColor: Colors.black12,
                                      controller: _controller,
                                      image: widget.image[itemIndex]!,
                                      onCropped: (cropped) {
                                        // any action using cropped data
                                      },
                                    ),
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      colorFilter: filter[itemIndex] == -1
                                          ? null
                                          : ColorFilter.matrix(
                                              filters[filter[itemIndex]]),
                                      image:
                                          MemoryImage(widget.image[itemIndex]!),
                                    ),
                                  ),
                                ),
                        ),
                        ...editableItems[itemIndex]
                      ],
                    ),
                  ),
                );
              },
            ))),
      ]),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: !enableEffect
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                EdgeInsets.symmetric(horizontal: 15)),
                            splashFactory: InkSparkle.splashFactory,
                          ),
                          onPressed: () => setState(() => rotate[itemindex]++),
                          icon: const Icon(Icons.rotate_right,
                              color: Colors.white70),
                          label: const Text(
                            "Rotate ",
                            style:
                                TextStyle(color: Colors.white70, fontSize: 16),
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
                                EdgeInsets.symmetric(horizontal: 15)),
                            splashFactory: InkSparkle.splashFactory,
                          ),
                          onPressed: () {
                            setState(() {
                              crop[itemindex] = !crop[itemindex];
                            });
                            // crop[itemindex] = true;
                          },
                          icon: const Icon(Icons.crop, color: Colors.white70),
                          label: const Text(
                            "Crop ",
                            style:
                                TextStyle(color: Colors.white70, fontSize: 16),
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
                                EdgeInsets.symmetric(horizontal: 15)),
                            splashFactory: InkSparkle.splashFactory,
                          ),
                          onPressed: () {},
                          icon: const Icon(Icons.wb_sunny_outlined,
                              color: Colors.white70),
                          label: const Text(
                            "Adjustment ",
                            style:
                                TextStyle(color: Colors.white70, fontSize: 16),
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
                                EdgeInsets.symmetric(horizontal: 15)),
                            splashFactory: InkSparkle.splashFactory,
                          ),
                          onPressed: () {
                            setState(() {
                              enableEffect = true;
                            });
                          },
                          icon:
                              const Icon(Icons.colorize, color: Colors.white70),
                          label: const Text(
                            "Effects ",
                            style:
                                TextStyle(color: Colors.white70, fontSize: 16),
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
                                EdgeInsets.symmetric(horizontal: 15)),
                            splashFactory: InkSparkle.splashFactory,
                          ),
                          onPressed: () {},
                          icon: const Icon(Icons.auto_awesome_mosaic,
                              color: Colors.white70),
                          label: const Text(
                            "Colleage ",
                            style:
                                TextStyle(color: Colors.white70, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                                border: Border.all(
                                    color:
                                        const Color.fromRGBO(53, 222, 217, 1),
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
