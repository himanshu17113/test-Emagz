import 'dart:io';

import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:emagz_vendor/social_media/screens/home/screens/post_view/widgets/glass.dart';
import 'package:emagz_vendor/social_media/screens/settings/post/pre_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/post/post_controller.dart';
class CustomPollSelectScreen extends StatefulWidget {
  dynamic image;
  PostType postType;
  CustomPollSelectScreen({Key? key,required this.image, required  this.postType}) : super(key: key);

  @override
  State<CustomPollSelectScreen> createState() => _CustomPollSelectScreenState();
}

class _CustomPollSelectScreenState extends State<CustomPollSelectScreen> {
  final postController = Get.put(PostController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          widget.image==null?Container():
             (widget.postType == PostType.gallery)
                ? Image.memory(widget.image!,fit: BoxFit.cover,height: double.infinity,
               width: double.infinity,
               alignment: Alignment.center,)
                : Image.file(
              File(widget.image ??
                  postController.textPost!,)
               ,fit: BoxFit.cover,height: double.infinity,
               width: double.infinity,
               alignment: Alignment.center,
            ),
          Positioned(
              bottom: 0,
              child: GlassmorphicContainer(
                colour: Colors.grey,
                height: 280,
                borderRadius: 2,
                blur: 5,
                child:  Column(
                  children: [
                    FormHeadingText(headings: 'Custom Poll',color: Colors.white,),
                    SizedBox(height: 10,),
                    FormHeadingText(headings: 'Minimum 2 and Max 4 buttons',color: Colors.white,),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        SizedBox(
                          width:150,
                          child: TextField(
                            controller: postController.button1Controller,

                              decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200], // Gray background color
                              border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)), // Border radius
                              borderSide: BorderSide.none, // No border
                              ),
                              hintText: 'Button 1',)
                          ),
                        ),
                        SizedBox(width: 50,),
                        SizedBox(
                          width: 150,
                          child: TextField(
                            controller: postController.button2Controller,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200], // Gray background color
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)), // Border radius
                                  borderSide: BorderSide.none, // No border
                                ),
                                hintText: 'Button 2',)
                          ),
                        ),


                      ],
                    ),
                    SizedBox(height: 50,),
                    Icon(Icons.add),
                    ElevatedButton(
                        onPressed: ()async
                        {
                            Get.back();
                        },

                         child: Text('Continue'))


                  ],
                ),
              )
          )

        ],
      ),

    );
  }
}
