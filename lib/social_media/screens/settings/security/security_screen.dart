import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:emagz_vendor/social_media/screens/settings/security/two_step_verification_screen.dart';
import 'package:emagz_vendor/social_media/screens/settings/security/widget/other_security_tile.dart';
import 'package:emagz_vendor/social_media/screens/settings/security/widget/personal_information_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../constant/colors.dart';
import '../../../../screens/auth/widgets/my_custom_textfiled.dart';
import '../../../../screens/auth/widgets/my_gradient_button.dart';
import '../../account/deactivate_account_screen.dart';
import '../privacy/privacy_policy_screen.dart';
import '../terms_condition/terms_and_condition_screen.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
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
                    child: const Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      child: Icon(
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
                FormHeadingText(
                  headings: "Security",
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 30,
                ),
                FormHeadingText(
                  headings: "Personal Information",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 20,
                ),
                PersonalInformationTile(
                  heading: "Name",
                  body: "Deepak",
                  onTap: () {
                    updateName(context);
                  },
                ),
                PersonalInformationTile(
                  heading: "Date Of Birth",
                  body: "21-May-1917",
                  onTap: () {
                    updateDob(context);
                  },
                ),
                PersonalInformationTile(
                  heading: "Email",
                  body: "Jhonwick@gmail.com",
                  onTap: () {
                    updateEmail(context);
                  },
                ),
                PersonalInformationTile(
                  heading: "Mobile Number",
                  body: "+91 009009090",
                  onTap: () {
                    updateMobileNo(context);
                  },
                ),
                PersonalInformationTile(
                  heading: "Address",
                  body: "Lorem ipsum dolor sit amet",
                  onTap: () {
                    updateAddress(context);
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                FormHeadingText(
                  headings: "Other Security",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.only(
                      left: 17, right: 25, top: 10, bottom: 14),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(() => TwoStepVerificationScreen());
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormHeadingText(
                                headings: "Two way Verification",
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                            SizedBox(
                              width: 150,
                              child: FormHeadingText(
                                headings:
                                    "Secure your account even more with Two-Way-Verification",
                                fontSize: 8,
                                color: toggleInactive,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      FlutterSwitch(
                        toggleSize: 10,
                        height: 18,
                        width: 38,
                        activeColor: lightSkyAcent.withOpacity(.8),
                        activeToggleColor: const Color(0xff2E5EE2),
                        inactiveColor: const Color(0xffD1D5FF),
                        onToggle: (bool value) {
                          setState(() {
                            isTwoWayVerification = value;
                          });
                        },
                        value: isTwoWayVerification,
                      )
                    ],
                  ),
                ),
                OtherSecurityTile(
                  onTap: () {
                    Get.to(() => const PrivacyPolicyScreen());
                  },
                ),
                OtherSecurityTile(
                  onTap: () {
                    Get.to(() => const TermsAndConditionScreen());
                  },
                  heading: "Term’s of use",
                  body: "Learn about our terms and condition",
                ),
                OtherSecurityTile(
                  onTap: () {},
                  heading: "Help & Support",
                  body: "Need help connect with our support team",
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.only(
                      left: 17, right: 25, top: 10, bottom: 14),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0xffFF3232),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(() => const DeactivateAccountScreen());
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FormHeadingText(
                                headings: "Deactive Account",
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: whiteColor),
                            SizedBox(
                              width: 100,
                              child: FormHeadingText(
                                headings: "I like to deactivate account ",
                                fontSize: 8,
                                color: whiteColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      FlutterSwitch(
                        toggleSize: 10,
                        height: 18,
                        width: 38,
                        activeColor: lightSkyAcent.withOpacity(.8),
                        activeToggleColor: const Color(0xff2E5EE2),
                        inactiveColor: const Color(0xffFF7C7C),
                        onToggle: (bool value) {
                          setState(() {
                            isDeactivateAccount = value;
                          });
                        },
                        value: isDeactivateAccount,
                      )
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

  updateDob(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        elevation: 0.0,
        barrierColor: const Color(0xff252525).withOpacity(.4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        context: context,
        builder: (ctx) {
          return Container(
            height: 400,
            width: double.infinity,
            padding: const EdgeInsets.all(23),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                FormHeadingText(
                  headings: "Update Date of Birth",
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  color: lightBlack,
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: 315,
                  child: FormHeadingText(
                    headings:
                        "Note:  Once Date of birth update you can change your Date of birth for next 60 days",
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: unselectedLabel,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FormHeadingText(
                  headings: "DOB*",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: lightBlack,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyCustomTextfiled(
                  hint: "12 - June - 1997",
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 51,
                  decoration: BoxDecoration(
                    color: const Color(0xff3A0DBB),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 4.07),
                          blurRadius: 20,
                          color: const Color(0xff00000040).withOpacity(.25))
                    ],
                  ),
                  child: FormHeadingText(
                    headings: "Update",
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: FormHeadingText(
                      headings: "Back",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: lightBlack.withOpacity(.45),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
  }

  updateAddress(BuildContext context) {
    return showDialog(
        barrierColor: const Color(0xff252525).withOpacity(.4),
        context: context,
        builder: (ctx) {
          return AlertDialog(
            alignment: Alignment.bottomCenter,
            contentPadding: EdgeInsets.zero,
            iconPadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.zero,
            buttonPadding: EdgeInsets.zero,
            actionsPadding: EdgeInsets.zero,
            elevation: 0.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: Container(
              height: 620,
              width: double.infinity,
              padding: const EdgeInsets.all(23),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    FormHeadingText(
                      headings: "Update Address",
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      color: lightBlack,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: 315,
                      child: FormHeadingText(
                        headings: "Please fill the form to update your address",
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: unselectedLabel,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FormHeadingText(
                      headings: "Address line 1",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: lightBlack,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyCustomTextfiled(
                      hint: "Enter Address",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FormHeadingText(
                      headings: "Address line 2",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: lightBlack,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyCustomTextfiled(
                      hint: "Address line 2",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FormHeadingText(
                                headings: "City",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: lightBlack,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              MyCustomTextfiled(
                                hint: "City",
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FormHeadingText(
                                headings: "State",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: lightBlack,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              MyCustomTextfiled(
                                hint: "State",
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FormHeadingText(
                                headings: "District",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: lightBlack,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              MyCustomTextfiled(
                                hint: "District",
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FormHeadingText(
                                headings: "Pin Code",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: lightBlack,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              MyCustomTextfiled(
                                hint: "Pin Code",
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 51,
                      decoration: BoxDecoration(
                        color: const Color(0xff3A0DBB),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 4.07),
                              blurRadius: 20,
                              color: const Color(0xff00000040).withOpacity(.25))
                        ],
                      ),
                      child: FormHeadingText(
                        headings: "Update",
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: FormHeadingText(
                          headings: "Back",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: lightBlack.withOpacity(.45),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  updateName(BuildContext context) {
    return showDialog(
        barrierColor: const Color(0xff252525).withOpacity(.4),
        context: context,
        builder: (ctx) {
          return AlertDialog(
              alignment: Alignment.bottomCenter,
              contentPadding: EdgeInsets.zero,
              iconPadding: EdgeInsets.zero,
              insetPadding: EdgeInsets.zero,
              titlePadding: EdgeInsets.zero,
              buttonPadding: EdgeInsets.zero,
              actionsPadding: EdgeInsets.zero,
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              content: Container(
                height: 400,
                width: double.infinity,
                padding: const EdgeInsets.all(23),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    FormHeadingText(
                      headings: "Update Name",
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      color: lightBlack,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: 315,
                      child: FormHeadingText(
                        headings:
                            "Note:  Once name update you can change your name for next 60 days",
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: unselectedLabel,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FormHeadingText(
                      headings: "Enter your name",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: lightBlack,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyCustomTextfiled(
                      hint: "Enter your new name",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 51,
                      decoration: BoxDecoration(
                        color: const Color(0xff3A0DBB),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 4.07),
                              blurRadius: 20,
                              color: const Color(0xff00000040).withOpacity(.25))
                        ],
                      ),
                      child: FormHeadingText(
                        headings: "Update",
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: FormHeadingText(
                          headings: "Back",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: lightBlack.withOpacity(.45),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ));
        });
  }

  otpVerificationModal(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        elevation: 0.0,
        barrierColor: const Color(0xff252525).withOpacity(.4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        context: context,
        builder: (ctx) {
          return Container(
            height: 400,
            width: double.infinity,
            padding: const EdgeInsets.all(23),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                FormHeadingText(
                  headings: "Verification",
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  color: lightBlack,
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: 315,
                  child: FormHeadingText(
                    headings:
                        "Please verify your updated email id by enter OTP sent to your new email id",
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: unselectedLabel,
                  ),
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
                  height: 20,
                ),
                PinCodeTextField(
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
                  onChanged: (v) {},
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 51,
                  decoration: BoxDecoration(
                    color: const Color(0xff3A0DBB),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 4.07),
                          blurRadius: 20,
                          color: const Color(0xff00000040).withOpacity(.25))
                    ],
                  ),
                  child: FormHeadingText(
                    headings: "Update",
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 14,
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
          );
        });
  }

  updateMobileNo(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        elevation: 0.0,
        barrierColor: const Color(0xff252525).withOpacity(.4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        context: context,
        builder: (ctx) {
          return Container(
            height: 400,
            width: double.infinity,
            padding: const EdgeInsets.all(23),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                FormHeadingText(
                  headings: "Update Mobile No",
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  color: lightBlack,
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: 315,
                  child: FormHeadingText(
                    headings:
                        "Please enter your new mobile number which you want to update and use",
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: unselectedLabel,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FormHeadingText(
                  headings: "New Mobile Number",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: lightBlack,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyCustomTextfiled(
                  hint: "+91 000 000 0000",
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 51,
                  decoration: BoxDecoration(
                    color: const Color(0xff3A0DBB),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 4.07),
                          blurRadius: 20,
                          color: const Color(0xff00000040).withOpacity(.25))
                    ],
                  ),
                  child: FormHeadingText(
                    headings: "Update",
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: FormHeadingText(
                      headings: "Back",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: lightBlack.withOpacity(.45),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
  }

  updateEmail(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        elevation: 0.0,
        barrierColor: const Color(0xff252525).withOpacity(.4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        context: context,
        builder: (ctx) {
          return Container(
            height: 400,
            width: double.infinity,
            padding: const EdgeInsets.all(23),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                FormHeadingText(
                  headings: "Update Email",
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  color: lightBlack,
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: 315,
                  child: FormHeadingText(
                    headings:
                        "Please enter your new email id which you want to update and use",
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: unselectedLabel,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FormHeadingText(
                  headings: "New Email",
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: lightBlack,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyCustomTextfiled(
                  hint: "Enter your email id",
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    otpVerificationModal(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 51,
                    decoration: BoxDecoration(
                      color: const Color(0xff3A0DBB),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 4.07),
                            blurRadius: 20,
                            color: const Color(0xff00000040).withOpacity(.25))
                      ],
                    ),
                    child: FormHeadingText(
                      headings: "Update",
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: FormHeadingText(
                      headings: "Back",
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: lightBlack.withOpacity(.45),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
  }
}
