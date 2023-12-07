import 'package:emagz_vendor/screens/auth/widgets/my_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constant/colors.dart';
import '../../../social_media/controller/auth/auth_controller.dart';
import '../widgets/form_haeding_text.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final authController = AuthController();
  bool isPasswordSatisfied = false;
  int passwordSecurityLevel = 0;
  TextEditingController recheckController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xffF8F8F8),
              Color(0xffDCE5FF),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              FormHeadingText(
                headings: "Change Password",
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: lightBlack,
              ),
              const SizedBox(
                height: 10,
              ),
              FormHeadingText(
                headings: "Please Change your password and protect your account",
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: unselectedLabel,
              ),
              const SizedBox(
                height: 20,
              ),
              FormHeadingText(
                headings: "New Password",
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: lightBlack,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: authController.passWordController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.only(left: 10, top: 12, bottom: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.blue.withOpacity(.3),
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.blue.withOpacity(.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.blue.withOpacity(.3),
                    ),
                  ),
                ),
                onChanged: (v) {
                  debugPrint(v);
                  // authController.passwordText.value = v;
                  // setState(() {});
                  setState(() {});
                  authController.isUpperText
                      ? authController.isLowerText
                          ? authController.isNumber
                              ? authController.specialChar
                                  ? authController.length 
                                      ? passwordSecurityLevel = 5
                                      : passwordSecurityLevel = 4
                                  : passwordSecurityLevel = 3
                              : passwordSecurityLevel = 2
                          : passwordSecurityLevel = 1
                      : passwordSecurityLevel = 0;
                  authController.checkPassword(v);
                },
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 5),
                      height: 6,
                      color: passwordSecurityLevel > 0 ? Colors.blueGrey : const Color(0xffD9D9D9),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 5),
                      height: 6,
                      color: passwordSecurityLevel > 1 ? Colors.lightGreen : const Color(0xffD9D9D9),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 5),
                      height: 6,
                      color: passwordSecurityLevel > 2 ? Colors.yellow : const Color(0xffD9D9D9),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 5),
                      height: 6,
                      color: passwordSecurityLevel > 3 ? Colors.orange : const Color(0xffD9D9D9),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(right: 5),
                      height: 6,
                      color: passwordSecurityLevel > 4 ? Colors.red : const Color(0xffD9D9D9),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Obx(
                () => WarningTextWidget(
                  isChecked: authController.isUpperText,
                  title: "Password must have one uppercase letter",
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Obx(
                () => WarningTextWidget(
                  isChecked: authController.isLowerText,
                  title: "Password must have one lowercase letter",
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              WarningTextWidget(
                isChecked: authController.isNumber,
                title: "Password must contain at least one number",
              ),
              const SizedBox(
                height: 5,
              ),
              WarningTextWidget(
                isChecked: authController.specialChar,
                title: "Password must contain one special character @\$",
              ),
              const SizedBox(
                height: 5,
              ),
              WarningTextWidget(
                isChecked: authController.specialChar,
                title: "Password must be 8 Digits long",
              ),
              const SizedBox(
                height: 25,
              ),
              FormHeadingText(
                headings: "Confirm Password",
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: lightBlack,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: recheckController,
                // controller: authController.passWordController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.only(left: 10, top: 12, bottom: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.blue.withOpacity(.3),
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.blue.withOpacity(.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.blue.withOpacity(.3),
                    ),
                  ),
                ),
                onChanged: (v) {
                  debugPrint(v);
                  setState(() {});
                  // authController.passwordText.value = v;
                  // setState(() {});
                  // authController.checkPassword(v);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              WarningTextWidget(
                isChecked: recheckController.text == authController.passWordController.text,
                title: "Password is matched with above password",
              ),
              const SizedBox(
                height: 30,
              ),
              MyGradientButton(
                isEnabled: recheckController.text == authController.passWordController.text,
                onTap: () {
                  if (recheckController.text == authController.passWordController.text) {
                    authController.changePassword(authController.passWordController.text);
                  }
                },
                title: "Change Password",
              )
            ],
          ),
        ),
      ),
    );
  }
}

class WarningTextWidget extends StatelessWidget {
  final bool isChecked;
  final String title;
  const WarningTextWidget({
    super.key,
    required this.title,
    required this.isChecked,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          width: 10,
        ),
        Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(color: isChecked ? Colors.lightGreen : null, border: Border.all(color: Colors.black, width: 1.5), shape: BoxShape.circle),
          child: Icon(
            isChecked ? Icons.check : Icons.close,
            color: Colors.black,
            size: 11,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        FormHeadingText(
          headings: title,
          color: lightBlack,
          fontSize: 10,
        ),
      ],
    );
  }
}
