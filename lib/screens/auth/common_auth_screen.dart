import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/auth/signup_screen.dart';
import 'package:emagz_vendor/social_media/controller/auth/auth_controller.dart';
import 'package:flutter/material.dart';

import 'signin_screen.dart';

class CommonAuthScreen extends StatefulWidget {
  const CommonAuthScreen({Key? key}) : super(key: key);

  @override
  State<CommonAuthScreen> createState() => _CommonAuthScreenState();
}

class _CommonAuthScreenState extends State<CommonAuthScreen> with SingleTickerProviderStateMixin {
  final authController = AuthController();

  @override
  void initState() {
    authController.tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      body: Container(
          height: size.height,
          decoration: BoxDecoration(gradient: authGradient),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(
                  height: size.height / 20,
                ),
                Image.asset(
                  "assets/png/new_logo.png",
                  // scale: ,
                  height: 50,
                ),
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: Container(
                    height: size.height / 1.5,
                    margin: const EdgeInsets.only(),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Container(
                          color: Colors.white,
                          height: 45,
                          margin: const EdgeInsets.only(left: 25, right: 25, top: 30),
                          child: TabBar(
                            controller: authController.tabController,
                            indicatorPadding: EdgeInsets.zero,
                            labelPadding: EdgeInsets.zero,
                            indicator: BoxDecoration(gradient: buttonGradient, borderRadius: BorderRadius.circular(90), color: blueColor),
                            labelStyle: TextStyle(
                                color: blackButtonColor,
                                fontWeight: FontWeight.w600,
                                // color: AppColor.blackColor,
                                fontSize: 16),
                            labelColor: Colors.white,
                            unselectedLabelColor: unselectedLabel,
                            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                            tabs: const [
                              Tab(
                                text: "Sign Up",
                              ),
                              Tab(
                                text: "Sign In",
                              ),
                              // Tab(text: 'Sign Up'),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          // color: Colors.white,
                          // height: 200,
                          child: TabBarView(
                            controller: authController.tabController,
                            children: const [
                              SignUpScreen(),
                              SignInScreen(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )),
    ));
  }
}
