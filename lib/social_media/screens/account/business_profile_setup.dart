import 'dart:io';

import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/screens/account/controllers/account_setup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BusinessProfileSetupScreen extends StatefulWidget {
  const BusinessProfileSetupScreen({Key? key}) : super(key: key);

  @override
  State<BusinessProfileSetupScreen> createState() => _BusinessProfileSetupScreenState();
}

class _BusinessProfileSetupScreenState extends State<BusinessProfileSetupScreen> {
  final ImagePicker picker = ImagePicker();

  XFile? image;

  @override
  Widget build(BuildContext context) {

    var accountSetupController = Get.put(SetupAccount());

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
                  width: 100,
                  color: Colors.white.withOpacity(.8),
                ),
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 20, bottom: 10),
                // height: 425,
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
                      "Set up your\nProfessional persona",
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
                      height: 20,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () async{
                          image = await picker.pickImage(source: ImageSource.gallery);
                          setState(() {
                          });
                          },
                        child: (image == null) ? const CircleAvatar(
                          radius: 45,
                          backgroundColor: Color(0xffF0F0F0),
                          child: Text(
                            "Upload Logo",
                            style: TextStyle(
                                color: Color(0xffD0D0D0),
                                fontSize: 10,
                                fontWeight: FontWeight.w500),
                          ),
                        ) : CircleAvatar(
                          radius: 45,
                          backgroundImage: FileImage(File(image!.path)),
                        ) ,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Business Name",
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
                      height: 35,
                      child: TextFormField(
                        controller: accountSetupController.businessNameController,
                        // maxLines: maxLines,
                        cursorColor: grayColor,
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
                          hintText: "UXM",
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
                      height: 5,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Business Type",
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
                      height: 35,
                      child: TextFormField(
                        controller: accountSetupController.businessTypeController,
                        // maxLines: maxLines,
                        cursorColor: grayColor,
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
                          hintText: "UXM",
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
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {
                        if(image == null){
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Please Select logo image")));
                          // Get.("Error", "");
                        }else {
                          accountSetupController
                              .setUpProfessionalAccount(image!);
                          setState(() {
                          });
                        }
                        // Get.to(() => BusinessAccountConfirmationScreen());
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 48,
                        decoration: BoxDecoration(
                            color: chipColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: (accountSetupController.isUserRegiserting.value) ?
                          const CircularProgressIndicator(color: Colors.white,):Text(
                          "Choose Template ",
                          style: TextStyle(
                              color: whiteColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "Skip For Now",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xff7C7C7C),
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ),

                    const SizedBox(
                      height: 15,
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
