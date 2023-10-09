import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class LiveFullScreenLandScapeMode extends StatefulWidget {
  const LiveFullScreenLandScapeMode({super.key});

  @override
  State<LiveFullScreenLandScapeMode> createState() => _LiveFullScreenLandScapeModeState();
}

class _LiveFullScreenLandScapeModeState extends State<LiveFullScreenLandScapeMode> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
      ..initialize().then((_) {
        _controller.play();

        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: _controller.value.isInitialized
          ? Stack(
              children: [
                VideoPlayer(
                  _controller,
                ),
                Positioned(
                  top: 80,
                  child: SizedBox(
                    height: 20,
                    width: size.width,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 30,
                        ),
                        const Icon(
                          Icons.arrow_back_sharp,
                          color: Colors.white,
                        ),
                        const Spacer(),
                        CircleAvatar(
                          radius: 4,
                          backgroundColor: lightRed,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        FormHeadingText(
                          headings: "Live",
                          fontSize: 10,
                          color: lightRed,
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 25,
                  right: 20,
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/png/liked_icon.png",
                        width: 30,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        "assets/png/comment_icon.png",
                        width: 30,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Image.asset(
                        "assets/png/share_icon.png",
                        width: 35,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 150,
                  left: 15,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 10),

                    height: 24,
                    // width: 96,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: const Color(0xffDBDEFF).withOpacity(.05)),
                    child: Text(
                      "@username Very Good",
                      style: GoogleFonts.inter(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 100,
                  left: 20,
                  child: SizedBox(
                    width: size.width / 1.5,
                    child: Text(
                      "Lorem ipsum dolor sit amet consectetur. Nulla ac tortor vitae ac gravida tempus. Mi integer duis sit amet et.",
                      style: GoogleFonts.inter(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 70,
                  left: 20,
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 24,
                        width: 96,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: const Color(0xffDBDEFF).withOpacity(.05)),
                        child: Text(
                          "20+ Joined Live",
                          style: GoogleFonts.inter(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                        height: 24,
                        // width: 96,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: const Color(0xffDBDEFF).withOpacity(.05)),
                        child: Text(
                          "#Nature",
                          style: GoogleFonts.inter(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.center,
                    height: 32,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(0), color: redAcent),
                    child: Text(
                      "End LIVE".toUpperCase(),
                      style: GoogleFonts.inter(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ],
            )
          : const SizedBox(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
