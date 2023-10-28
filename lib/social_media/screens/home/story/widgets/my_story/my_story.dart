import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/social_media/screens/home/story/model/story_model.dart';
import 'dart:ui' as ui;
import 'package:emagz_vendor/social_media/screens/home/story/widgets/story_selection/ModalBottomSheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../story_screen.dart';

class MyStory extends StatelessWidget {
  final UserId? userID;
  final List<Stories>? stories;
  const MyStory({super.key, this.stories, this.userID});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (stories == [] || userID == null) {
            return;
          } else {
            Get.to(() => StoryScreen(userId: userID!, stories: stories!));
          }
        },
        child: SizedBox(
          height: 55,
          width: 55,
          //      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          // height: 70,
          // width: 70,
          // decoration: const BoxDecoration(
          //   image: DecorationImage(image: AssetImage("assets/png/story_border.png"), fit: BoxFit.fill),
          // ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 55,
                width: 55,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.centerRight,
                decoration: const BoxDecoration(
                  //    shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage("assets/png/story_border.png"), fit: BoxFit.contain),
                ),
              ),
              Positioned(
                // bottom: 5,
                left: 6,
                top: 20,
                //  right: 5,
                child: SizedBox(
                  height: 50,
                  child: RotationTransition(
                    turns: const AlwaysStoppedAnimation(-4 / 360),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(32)),
                      child: ClipPath(
                        clipper: RoundedRhombusClipper(),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(32)),
                          child: Image.network(
                            stories!.isNotEmpty ? stories![0].mediaUrl ?? "https://picsum.photos/500/500?random=0" : "https://picsum.photos/500/500?random=0",
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 45,
                left: 10,
                child: IconButton(
                  alignment: Alignment.centerLeft,
                  iconSize: 10,
                  onPressed: () {
                    showModalBottomSheet(
                        elevation: 0.0,
                        backgroundColor: Colors.transparent,
                        barrierColor: Colors.transparent,
                        context: context,
                        builder: (context) {
                          return const StorySelectionBottomSheet();
                        });
                  },
                  icon: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      //   borderRadius: BorderRadius.circular(33),
                      border: Border.all(color: Colors.white, width: 2),
                      color: const Color(0xff3B12AA),
                    ),
                    child: const RotationTransition(
                      turns: AlwaysStoppedAnimation(48 / 360),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                ),
              )
              // Positioned(
              //   top: 66,
              //   left: 20,
              //   child: Text(
              //     username == null ? "loading.." : username!.username!,
              //     style: TextStyle(
              //         fontSize: 6,
              //         fontWeight: FontWeight.bold,
              //         color: blackButtonColor),
              //   ),
              // ),
            ],
          ),
        )
        // Container(
        //     height: 55,
        //     width: 55,
        //     alignment: Alignment.centerRight,
        //     decoration: const BoxDecoration(
        //       image: DecorationImage(
        //           image: AssetImage("assets/png/story_border.png"),
        //           fit: BoxFit.contain),
        //     ),
        //     child: RotationTransition(
        //       turns: const AlwaysStoppedAnimation(-48 / 360),
        //       child: Stack(
        //         children: [
        //           Container(
        //             height: 55,
        //             width: 55,
        //             alignment: Alignment.centerRight,
        //             decoration: const BoxDecoration(
        //               image: DecorationImage(
        //                   image: AssetImage("assets/png/story_border.png"),
        //                   fit: BoxFit.contain),
        //             ),
        //           ),
        //           Positioned(
        //             top: 24,
        //             left: 7.3,
        //             child: RotationTransition(
        //               turns: const AlwaysStoppedAnimation(48 / 360),
        //               child: Container(
        //                 height: 40,
        //                 width: 40,
        //                 decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(10),
        //                   //   border: Border.all( color: ),
        //                   image: DecorationImage(
        //                       image: CachedNetworkImageProvider(stories!.isNotEmpty
        //                           ? stories![0].mediaUrl ??
        //                               "https://picsum.photos/500/500?random=0"
        //                           : "https://picsum.photos/500/500?random=0"),
        //                       fit: BoxFit.cover),
        //                 ),
        //                 // child: Image.network(
        //                 //   url,
        //                 //   fit: BoxFit.cover,
        //                 // ),
        //               ),
        //             ),
        //           ),
        //           Positioned(
        //             top: 45,
        //             left: 10,
        //             child: IconButton(
        //               alignment: Alignment.centerLeft,
        //               iconSize: 10,
        //               onPressed: () {
        //                 showModalBottomSheet(
        //                     elevation: 0.0,
        //                     backgroundColor: Colors.transparent,
        //                     barrierColor: Colors.transparent,
        //                     context: context,
        //                     builder: (context) {
        //                       return const StorySelectionBottomSheet();
        //                     });
        //               },
        //               icon: Container(
        //                 decoration: BoxDecoration(
        //                   shape: BoxShape.circle,
        //                   //   borderRadius: BorderRadius.circular(33),
        //                   border: Border.all(color: Colors.white, width: 2),
        //                   color: const Color(0xff3B12AA),
        //                 ),
        //                 child: const RotationTransition(
        //                   turns: AlwaysStoppedAnimation(48 / 360),
        //                   child: Icon(
        //                     Icons.add,
        //                     color: Colors.white,
        //                     size: 15,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           )
        //         ],
        //       ),
        //     ),
        //   ),

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
    return Path.combine(
        PathOperation.intersect, path, Path()..addRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), const Radius.circular(radius))));
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
    paint0Stroke.shader = ui.Gradient.linear(Offset(size.width * -13.18254, size.height * 1.389908), Offset(size.width * 0.8014365, size.height * 0.7431385), [
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
        RRect.fromRectAndCorners(Rect.fromLTWH(size.width * -0.04758846, size.height * 0.5317885, size.width * 0.7655058, size.height * 0.7734019),
            bottomRight: Radius.circular(size.width * 0.1913744),
            bottomLeft: Radius.circular(size.width * 0.1913744),
            topLeft: Radius.circular(size.width * 0.1913744),
            topRight: Radius.circular(size.width * 0.1913744)),
        paint0Stroke);

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xff000000).withOpacity(1.0);
    canvas.drawRRect(
        RRect.fromRectAndCorners(Rect.fromLTWH(size.width * -0.04758846, size.height * 0.5317885, size.width * 0.7655058, size.height * 0.7734019),
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

    path.addRRect(RRect.fromLTRBR(cornerRadius, cornerRadius, size.width - cornerRadius, size.height - cornerRadius, const Radius.circular(cornerRadius)));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
