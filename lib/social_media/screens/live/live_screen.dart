import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constant/colors.dart';
import '../home/widgets/home_screen_appbar.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Column(
                    children: [
                      Container(
                        height: 170,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(uselessUrl),
                                fit: BoxFit.cover)),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 35,
                        decoration: const BoxDecoration(color: Colors.black),
                        child: const FormHeadingText(
                          headings: "Upload Cover Pic",
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Describe your feeling".toUpperCase(),
                    style: GoogleFonts.inter(
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: const Color(0xff282836).withOpacity(.21),
                          width: 1.5),
                    ),
                    child: const TextField(
                      maxLength: 32,
                      maxLines: 2,
                      decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(0)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "Followers".toUpperCase(),
                        style: GoogleFonts.inter(
                            fontSize: 10,
                            color: Colors.black,
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
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          height: 68,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: lightSky.withOpacity(.8), width: 1.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 15,
                              ),
                              const CircleAvatar(
                                radius: 24,
                                backgroundImage:
                                    NetworkImage(uselessUrl),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Column(
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
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: FormHeadingText(
                                    headings: isFollowing == true
                                        ? "Invited"
                                        : "Invite",
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
                      }),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            alignment: Alignment.center,
            height: 51,
            // width: ,
            decoration: BoxDecoration(
              color: const Color(0xff1B47C1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const FormHeadingText(
              headings: "Go Live",
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
