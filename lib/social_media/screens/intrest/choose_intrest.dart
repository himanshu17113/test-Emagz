
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:emagz_vendor/social_media/common/bottom_nav/bottom_nav.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controller/auth/auth_controller.dart';

class ChooseIntrestScreen extends StatefulWidget {
  const ChooseIntrestScreen({super.key});

  @override
  State<ChooseIntrestScreen> createState() => _ChooseIntrestScreenState();
}

class _ChooseIntrestScreenState extends State<ChooseIntrestScreen> {
  final authController =  AuthController() ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xffF8F8F8),
              Color(0xffDCE5FF),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 80,
            ),
            Image.asset(
              "assets/png/new_logo.png",
              width: 50,
              color: const Color(0xff1B47C1),
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: FormHeadingText(
                headings: "Choose Your",
                fontSize: 14,
              ),
            ),
            const Center(
              child: FormHeadingText(
                headings: "Interest",
                fontSize: 22,
              ),
            ),
            const Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.search,
                size: 28,
              ),
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            Expanded(
              child: GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        InkWell(
                          onLongPress: () {
                            Get.to(() =>   BottomNavBar());
                          },
                          onTap: () {
                            setState(() {
                              if (authController.isSelectedInterest(index)) {
                                authController.selectedChoices.remove(index);
                              } else {
                                authController.addSelectedChoice(index);
                              }
                            });
                          },
                          child: SizedBox(
                            height: 240,
                            child: Container(
                              margin: const EdgeInsets.only(top: 8),
                              height: 230,
                              decoration: BoxDecoration(
                                gradient:
                                    authController.isSelectedInterest(index)
                                        ? const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Color(0xFF23A3FF),
                                              Color(0xFF23A3FF),
                                              Color(0xFF2489D2),
                                              Color(0xFF020EFF)
                                            ],
                                          )
                                        : null,
                                // color: Colors.blue,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                margin: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(19),
                                  image: DecorationImage(
                                      image: NetworkImage(intrestList[index]),
                                      fit: BoxFit.cover),
                                ),
                                height: 190,
                                width: double.infinity,
                              ),
                            ),
                          ),
                        ),
                        authController.isSelectedInterest(index)
                            ? Positioned(
                                top: 0,
                                right: 12,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Color(0xFF23A3FF),
                                          Color(0xFF23A3FF),
                                          Color(0xFF2489D2),
                                          // Color(0xFF020EFF)
                                        ],
                                      ),
                                      // borderRadius: BorderRadius.circular(19),
                                      shape: BoxShape.circle),
                                  height: 25,
                                  width: 25,
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: (authController.selectedChoices.isNotEmpty)
          ? GestureDetector(
              // todo : Re Implement it when backend is ready
              onTap: () {
                authController.postChoices();
              },
              child: Container(
                alignment: Alignment.center,
                height: 40,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  gradient: buttonGradient,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: authController.isUserRegiserting 
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : Text(
                        "Next",
                        style: TextStyle(color: whiteColor, fontSize: 15),
                      ),
              ),
            )
          : null,
    );
  }
}
