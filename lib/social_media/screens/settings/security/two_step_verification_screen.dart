import 'package:emagz_vendor/common/common_snackbar.dart';
import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../constant/colors.dart';

class TwoStepVerificationScreen extends StatefulWidget {
  const TwoStepVerificationScreen({super.key});

  @override
  State<TwoStepVerificationScreen> createState() =>
      _TwoStepVerificationScreenState();
}

class _TwoStepVerificationScreenState extends State<TwoStepVerificationScreen> {
  bool isTwoWayVerification = false;
  bool isDeactivateAccount = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          color: Color(0xffE7E9FE),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(80),
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        // const SizedBox(
                        //   width: 20,
                        // ),
                        InkWell(
                          onTap: () {
                            Get.back();
                            // ZoomDrawer.of(context)!.toggle();
                          },
                          child: Image.asset(
                            "assets/png/new_logo.png",
                            color: const Color(0xff1B47C1),
                            height: 38,
                            width: 36,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 38,
                    width: 38,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: purpleColor,
                    ),
                    child: IconButton(
                      onPressed: ()
                      {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 25,
                        weight: .5,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const FormHeadingText(
                  headings: "Two Way Verification",
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 231,
                  child: FormHeadingText(
                    headings:
                        "Enabling Two Way Verification after every log in we will send a verification code to verify and secure your account ",
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: toggleInactive,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 400,
                  width: double.infinity,
                  padding: const EdgeInsets.all(23),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.transparent,
                    border: Border.all(color: purpleColor, width: 1.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      FormHeadingText(
                        headings: "Verification",
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: lightBlack,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        width: 277,
                        child: FormHeadingText(
                          headings:
                              "Please verify your updated email id by enter OTP sent to your new email id",
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: unselectedLabel,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FormHeadingText(
                        headings: "OTP",
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: lightBlack,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      PinCodeTextField(
                        keyboardType: TextInputType.number,
                        enableActiveFill: true,
                        appContext: context,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(10),
                          fieldHeight: 45,
                          fieldWidth: 46,
                          selectedColor: Colors.black,
                          disabledColor: Colors.white,
                          fieldOuterPadding: const EdgeInsets.all(5),
                          activeFillColor: Colors.white,
                          activeColor: Colors.white,
                          inactiveColor: Colors.white,
                          inactiveFillColor: Colors.white,
                          selectedFillColor: Colors.white,
                        ),
                        // backgroundColor: Colors.white,
                        length: 4,
                        onChanged: (v) {},
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: (){
                          CustomSnackbar.showSucess('Hi Your OTP is 8978');
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 51,
                          decoration: BoxDecoration(
                            color: const Color(0xff3A0DBB),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const FormHeadingText(
                            headings: "Submit",
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FormHeadingText(
                            headings: "Resend OTP: ",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: lightBlack,
                          ),
                          FormHeadingText(
                            headings: "3s",
                            fontSize: 14,
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
        ),
      ),
    );
  }
}
