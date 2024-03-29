import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/social_media/screens/home/story/model/story_model.dart';
import 'dart:ui' as ui;
import 'package:emagz_vendor/social_media/screens/home/story/widgets/story_selection/ModalBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../story_screen.dart';

class MyStory extends StatelessWidget {
  final UserId? userID;
  final List<Stories> stories;
  const MyStory({super.key, required this.stories, this.userID});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (stories == [] || userID == null) {
          return;
        } else {
          Get.to(() => StoryScreen(userId: userID!, stories: stories));
        }
      },
      child: SizedBox.square(
        dimension: 70,
        // margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),

        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 60,
              width: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                //  shape: BoxShape.circle,
                image: DecorationImage(
                    image: CachedNetworkImageProvider(
                      stories.isNotEmpty
                          ? stories[0].mediaUrl ?? "https://picsum.photos/500/500?random=0"
                          : "https://picsum.photos/500/500?random=0",
                    ),
                    fit: BoxFit.fill),
              ),
              child: Image.asset(
                "assets/png/story_frame.png",
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 20,
              child: IconButton(
                alignment: Alignment.centerLeft,
                iconSize: 10,
                onPressed: () {
                  showModalBottomSheet(
                      elevation: 0.0,
                      backgroundColor: Colors.transparent,
                      barrierColor: Colors.black45,
                      context: context,
                      builder: (context) {
                        return StorySelectionBottomSheet();
                      });
                },
                icon: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    //   borderRadius: BorderRadius.circular(33),
                    border: Border.all(color: Colors.white, width: 2),
                    color: const Color(0xff3B12AA),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RoundedRhombusClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Define the points of the rhombus
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(0, size.height / 2);

    // Close the path to form a rhombus
    path.close();

    // Apply rounded corners
    // const borderRadius = Radius.circular(10.0);
    const radius = 30.0;
    return Path.combine(PathOperation.intersect, path,
        Path()..addRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), const Radius.circular(radius))));
    // addRect(RRect.fromRectAndRadius(path, radius));
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class UnionClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Create a rectangle
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Create a rounded rectangle
    path.addRRect(RRect.fromRectAndRadius(Rect.fromLTWH(20, 20, size.width - 40, size.height - 40), const Radius.circular(10)));

    // Perform union operation
    path.fillType = PathFillType.evenOdd;

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.04155673;
    paint0Stroke.shader = ui.Gradient.linear(
        Offset(size.width * -13.18254, size.height * 1.389908), Offset(size.width * 0.8014365, size.height * 0.7431385), [
      const Color(0xff57ECD9).withOpacity(1),
      const Color(0xff53EADB).withOpacity(1),
      const Color(0xff2FDDC6).withOpacity(1),
      const Color(0xff31DBC7).withOpacity(1),
      const Color(0xff35DED9).withOpacity(1),
      const Color(0xff85DDD5).withOpacity(1)
    ], [
      0,
      0.15625,
      0.317708,
      0.653463,
      0.730534,
      0.993897
    ]);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(size.width * -0.04758846, size.height * 0.5317885, size.width * 0.7655058, size.height * 0.7734019),
            bottomRight: Radius.circular(size.width * 0.1913744),
            bottomLeft: Radius.circular(size.width * 0.1913744),
            topLeft: Radius.circular(size.width * 0.1913744),
            topRight: Radius.circular(size.width * 0.1913744)),
        paint0Stroke);

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xff000000).withOpacity(1.0);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
            Rect.fromLTWH(size.width * -0.04758846, size.height * 0.5317885, size.width * 0.7655058, size.height * 0.7734019),
            bottomRight: Radius.circular(size.width * 0.1913744),
            bottomLeft: Radius.circular(size.width * 0.1913744),
            topLeft: Radius.circular(size.width * 0.1913744),
            topRight: Radius.circular(size.width * 0.1913744)),
        paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class ParallelogramClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    const double cornerRadius = 10.0;

    path.lineTo(size.width - cornerRadius, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(cornerRadius, size.height);
    path.lineTo(0.0, cornerRadius);

    path.addRRect(RRect.fromLTRBR(
        cornerRadius, cornerRadius, size.width - cornerRadius, size.height - cornerRadius, const Radius.circular(cornerRadius)));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
