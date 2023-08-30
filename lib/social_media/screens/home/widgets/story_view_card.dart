import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoryViewCard extends StatefulWidget {
  const StoryViewCard({
    Key? key,
    required this.username,
    required this.url,
  }) : super(key: key);
  final String username;
  final String url;

  @override
  State<StoryViewCard> createState() => _StoryViewCardState();
}

class _StoryViewCardState extends State<StoryViewCard> {
  UserSchema? user;

  var jwtController = Get.put(JWTController());

  @override
  void initState() {
    getInitUser();
    super.initState();
  }

  getInitUser() async {
    // debugPrint(widget.username);
    user = await jwtController.getUserDetail(widget.username);
    //setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      height: 68,
      width: 72,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/png/story_border.png"),
            fit: BoxFit.cover),
      ),
      child: RotationTransition(
        turns: const AlwaysStoppedAnimation(-48.5 / 360),
        child: Stack(
          children: [
            Positioned(
              top: 12.3,
              left: 9,
              child: Container(
                height: 54,
                width: 54,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(color: whiteColor, width: 1),
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(widget.url),
                        fit: BoxFit.cover)),
              ),
            ),
            Positioned(
              top: 66,
              left: 20,
              child: Text(
                user == null ? "loading.." : user!.username!,
                style: TextStyle(
                    fontSize: 6,
                    fontWeight: FontWeight.bold,
                    color: blackButtonColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
