import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:emagz_vendor/social_media/controller/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../constant/colors.dart';

import '../widgets/my_gradient_button.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  bool isEnabled = false;
  var authController =  AuthController() ;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
     debugPrint(size.width.toString());

    return SafeArea(
        child: Scaffold(
      body: Container(
          height: size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xFF0F0AA4),
              Color(0xFF2992E3),
            ],
            // stops: [23, 117],
            // transform: GradientRotation(7843 * (math.pi / 6000),),
          )),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * .08,
                  ),
                  Image.asset(
                    "assets/png/new_logo.png",
                    // scale: ,
                    // width: 195,
                    height: size.height * .2,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    // height: size.height / 1.55,
                    // width: 340,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormHeadingText(
                          headings: "Verification",
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: lightBlack,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        FormHeadingText(
                          headings:
                              "Please enter the OTP sent to your registered mobile number 0r email id naku******amail.com or +91 09*****654",
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: unselectedLabel,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FormHeadingText(
                          headings: "OTP",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: lightBlack,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        PinCodeTextField(
                          controller: controller,
                          keyboardType: TextInputType.number,
                          appContext: context,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(10),
                            fieldHeight: 45,
                            fieldWidth: 46,
                            selectedColor: Colors.black,
                            fieldOuterPadding: const EdgeInsets.all(5),
                            activeFillColor: const Color(0xffEEEEEE),
                            activeColor: Colors.black,
                            inactiveColor: const Color(0xffEEEEEE),
                            inactiveFillColor: const Color(0xffEEEEEE),
                            selectedFillColor: const Color(0xffEEEEEE),
                          ),
                          length: 4,
                          onChanged: (v) {
                            if (v.length == 4) {
                              isEnabled = true;
                              setState(() {});
                            } else {
                              isEnabled = false;
                              setState(() {});
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: 
                          // Obx(
                          //   () => (authController.isUserRegiserting)
                          //       ? const CircularProgressIndicator()
                          //       : 
                                MyGradientButton(
                                    isEnabled: isEnabled,
                                    onTap: () {
                                      isEnabled
                                          ? authController
                                              .verifyOtp(controller.text)
                                          : null;
                                    },
                                  ),
                         // ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FormHeadingText(
                              headings: "Resend OTP: ",
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: lightBlack,
                            ),
                            FormHeadingText(
                              headings: "3s",
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: blueColor,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    ));
  }
}
