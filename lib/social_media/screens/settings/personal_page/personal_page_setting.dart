import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/auth/common_auth_screen.dart';
import 'package:emagz_vendor/social_media/common/common_appbar.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/social_media/models/user_model.dart';
import 'package:emagz_vendor/social_media/screens/account/controllers/account_setup_controller.dart';
import 'package:emagz_vendor/social_media/screens/settings/personal_page/widgets/setting_common_tile.dart';
import 'package:emagz_vendor/social_media/screens/settings/privacy/privacy_setting_screen.dart';
import 'package:emagz_vendor/social_media/screens/settings/security/security_screen.dart';
import 'package:emagz_vendor/templates/choose_template/choose_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../profile_insight/profile_insight_screen.dart';

class PersonalPageSetting extends StatefulWidget {
  const PersonalPageSetting({Key? key}) : super(key: key);

  @override
  State<PersonalPageSetting> createState() => _PersonalPageSettingState();
}

class _PersonalPageSettingState extends State<PersonalPageSetting> {
  var jwtController = Get.put(JWTController());
  var accountSetupController= Get.put(SetupAccount());

  final ImagePicker picker = ImagePicker();
  XFile? image;
  User? user;

  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  asyncInit()async{

    user = await jwtController.getCurrentUserDetail();

    setState(() {
    });
  }
  
  bool activeUser = true;
  bool myLocation = true;
  bool playNotification = true;
  bool desktopNotification = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: socialBack,
      appBar: const SocialMediaSettingAppBar(
        title: "Setting",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Text(
                "Account",
                style: TextStyle(
                    color: blackButtonColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                height: 255,
                decoration: BoxDecoration(
                  color: whiteAcent,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Stack(
                          children: [
                             CircleAvatar(
                              backgroundImage: NetworkImage(
                                 jwtController.profilePic.toString(),
                              ),
                              maxRadius: 45,
                            ),
                            Positioned(
                                top: 70,
                                left: 60,
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: whiteColor,
                                  child: IconButton(
                                    onPressed: () async
                                    {

                                      image = await picker.pickImage(source: ImageSource.gallery);
                                      await accountSetupController.uploadProfilePic(image);

                                      setState(() {

                                      });
                                    },
                                   icon: Icon(
                                      Icons.camera_alt,
                                      color: blackButtonColor,
                                      size: 10,
                                    ),
                                  ),
                                ))
                          ],
                        ),
                        const SizedBox(
                          width: 25,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              overflow: TextOverflow.ellipsis,
                              user != null ? user!.accountType == "professional" ? user!.businessName! :
                              user?.displayName?? 'loding..'  :
                              "laoding...",
                              style: TextStyle(
                                  color: blackButtonColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              overflow: TextOverflow.ellipsis,
                              user != null ?
                              user!.username! :
                              "loading...",
                              style: TextStyle(
                                  color: bottomBarIconColor.withOpacity(.8),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Bio",
                      style: TextStyle(
                          color: bottomBarIconColor.withOpacity(.8),
                          fontSize: 11,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque volutpat faucibus mattis lacus, dignissim. Sollicitudin eget ut enim, quis. Hendrerit.",
                      style: TextStyle(
                          letterSpacing: .5,
                          color: black,
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Change to business account",
                          style: TextStyle(
                              color: black,
                              fontSize: 10,
                              fontWeight: FontWeight.w600),
                        ),
                        GestureDetector(
                          onTap:(){
                            Get.to(()=> const ChooseTemplate());
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(10),
                              color: chipColor,
                            ),
                            child: Text(
                              "Change Theme",
                              style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Account",
                style: TextStyle(
                    color: blackButtonColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 2),
              Text(
                "Your friends and contacts will see when you’re active ",
                style: TextStyle(
                    color: blackButtonColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  FlutterSwitch(
                      activeColor: whiteAcent,
                      toggleColor: pendingColor,
                      padding: 2,
                      height: 20,
                      width: 45,
                      value: activeUser,
                      onToggle: (val) {
                        setState(() {
                          activeUser = val;
                        });
                      }),
                  Text(
                    "  Show my friends and contact when i’m active",
                    style: TextStyle(
                        color: blackButtonColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Preferance",
                style: TextStyle(
                    color: blackButtonColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              // const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.to(() => const ProfileInsightScreen());
                },
                child: PreferenceTile(
                  title: "Persona Insights  ",
                  isBlue: false,
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => const PrivacyScreen());
                },
                child: PreferenceTile(
                  isBlue: false,
                  title: "Privacy",
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => const SecurityScreen());
                },
                child: PreferenceTile(
                  isBlue: false,
                  title: "Security",
                ),
              ),

              Container(
                height: 64,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    color: whiteColor, borderRadius: BorderRadius.circular(15)),
                child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 25,
                      ),
                      Text(
                        "Enable my \nlocation",
                        style: TextStyle(
                            color: blackButtonColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      FlutterSwitch(
                          activeColor: whiteAcent,
                          toggleColor: pendingColor,
                          padding: 2,
                          height: 20,
                          width: 45,
                          value: myLocation,
                          onToggle: (val) {
                            setState(() {
                              myLocation = val;
                            });
                          }),
                      const SizedBox(
                        width: 25,
                      ),
                    ]),
              ),

              Container(
                height: 64,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    color: whiteColor, borderRadius: BorderRadius.circular(15)),
                child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 25,
                      ),
                      Text(
                        "Play Sound When i get \nnotification",
                        style: TextStyle(
                            color: blackButtonColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      FlutterSwitch(
                          activeColor: whiteAcent,
                          toggleColor: pendingColor,
                          padding: 2,
                          height: 20,
                          width: 45,
                          value: playNotification,
                          onToggle: (val) {
                            setState(() {
                              playNotification = val;
                            });
                          }),
                      const SizedBox(
                        width: 25,
                      ),
                    ]),
              ),
              Container(
                height: 64,
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                    color: whiteColor, borderRadius: BorderRadius.circular(15)),
                child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 25,
                      ),
                      Text(
                        "Enable desktop  \nnotification",
                        style: TextStyle(
                            color: blackButtonColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      FlutterSwitch(
                          activeColor: whiteAcent,
                          toggleColor: pendingColor,
                          padding: 2,
                          height: 20,
                          width: 45,
                          value: desktopNotification,
                          onToggle: (val) {
                            setState(() {
                              desktopNotification = val;
                            });
                          }),
                      const SizedBox(
                        width: 25,
                      ),
                    ]),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Blocked Users",
                style: TextStyle(
                    color: blackButtonColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 5,
              ),

              Text(
                "Once you blocked someone they will no longer to see things that you post on your feed , tag you , invite you or start a conversation with you. However you can unblock them later if you want ",
                style: TextStyle(
                    color: blackButtonColor,
                    fontSize: 12,
                    letterSpacing: .6,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Manage blocked users",
                style: TextStyle(
                    color: chipColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () async {
                  await jwtController.setAuthToken(null, null);
                  Get.off(()=>const CommonAuthScreen());
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 54,
                  decoration: BoxDecoration(
                      color: blackShaded,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "Log Out",
                    style: TextStyle(
                        color: whiteColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.center,
                child: Text(
                  "Add another account",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: blackShaded,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
