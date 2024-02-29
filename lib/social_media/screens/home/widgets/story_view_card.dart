import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:flutter/material.dart';

import '../story/model/story_model.dart';

class StoryViewCard extends StatelessWidget {
  final UserId? username;
  final String url;
  const StoryViewCard({
    Key? key,
    this.username,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: SizedBox.square(
        dimension: 100,
        // margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),

        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 70,
              width: 70,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                //  shape: BoxShape.circle,
                image: DecorationImage(image: CachedNetworkImageProvider(url), fit: BoxFit.fill),
              ),
              child: Image.asset(
                "assets/png/story_frame.png",
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              // bottom: 25,
              // left: 47.5,
              bottom: 30,
              left: 52,
              child: // SizedBox(
                  RotationTransition(
                turns: const AlwaysStoppedAnimation(-48 / 360),
                child: SizedBox(
                  //   color: Colors.amber,
                  width: 100,
                  height: 20,
                  child: Text(
                    username == null ? "  loading.." : username!.username!,
                    style: const TextStyle(fontSize: 6, fontWeight: FontWeight.bold, color: blackButtonColor),
                  ),
                ),
              ),
            ),
          ],
        ),
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
