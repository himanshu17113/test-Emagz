import 'dart:io';
import 'dart:typed_data';

import 'package:emagz_vendor/social_media/screens/home/screens/post_view/widgets/glass.dart';
import 'package:emagz_vendor/social_media/screens/settings/post/pre_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/post/post_controller.dart';

class CustomPollSelectScreen extends StatefulWidget {
  final String? image;
  final List<Uint8List>? images;
  final PostType postType;
  const CustomPollSelectScreen({super.key, this.image, required this.postType, this.images});

  @override
  State<CustomPollSelectScreen> createState() => _CustomPollSelectScreenState();
}

class _CustomPollSelectScreenState extends State<CustomPollSelectScreen> {
  @override
  void initState() {
    super.initState();
  }

  // final postController = Get.put(PostController(), tag: "PostController");
  final postController = Get.find<PostController>(tag: "PostController");
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          if (widget.image != null) ...[
            Image.file(
              File(
                widget.image ?? postController.textPost!,
              ),
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
          ],
          if (widget.images != null) ...[
            PageView.builder(
              itemCount: widget.images!.length,
              itemBuilder: (context, index) => Center(
                  child: Image.memory(
                widget.images![index],
                filterQuality: FilterQuality.high,
              )),
            ),
          ],
          Positioned(
              // curve: Curves.bounceInOut,
              // duration: const Duration(milliseconds: 50),
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: GlassmorphicContainer(
                  colour: Colors.white10,
                  height: 380 + MediaQuery.of(context).viewInsets.bottom,
                  borderRadius: 20,
                  blur: 5,
                  child: SizedBox(
                    width: Get.width,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(50, 15, 50, 25 + MediaQuery.of(context).viewInsets.bottom),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Custom Poll',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            '  Mini 2 and Max 4 buttons',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),

                          const Spacer(
                            flex: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 130,
                                child: TextField(
                                    cursorColor: Colors.white54,
                                    style: const TextStyle(color: Colors.white70),
                                    textAlign: TextAlign.center,
                                    controller: postController.button1Controller,
                                    decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white12, // Gray background color
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10.0)), // Border radius
                                          borderSide: BorderSide.none, // No border
                                        ),
                                        hintTextDirection: TextDirection.rtl,
                                        hintText: 'Button 1',
                                        hintStyle: TextStyle(color: Colors.white70))),
                              ),
                              SizedBox(
                                width: 130,
                                child: TextField(
                                     cursorColor: Colors.white54,
                                    style: const TextStyle(color: Colors.white70),
                                    controller: postController.button2Controller,
                                    decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white12, // Gray background color
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10.0)), // Border radius
                                          borderSide: BorderSide.none, // No border
                                        ),
                                        hintText: 'Button 2',
                                        hintStyle: TextStyle(color: Colors.white70))),
                              ),
                            ],
                          ),
                          const Spacer(
                            flex: 10,
                          ),

                          // const Icon(Icons.add),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                  onPressed: () async {
                                    Get.back();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(10),
                                    backgroundColor: const Color.fromRGBO(27, 71, 193, 0.28),
                                  ),
                                  child: const Text('     Cancel     ')),
                              ElevatedButton(
                                  onPressed: () async {
                                    Get.back();
                                  },
                                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(10), backgroundColor: Colors.blueAccent
                                      // const Color.fromRGBO(27, 71, 193, 1),
                                      ),
                                  child: const Text('     Continue     ')),
                            ],
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
