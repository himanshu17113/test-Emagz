import 'dart:io';
import 'dart:ui' as ui;
import 'package:emagz_vendor/social_media/common/EditorScreen/widgets/DragabbleTextEditor.dart';
import 'package:emagz_vendor/social_media/screens/home/story/controller/story_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
class EditorScreen extends StatefulWidget {
  final Function(File editedImage) onSubmit;

  final String? fileType;
  final String? fileExtension;
  final Uint8List? image;
  final int? imageHeight;
  final int? imageWidth;
  const EditorScreen({super.key,
    required this.onSubmit,
    required this.image,
    this.fileType,
    this.imageHeight,
    this.imageWidth,
    required this.fileExtension});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {

  var storyController = Get.put(GetXStoryController());

  List<Widget> editableItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: ,
      body: Stack(
        children: [

          InteractiveViewer(
            minScale: 1,
            maxScale: 4,
            child: Stack(
            fit: StackFit.expand,
            children: [
              Image.memory(
                widget.image!,fit: BoxFit.contain),
              ...editableItems],
            ),
          ),
          Positioned(
            top: 0,

            left: 0,
            width: MediaQuery.of(context).size.width,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Row(
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
                  IconButton(onPressed: () {
                    showDialog(

                      context: context, builder: (context) {
                      return DraggableTextEditor(
                        text: "",
                        style: TextStyle(),
                        onSubmit: (text,style) {
                        Navigator.pop(context);
                        setState(() {
                        });
                        editableItems.add( DraggableText(text: "$text",style: style,));
                      },);
                    },);
                  }, icon: const Icon(Icons.text_fields)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.music_note))
                ],
              ),
              actions: [
                IconButton(onPressed: () async{
                  showDialog(
                    useSafeArea: true,
                    barrierDismissible: false,
                    context: context, builder: (context) {
                    return Center(child:
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(
                                () => LinearProgressIndicator(
                              value: storyController.storyUploadPercentage.value,
                            ),),
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
                    ),);
                  },);

                  var realImage = await ScreenshotController.widgetToUiImage(Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.memory(
                          widget.image!,fit: BoxFit.contain),
                      ...editableItems],
                  ),context: context,);
                  var buffer = await realImage.toByteData(format: ui.ImageByteFormat.png);
                  var editedImage = await buffer!.buffer.asUint8List();
                  // var editedImage = await screenshotController.capture();
                  final tempDir = await getTemporaryDirectory();
                  File file = await File("${tempDir.path}/story.${widget.fileExtension}").create();
                  await file.writeAsBytes(editedImage);
                  widget.onSubmit(file);

                }, icon: const Icon(Icons.arrow_right_alt))
              ],
            ),
          )
          ,]
      ),
    );
  }
}

class DraggableText extends StatefulWidget {
   String text;
   TextStyle style;
   DraggableText({super.key,required this.text,required this.style});

  @override
  State<DraggableText> createState() => _DraggableTextState();

}

class _DraggableTextState extends State<DraggableText> {

  // var position = Offset(200,200);
  Offset position = Offset(200, 200);
  Offset startPosition = Offset(10, 10);
  // double _scale = 1.0;
  // double _previousScale = 1.0;
  // Offset _offset = Offset.zero;
  // Offset _previousOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: position.dy,
      left: position.dx,
      duration: Duration(milliseconds: 200),
      child: GestureDetector(
        onPanStart: (details) {
      startPosition = details.globalPosition - position;
    },
    onPanUpdate: (details) {
    setState(() {
    position = details.globalPosition - startPosition;
    });},
        child: GestureDetector(
          onTap: () {
            showDialog(context: context, builder: (context) {
              return DraggableTextEditor(onSubmit: (text,style){
                widget.text = text;
                widget.style = style;
                setState(() {
                });
                Navigator.pop(context);
              }, text: widget.text, style: widget.style);
            },);
          },
          // child: Draggable<Text>(
          //   childWhenDragging: Container(),
          //   onDragEnd: (details) {
          //     position = details.offset;
          //     setState(() {
          //     });
          //   },
          //   feedback: Material(
          //       color: Colors.transparent,
          //       child: Opacity(
          //           opacity: 0.5,
          //           child: Text(widget.text,style: widget.style,))),
          //   child: Text(widget.text,style: widget.style,),
          // ),
          child: Text("${widget.text}", style: widget.style),
        ),
      ),
    );
  }
}


class FloatingText extends StatefulWidget {
  final String text;
  final TextStyle style;

  FloatingText({required this.text, required this.style});

  @override
  _FloatingTextState createState() => _FloatingTextState();
}

class _FloatingTextState extends State<FloatingText> {
  Offset position = Offset(0, 0);
  Offset startPosition = Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onPanStart: (details) {
          startPosition = details.globalPosition - position;
        },
        onPanUpdate: (details) {
          setState(() {
            position = details.globalPosition - startPosition;
          });
        },
        child: Text(
          widget.text,
          style: widget.style,
        ),
      ),
    );
  }
}
