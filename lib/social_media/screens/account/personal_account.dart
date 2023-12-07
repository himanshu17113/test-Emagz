
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/controller/auth/auth_controller.dart';
import 'package:flutter/material.dart';

class PersonalAccountScreen extends StatefulWidget {
  final String? suggestedName;
  const PersonalAccountScreen({Key? key,this.suggestedName}) : super(key: key);

  @override
  State<PersonalAccountScreen> createState() => _PersonalAccountScreenState();
}

class _PersonalAccountScreenState extends State<PersonalAccountScreen> {

  var authController =  AuthController() ;

  int value = 1;
  @override
  Widget build(BuildContext context) {
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
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
                height: 360,
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
                      "Let’s Get Started",
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
                    Text(
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
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      height: 35,
                      child: TextFormField(
                        // controller: controller,
                        // maxLines: maxLines,
                        cursorColor: grayColor,
                        // keyboardType: TextInputType.n,
                        // autofocus: true,
                        enabled: widget.suggestedName == null,
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(
                              color: Color(
                                0xff818181,
                              ),
                              fontWeight: FontWeight.bold,
                              fontSize: 9),
                          fillColor: const Color(0xffF1F1F1),
                          counterText: "",
                          hintText: widget.suggestedName ?? "new user-name",
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
                    Text(
                      "Select account type",
                      style: TextStyle(
                          color: lightBlack,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: customRadioButton("Personal Account", 1)),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: customRadioButton("Business Account", 2)),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        authController.postUserProfileType(value);
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
                        child:  (authController.isUserlogging ) ? const CircularProgressIndicator(color: Colors.white,) :Text(
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

  Widget customRadioButton(String text, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          value = index;
        });
      },
      child: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        height: 40,
        decoration: BoxDecoration(
            color: (value == index) ? chipColor : selectionButton,
            // border: Border.all(
            //   color: (value == index) ? chipColor : Colors.black,
            // ),
            borderRadius: BorderRadius.circular(5)),
        child: Text(
          text,
          style: TextStyle(
              color: (value == index)
                  ? whiteColor
                  : blackButtonColor.withOpacity(.5),
              fontSize: 9,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
