import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/common/bottom_nav/bottom_nav.dart';
import 'package:emagz_vendor/social_media/screens/account/controllers/account_setup_controller.dart';
import 'package:emagz_vendor/templates/choose_template/choose_template.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalProfileSetup extends StatelessWidget {
  PersonalProfileSetup({Key? key}) : super(key: key);

  @override
  int value = 1;
  @override
  Widget build(BuildContext context) {
    var accountSetUpController = Get.put(SetupAccount());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
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
                    Text(
                      "Set up your Persona",
                      style: TextStyle(
                          color: blackButtonColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ),
                    // const SizedBox(
                    //   height: 2,
                    // ),
                    Text(
                      "Customise your profile",
                      style: TextStyle(
                          color: accountGray,
                          fontSize: 7,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Display Name",
                      style: TextStyle(
                          color: lightBlack,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      height: 40,
                      child: TextFormField(
                        // controller: controller,
                        // maxLines: maxLines,
                        cursorColor: grayColor,
                        controller:
                            accountSetUpController.displayNameController,
                        // keyboardType: TextInputType.n,
                        // autofocus: true,
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(
                              color: Color(
                                0xff818181,
                              ),
                              fontWeight: FontWeight.bold,
                              fontSize: 9),
                          fillColor: const Color(0xffF1F1F1),
                          hintText: "",
                          filled: true,
                          contentPadding: const EdgeInsets.only(left: 10),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: lightgrayColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: lightgrayColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: lightgrayColor),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {

                        Get.to(()=>ChooseTemplate(isReg:true));
                        //accountSetUpController.setUpPersonalAccount();
                        // Get.to(() => BusinessProfileSetupScreen());
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 48,
                        decoration: BoxDecoration(
                            color: chipColor,
                            // border: Border.all(
                            //   color: (value == index) ? chipColor : Colors.black,
                            // ),
                            borderRadius: BorderRadius.circular(5)),
                        child: Obx(
                          () => (accountSetUpController.isUserRegiserting.value) ? const CircularProgressIndicator(
                            color: Colors.white,
                          ): Text(
                            "Choose Template",
                            style: TextStyle(
                                color: whiteColor,
                                fontSize: 9,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () => Get.to(() =>   BottomNavBar()),
                        child: const Text(
                          "Skip For Now",
                          style: TextStyle(
                              color: Color(0xff7C7C7C),
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              // Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
