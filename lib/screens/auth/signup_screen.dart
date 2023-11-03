import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:emagz_vendor/social_media/controller/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../common/common_snackbar.dart';
 
import 'widgets/my_custom_textfiled.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _firebaseAuth = FirebaseAuth.instance;

  final authController = Get.put(AuthController());

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  Future<void> _handleSignIn() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    debugPrint(googleUser?.email);
    if (googleUser != null) {
      // Get the authentication token
      final GoogleSignInAuthentication googleAuth = await googleUser
          .authentication;
      authController.appleRegister(
          googleUser.email, googleUser.id, googleUser.photoUrl.toString(),
          googleUser.displayName.toString());
    }
  }

  Future<void> _handleFacebookSignIn() async{
    final LoginResult login=await FacebookAuth.instance.login();
    final OAuthCredential facebookauthCredential=FacebookAuthProvider.credential(login.accessToken!.token);
    final UserCredential userCred=await _firebaseAuth.signInWithCredential(facebookauthCredential);
    if(userCred.user!.photoURL!=null && userCred.user!.displayName!=null){
      authController.appleRegister(
          userCred.user!.email!,userCred.user!.uid,userCred.user!.photoURL!,userCred.user!.displayName!);
    }



  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
  String _selectedGender=' Male'; // Variable to hold the selected gender

  // List of genders for the dropdown
  final List<String> _genders = [' Male', ' Female', ' Other'];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FormHeadingText(
              color: signInHeading,
              headings: "Name",
            ),
            MyCustomTextfiled(
              controller: authController.userNameController,
            ),
            SizedBox(
              height: size.height * .01,
            ),
            FormHeadingText(
              color: signInHeading,
              // headings: "E-mail / Phone no",
              headings: "E-mail",
            ),
            MyCustomTextfiled(
              inputType: TextInputType.emailAddress,
              controller: authController.emailController,
            ),
            SizedBox(
              height: size.height * .01,
            ),
            FormHeadingText(
              color: signInHeading,
              headings: "Date of birth",
            ),
            MyCustomTextfiled(
              onTap: () async => await authController.pickDate(context),
              controller: authController.dobController,
            ),
            SizedBox(
              height: size.height * .01,
            ),
            FormHeadingText(
              color: signInHeading,
              headings: "Choose Gender",
            ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: Container(
            //color: Color(0xffF2F2F2) ,
            decoration: BoxDecoration(
               color: const Color(0xffF2F2F2),
                borderRadius: BorderRadius.circular(10)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                style: const TextStyle(
                  backgroundColor:  Color(0xffF2F2F2), // Set the dropdown's background color here
                ),
                value: _selectedGender,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedGender = newValue!;
                  });
                },
                items: _genders.map<DropdownMenuItem<String>>((String gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: FormHeadingText(
                      color: signInHeading,
                      headings:gender,
                    ),
                  );
                }).toList(),
                hint: const Text('Select Gender'), // Hint text for the dropdown
              ),
            ),
          ),
        ),
            SizedBox(
              height: size.height * .01,
            ),
            FormHeadingText(
              color: signInHeading,
              headings: "password",
            ),
            MyCustomTextfiled(
              controller: authController.passwordController,
            ),
            SizedBox(
              height: size.height * .01,
            ),
            FormHeadingText(
              color: signInHeading,
              headings: "Confirm password",
            ),
            MyCustomTextfiled(
              controller: authController.confirmPasswordController,
            ),
            SizedBox(
              height: size.height * .03,
            ),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () async {
                  if (authController.userNameController.text.isEmpty) {
                    CustomSnackbar.show("Please enter user name ");
                  } else if (authController.emailController.text.isEmpty || !authController.emailController.text.isEmail) {
                    CustomSnackbar.show("Please enter correct email ");
                  } else if (authController.dobController.text.isEmpty) {
                    CustomSnackbar.show("Please choose your dob");
                  } else if (authController.passwordController.text.isEmpty || authController.passwordController.text.length < 6) {
                    CustomSnackbar.show("Please enter at least 8 digit password! password must contain special charecter,numberic value ");
                  } else if (authController.passwordController.text != authController.confirmPasswordController.text) {
                    CustomSnackbar.show("Password and confirm passsword shuld be same");
                  } else {
                    bool res = await authController.registerUser();
                    if (res) {
                      authController.tabController!.index = 1;
                    } else {}
                  }
                },
                child: Obx(() {
                  return Container(
                    alignment: Alignment.center,
                    height: 45,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      gradient: buttonGradient,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: authController.isUserRegiserting.value
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "Sign Up",
                            style: TextStyle(color: whiteColor, fontSize: 15),
                          ),
                  );
                }),
              ),
            ),
            SizedBox(
              height: size.height * .03,
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(vertical: 1),
              child: Text(
                "Continue With",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: unselectedLabel),
              ),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            Center(
              child: Container(
                width: 200,
                // margin: const EdgeInsets.only(top: 10),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: ()async{
                        _handleSignIn();
                      },
                      child: CircleAvatar(
                        backgroundColor: whiteColor,
                        radius: 15,
                        backgroundImage: const CachedNetworkImageProvider("https://cdn-icons-png.flaticon.com/512/2991/2991148.png"),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: ()async{
                        await _handleFacebookSignIn();

                      },
                      child: CircleAvatar(
                        backgroundColor: whiteColor,
                        radius: 15,
                        backgroundImage: const CachedNetworkImageProvider(
                            "https://www.edigitalagency.com.au/wp-content/uploads/Facebook-logo-blue-circle-large-transparent-png.png"),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                  ],
                ),
              ),

            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child:Platform.isIOS?
              SizedBox(
                width: 400,
                child: SignInWithAppleButton(
                    style: SignInWithAppleButtonStyle.black,
                    text: 'Sign In With Apple',
                    borderRadius: BorderRadius.circular(20),
                    onPressed: ()async
                    {
                        final rawNonce = generateNonce();
                        final nonce = sha256ofString(rawNonce);

                        try {
                          // Request credential for the currently signed in Apple account.
                          final appleCredential = await SignInWithApple.getAppleIDCredential(
                            scopes: [
                              AppleIDAuthorizationScopes.email,
                              AppleIDAuthorizationScopes.fullName,
                            ],
                            nonce: nonce,
                          );

                          print(appleCredential.authorizationCode);

                          // Create an `OAuthCredential` from the credential returned by Apple.
                          final oauthCredential = OAuthProvider("apple.com").credential(
                            idToken: appleCredential.identityToken,
                            rawNonce: rawNonce,
                          );

                          // Sign in the user with Firebase. If the nonce we generated earlier does
                          // not match the nonce in `appleCredential.identityToken`, sign in will fail.
                          final authResult =
                          await _firebaseAuth.signInWithCredential(oauthCredential);

                          final displayName =
                              '${appleCredential.givenName} ${appleCredential.familyName}';
                          final userEmail = '${appleCredential.email}';
                          final photoUrl='${appleCredential.identityToken}';
                          if(appleCredential.email!=null && appleCredential.givenName!=null && appleCredential.familyName!=null && appleCredential.identityToken!=null) {
                            authController.appleRegister(
                                appleCredential.email!, appleCredential.identityToken!,photoUrl, displayName);
                          }
                          else{
                            Get.snackbar('Error',"Did not recieve credentials from Apple.");
                          }

                          final firebaseUser = authResult.user;
                          print(displayName);
                          print(firebaseUser?.displayName);
                          debugPrint(firebaseUser.toString());
                        } catch (exception) {
                          print(exception);

                        }
                      }



                ),
              ):
              const SizedBox(),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
