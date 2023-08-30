import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
 import 'package:flutter/material.dart';

import '../story/model/story_model.dart';
 

class StoryViewCard extends StatelessWidget {
  const StoryViewCard({
    Key? key,
      this.username,
    required this.url,
  }) : super(key: key);
  final UserId? username;
  final String url;

  // UserSchema? user;
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
                        image: CachedNetworkImageProvider(url),
                        fit: BoxFit.cover)),
              ),
            ),
            Positioned(
              top: 66,
              left: 20,
              child: Text(
                username == null ? "loading.." : username!.username!,
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
