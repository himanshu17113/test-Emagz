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
      // decoration: const BoxDecoration(
      //   image: DecorationImage(
      //       image: AssetImage("assets/png/story_border.png"),
      //       fit: BoxFit.cover),
      //  ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          RotationTransition(
            turns: const AlwaysStoppedAnimation(183 / 360),
            child: Container(
              height: 58,
              width: 58,
              alignment: Alignment.centerRight,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage("assets/png/story_border.png"),
                    fit: BoxFit.contain),
              ),
            ),
          ),
          Positioned(
            // : 20,
            // top: 15,
            // left: 15,
            child: ClipPath(
              clipper: ParallelogramClipper(),
              child: Container(
                height: 60,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.grey,

                    //    border: Border.all(color: whiteColor, width: 1),
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(url),
                        fit: BoxFit.cover)),
              ),
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
    );
  }
}

/// Clip widget in parallelogram shape
class ParallelogramClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0.0, size.height / 2)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width / 2, 0.0)
      ..lineTo(0.0, size.height / 2)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
