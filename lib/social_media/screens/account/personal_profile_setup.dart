 import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/screens/account/controllers/account_setup_controller.dart';
import 'package:emagz_vendor/templates/choose_template/choose_template.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalProfileSetup extends StatelessWidget {
 final String username;
  const PersonalProfileSetup({Key? key, required this.username}) : super(key: key);
  static const TextStyle s =
      TextStyle(color: accountGray, fontSize: 9, fontWeight: FontWeight.w500);
  @override
  Widget build(BuildContext context) {
    final accountSetUpController = Get.put(SetupAccount());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/png/social_back.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Center(
              child: Image.asset(
                "assets/png/new_logo.png",
                width: 200,
                color: Colors.white.withOpacity(.8),
              ),
            ),
            const Spacer(),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              // height: 260,
              width: size.width,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: blackButtonColor.withOpacity(.15),
                    blurRadius: 6,
                    offset: const Offset(
                      2,
                      6,
                    ),
                    spreadRadius: 1)
              ], borderRadius: BorderRadius.circular(10), color: whiteColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Congratulations",
                    style: TextStyle(
                        color: blackButtonColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ),
                  // const SizedBox(
                  //   height: 2,
                  // ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Set up your Persona",
                      style: TextStyle(
                          color: accountGray,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("View Insights", style: s),
                      Text("personaView", style: s),
                      Text("Audience Base", style: s),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Spacer(),
                      Text(" Analyses your post", style: s),
                      Spacer(),
                      Text("PersonalizedProfessional", style: s),
                    ],
                  ),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Redirect to store", style: s),
                      Text("Upload product images", style: s),
                    ],
                  ),

                  InkWell(
                    onTap: () {
                      Get.to(() =>   ChooseTemplate(
                            isReg: true,
                            username: username,
                          ));
                      //accountSetUpController.setUpPersonalAccount();
                      // Get.to(() => BusinessProfileSetupScreen());
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      alignment: Alignment.center,
                      height: 48,
                      decoration: BoxDecoration(
                          color: chipColor,
                          // border: Border.all(
                          //   color: (value == index) ? chipColor : Colors.black,
                          // ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Obx(
                        () => (accountSetUpController.isUserRegiserting.value)
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Choose Template",
                                style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            // Spacer(),
          ],
        ),
      ),
    );
  }
}
