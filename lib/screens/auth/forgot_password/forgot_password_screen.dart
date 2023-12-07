import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:emagz_vendor/social_media/controller/auth/auth_controller.dart';
import 'package:flutter/material.dart';

import '../../../constant/colors.dart';
import '../widgets/my_custom_textfiled.dart';

import '../widgets/my_gradient_button.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    var authController =  AuthController() ;

    Size size = MediaQuery.of(context).size;

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
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FormHeadingText(
                          headings: "Forget Password",
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: lightBlack,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const FormHeadingText(
                          headings:
                              "Please enter your registered mobile number o0r email id to reset your password",
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: unselectedLabel,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const FormHeadingText(
                          headings: "Email or Phone no ",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: lightBlack,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        MyCustomTextfiled(
                            hint: "Enter your email or mobile number",
                            controller: authController.forgotPasswordEmailController,
                          onChange: (text) {
                              setState(() {
                              });
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child:  authController.isUserRegiserting  ? const CircularProgressIndicator():  MyGradientButton(
                              isEnabled: authController.forgotPasswordEmailController.value.text.isNotEmpty,
                              onTap: () async{
                                await authController.sendForgotPasswordRequest();
                              },
                            ),
                           
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Center(
                          child: FormHeadingText(
                            headings: "Back To Sign In",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: lightBlack,
                          ),
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
