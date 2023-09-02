// import 'package:emagz_vendor/social_media/screens/home/story/story_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../../../controller/auth/jwtcontroller.dart';
// import '../../controller/story_controller.dart';
// import '../../model/story_model.dart';
// class ViewMyStory extends StatefulWidget {
//    ViewMyStory({Key? key,}) : super(key: key);


//   @override
//   State<ViewMyStory> createState() => _ViewMyStoryState();
// }

// class _ViewMyStoryState extends State<ViewMyStory> {
//   late List<Stories>story;
//   var storyController = Get.put(GetXStoryController());
//   var jwtController = Get.put(JWTController());
//   String? userId;
//   @override
//   void initState() {
//     super.initState();
//     asyncInit();
//   }

//   asyncInit()async {

//   story= await storyController.getmymyStories();
//   userId= await jwtController.getUserId();
//     setState(() {});
//   }
//   @override
//   Widget build(BuildContext context) {
//     return StoryScreen(stories: story, userId: userId.toString());
//   }
// }
