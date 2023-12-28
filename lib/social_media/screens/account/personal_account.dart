import 'dart:ui';

import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/controller/auth/auth_controller.dart';
import 'package:flutter/material.dart';

class PersonalAccountScreen extends StatelessWidget {
  final String? suggestedName;
  PersonalAccountScreen({Key? key, this.suggestedName}) : super(key: key);

  final authController = AuthController();
  int value = 1;
  final TextEditingController? controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(
              flex: 7,
            ),
            Center(
              child: Image.asset(
                "assets/png/new_logo.png",
                width: MediaQuery.of(context).viewInsets.bottom == 0
                    ? size.height * .2
                    : size.height * .12,
                color: Colors.white.withOpacity(.8),
              ),
            ),
            const Spacer(
              flex: 4,
            ),
            Container(
              // padding: EdgeInsets.only(
              //     bottom: MediaQuery.of(context).viewInsets.bottom),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: blackButtonColor.withOpacity(.15),
                      blurRadius: 6,
                      offset: const Offset(
                        2,
                        6,
                      ),
                      spreadRadius: 1)
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                clipBehavior: Clip.hardEdge,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    //     margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 40),
                    //height: 360,
                    width: size.width * .9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.94)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Let’s Get Started",
                          style: TextStyle(
                              color: blackButtonColor,
                              fontSize: 22,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.lerp(
                                  FontWeight.w500, FontWeight.w600, 0.35)),
                        ),
                        // const SizedBox(
                        //   height: 2,
                        // ),
                        const Text(
                          "Customise your profile",
                          style: TextStyle(
                              color: accountGray,
                              fontSize: 9,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "User Name",
                          style: TextStyle(
                              color: lightBlack,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        // SizedBox(
                        //     height: 45,
                        //     child: AddCouponTextfiled(
                        //       hint: "Nakul_kumar8",
                        //     )),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: TextFormField(
                            scrollPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            style: const TextStyle(
                                color: Color(
                                  0xff707070,
                                ),
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                            controller: controller,
                            // maxLines: maxLines,
                            cursorColor: grayColor,
                            // keyboardType: TextInputType.n,
                            // autofocus: true,
                            //enabled: widget.suggestedName == null,
                            decoration: InputDecoration(
                              hintStyle: const TextStyle(
                                  color: Color(
                                    0xff818181,
                                  ),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                              fillColor: const Color(0xffF1F1F1),
                              counterText: "",
                              hintText: suggestedName ?? "new user-name",
                              filled: true,
                              contentPadding: const EdgeInsets.only(left: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: lightgrayColor,
                                ),
                              ),
                              disabledBorder: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Color(0xf1EFEFEF),
                                  )),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Color(0xf1EFEFEF),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 15),
                          child: Text(
                            "Select account type",
                            style: TextStyle(
                                color: lightBlack,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ),

                        StatefulBuilder(
                            builder: (BuildContext context, setState) => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          value = 1;
                                        });
                                      },
                                      child: Card(
                                        elevation: 2,
                                        // padding: const EdgeInsets.symmetric(horizontal: 10),

                                        color: (value == 1)
                                            ? chipColor
                                            : selectionButton,
                                        // border: Border.all(
                                        //   color: (value == index) ? chipColor : Colors.black,
                                        // ),

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            "Personal Account",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: (value == 1)
                                                    ? whiteColor
                                                    : blackButtonColor
                                                        .withOpacity(.5),
                                                fontSize: 9,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    )),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          value = 2;
                                        });
                                      },
                                      child: Card(
                                        elevation: 2,
                                        // padding: const EdgeInsets.symmetric(horizontal: 10),

                                        color: (value == 2)
                                            ? chipColor
                                            : selectionButton,
                                        // border: Border.all(
                                        //   color: (value == index) ? chipColor : Colors.black,
                                        // ),

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            "Business Account",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: (value == 2)
                                                    ? whiteColor
                                                    : blackButtonColor
                                                        .withOpacity(.5),
                                                fontSize: 9,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    )),
                                  ],
                                )),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            authController.postUserProfileType(
                                value, controller!.text);
                            // Get.to(() => PersonalProfileSetup());
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
                            child: (authController.isUserlogging)
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Continue",
                                    style: TextStyle(
                                        color: whiteColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
