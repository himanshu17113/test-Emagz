import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/approval_form/approval_status/application_submitted.dart';
import 'package:emagz_vendor/screens/approval_form/widgets/approval_form_heading.dart';
import 'package:emagz_vendor/screens/approval_form/widgets/approval_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ApprovalFormScreen extends StatelessWidget {
  const ApprovalFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/png/form_bg.png",
          ),
          fit: BoxFit.fitWidth,
        ),

        // gradient: LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        //   colors: [
        //     Color(0xff090770),
        //     Color(0xff4D50B6),
        //   ],
        // ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/png/menu.png"),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          "eMarket",
                          style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SvgPicture.asset(
                      "assets/svg/Notify.svg",
                      width: 45,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Approval Form",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 21, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Basic Details",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                const ApprovalFormHeading(
                  tittle: "Name",
                ),
                const ApprovalTextField(),
                const Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ApprovalFormHeading(
                            tittle: "E-mail",
                          ),
                          ApprovalTextField(),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ApprovalFormHeading(
                            tittle: "Phone No.",
                          ),
                          ApprovalTextField(),
                        ],
                      ),
                    )
                  ],
                ),
                const ApprovalFormHeading(
                  tittle: "Address",
                ),
                const ApprovalTextField(
                  maxLines: 2,
                ),
                const Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ApprovalFormHeading(
                            tittle: "City",
                          ),
                          ApprovalTextField(),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ApprovalFormHeading(
                            tittle: "State",
                          ),
                          ApprovalTextField(),
                        ],
                      ),
                    )
                  ],
                ),
                const Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ApprovalFormHeading(
                            tittle: "Country",
                          ),
                          ApprovalTextField(),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ApprovalFormHeading(
                            tittle: "Pincode",
                          ),
                          ApprovalTextField(),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Business Details",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                const ApprovalFormHeading(
                  tittle: "Business Name",
                ),
                const ApprovalTextField(),
                const Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ApprovalFormHeading(
                            tittle: "PAN Number",
                          ),
                          ApprovalTextField(),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ApprovalFormHeading(
                            tittle: "Business Type",
                          ),
                          ApprovalTextField(),
                        ],
                      ),
                    )
                  ],
                ),
                const ApprovalFormHeading(
                  tittle: "Business Address",
                ),
                const ApprovalTextField(
                  maxLines: 2,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ApprovalFormHeading(
                            tittle: "Address Proof",
                          ),
                          ApprovalTextField(
                            sufixIcon: Container(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: SvgPicture.asset(
                                  "assets/svg/Frame.svg",
                                )),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ApprovalFormHeading(
                            tittle: "GSTIN Number",
                            isRequired: false,
                          ),
                          ApprovalTextField(),
                        ],
                      ),
                    )
                  ],
                ),
                const ApprovalFormHeading(
                  tittle: "Pincode",
                ),
                SizedBox(width: size.width / 2.2, child: const ApprovalTextField()),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const ApprovalFormHeading(
                          tittle: "Signature",
                          isRequired: false,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: .8,
                              color: whiteColor.withOpacity(.25),
                            ),
                          ),
                          child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 35),
                              child: SvgPicture.asset(
                                "assets/svg/Frame.svg",
                              )),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const ApprovalFormHeading(
                          tittle: "Bannaer Image",
                          isRequired: false,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: .8,
                              color: whiteColor.withOpacity(.25),
                            ),
                          ),
                          child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 35),
                              child: SvgPicture.asset(
                                "assets/svg/Frame.svg",
                              )),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const ApprovalFormHeading(
                          tittle: "Logo Image",
                          isRequired: false,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: .8,
                              color: whiteColor.withOpacity(.25),
                            ),
                          ),
                          child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 35),
                              child: SvgPicture.asset(
                                "assets/svg/Frame.svg",
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 45,
                    width: size.width / 1.8,
                    child: ElevatedButton(
                      onPressed: () {
                        // Get.to(() => const ZoomDrawerScreen());
                        Get.to(() => const ApplicationSubmittedScreen());
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: blackButtonColor),
                      child: const Text("Apply"),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  alignment: Alignment.center,
                  child: const Text(
                    "By clicking on apply you agree to our Terms of Use and Privacy Policy",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.w500),
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
