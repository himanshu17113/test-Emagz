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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      height: 68,
      width: 72,
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
              child: RotationTransition(
            turns: const AlwaysStoppedAnimation(224 / 360),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  border: Border.all(width: 0, color: Colors.transparent),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: CachedNetworkImageProvider(url))),
            ),
          )),
          Positioned(
            top: 66,
            left: 20,
            child: Text(
              username == null ? "loading.." : username!.username!,
              style: const TextStyle(
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
