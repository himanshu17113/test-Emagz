import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constant/colors.dart';
import '../../../../screens/auth/widgets/my_custom_textfiled.dart';

class DeactivateAccountScreen extends StatefulWidget {
  const DeactivateAccountScreen({super.key});

  @override
  State<DeactivateAccountScreen> createState() =>
      _DeactivateAccountScreenState();
}

class _DeactivateAccountScreenState extends State<DeactivateAccountScreen> {
  bool isTwoWayVerification = false;
  bool isDeactivateAccount = false;

  List durationList = ["3 Months", "6 Months", "Permanent"];
  int selectedDuration = 0;

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
                const FormHeadingText(
                  headings: "Deactivate Account",
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  width: 331,
                  child: FormHeadingText(
                      headings: "I like to deactivate account ",
                      fontSize: 8,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff212121)),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  width: 331,
                  child: FormHeadingText(
                      headings: "NOTE: If not reactivated for 3 months, Your account data and User Data will be deleted from our DataBase ",
                      fontSize: 8,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff212121)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    durationList.length,
                    (index) => InkWell(
                      onTap: () {
                        setState(() {
                          selectedDuration = index;
                        });
                      },
                      child: Container(
                        width: 80,
                        // padding: const EdgeInsets.symmetric(horizontal: 30),
                        alignment: Alignment.center,
                        height: 32,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            color: selectedDuration == index
                                ? const Color(0xffFE5151).withOpacity(.21)
                                : null),
                        child: FormHeadingText(
                          headings: durationList[index],
                          color: selectedDuration == index
                              ? const Color(0xffFE5151)
                              : Colors.black,
                          fontSize: 8,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const FormHeadingText(
                  headings: "Reason to deactivate",
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: lightBlack,
                ),
                const SizedBox(
                  height: 20,
                ),
                const MyCustomTextfiled(
                  hint: "Select your reason",
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    FormHeadingText(
                      headings: "Message ",
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: lightBlack,
                    ),
                    FormHeadingText(
                      headings: "( Optional )",
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: toggleInactive,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const MyCustomTextfiled(
                  hint: "Select your message",
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 51,
                  decoration: BoxDecoration(
                    color: const Color(0xffFE5151),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 4.07),
                          blurRadius: 20,
                          color: const Color(0xff000040).withOpacity(.25))
                    ],
                  ),
                  child: const FormHeadingText(
                    headings: "Deactivate account",
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontSize: 14,
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
