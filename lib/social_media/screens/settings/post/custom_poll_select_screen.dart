import 'dart:io';
import 'dart:typed_data';

import 'package:emagz_vendor/social_media/screens/home/screens/post_view/widgets/glass.dart';
import 'package:emagz_vendor/social_media/screens/settings/post/pre_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/post/post_controller.dart';

class CustomPollSelectScreen extends StatefulWidget {
  final String? image;
  final Uint8List? images;
  PostType postType;
  CustomPollSelectScreen({Key? key, this.image, required this.postType, this.images}) : super(key: key);

  @override
  State<CustomPollSelectScreen> createState() => _CustomPollSelectScreenState();
}

class _CustomPollSelectScreenState extends State<CustomPollSelectScreen> {
  final postController = Get.put(PostController());
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
            Image.memory(
              widget.images!,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            )
          ],
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: GlassmorphicContainer(
                colour: Colors.white24,
                height: 450,
                borderRadius: 20,
                blur: 5,
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
                    child: Column(
                      //   mainAxisAlignment: MainAxisAlignment.,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Custom Poll',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Minimum 2 and Max 4 buttons',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 150,
                              child: TextField(
                                  controller: postController.button1Controller,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white10, // Gray background color
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)), // Border radius
                                      borderSide: BorderSide.none, // No border
                                    ),
                                    hintText: 'Button 1',
                                  )),
                            ),
                            SizedBox(
                              width: 150,
                              child: TextField(
                                  controller: postController.button2Controller,
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white10, // Gray background color
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)), // Border radius
                                      borderSide: BorderSide.none, // No border
                                    ),
                                    hintText: 'Button 2',
                                  )),
                            ),
                          ],
                        ),
                        const Spacer(
                          flex: 4,
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
                                  backgroundColor: Colors.blueAccent.withOpacity(0.2),
                                ),
                                child: const Text('  Cancel  ')),
                            ElevatedButton(
                                onPressed: () async {
                                
                                  Get.back();
                                },
                                style: ElevatedButton.styleFrom(
                                  
                                  backgroundColor: Colors.blueAccent,
                                ),
                                child: const Text('  Continue  ')),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
