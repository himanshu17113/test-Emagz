import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constant/colors.dart';
import '../../home/widgets/home_screen_appbar.dart';

class FollowerScreen extends StatefulWidget {
  const FollowerScreen({super.key});

  @override
  State<FollowerScreen> createState() => _FollowerScreenState();
}

class _FollowerScreenState extends State<FollowerScreen> {
  bool isFollowing = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 35),
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffF8F8F8),
            Color(0xffDCE5FF),
          ],
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: const SocialHomeScreenAppBar(
            isColor: false,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Text(
                      "Followers",
                      style: GoogleFonts.inter(
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Following",
                      style: GoogleFonts.inter(
                          fontSize: 10,
                          color: Colors.black.withOpacity(.5),
                          fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    const Icon(Icons.search),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: 8,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            height: 68,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: lightSky.withOpacity(.8), width: 1.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 15,
                                ),
                                CircleAvatar(
                                  radius: 24,
                                  backgroundImage:
                                      NetworkImage(templateFiveImage[1]),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FormHeadingText(
                                      headings: "User name",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    FormHeadingText(
                                      headings: "@userName",
                                      fontSize: 10,
                                      color: lightBlack,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isFollowing = !isFollowing;
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 34,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      color: isFollowing == true
                                          ? const Color(0xffDFECFF)
                                          : const Color(0xff1B47C1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: FormHeadingText(
                                      headings: isFollowing == true
                                          ? "Following"
                                          : "Follow",
                                      fontWeight: FontWeight.w500,
                                      color: isFollowing == false
                                          ? Colors.white
                                          : const Color(0xff1B47C1),
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                              ],
                            ),
                          );
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
