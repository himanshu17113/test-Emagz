import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/constant/data.dart';
import 'package:emagz_vendor/screens/auth/common_auth_screen.dart';
import 'package:emagz_vendor/screens/support/support_screen.dart';
import 'package:emagz_vendor/social_media/common/common_appbar.dart';
import 'package:emagz_vendor/social_media/controller/auth/hive_db.dart';
import 'package:emagz_vendor/social_media/models/user_schema.dart';
import 'package:emagz_vendor/social_media/screens/account/controllers/account_setup_controller.dart';
import 'package:emagz_vendor/social_media/screens/settings/personal_page/widgets/setting_common_tile.dart';
import 'package:emagz_vendor/social_media/screens/settings/privacy/privacy_setting_screen.dart';
import 'package:emagz_vendor/social_media/screens/settings/security/security_screen.dart';
import 'package:emagz_vendor/templates/choose_template/choose_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../templates/choose_template/webview.dart';
import '../../../controller/home/home_controller.dart';
import '../../profile_insight/profile_insight_screen.dart';

class PersonalPageSetting extends StatefulWidget {
  const PersonalPageSetting({Key? key}) : super(key: key);

  @override
  State<PersonalPageSetting> createState() => _PersonalPageSettingState();
}

class _PersonalPageSettingState extends State<PersonalPageSetting> {
  final SetupAccount accountSetupController = Get.put(SetupAccount());

  final ImagePicker picker = ImagePicker();
  XFile? image;

  @override
  void initState() {
    super.initState();
    if (constuser?.sId == null) {
      HiveDB.getCurrentUserDetail();
      setState(() {});
    }
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
              const Text(
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
                  height: 300,
                  decoration: BoxDecoration(
                    color: whiteAcent,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ValueListenableBuilder<Box>(
                              valueListenable:
                                  Hive.box("secretes").listenable(),
                              builder: (context, box, widget) {
                                UserSchema user = box.get("user");
                                return Stack(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        user.ProfilePic ??
                                            constuser?.ProfilePic ??
                                            "",
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
                                            onPressed: () async {
                                              image = await picker.pickImage(
                                                  source: ImageSource.gallery);
                                              user.ProfilePic =
                                                  await accountSetupController
                                                      .uploadProfilePic(image);

                                              box.put('user', user);
                                            },
                                            icon: const Icon(
                                              Icons.camera_alt,
                                              color: blackButtonColor,
                                              size: 10,
                                            ),
                                          ),
                                        ))
                                  ],
                                );
                              }),
                          const SizedBox(
                            width: 25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                overflow: TextOverflow.ellipsis,
                                constuser?.displayName ?? "loding..",
                                // user != null
                                //     ? user!.accountType == "professional"
                                //         ? user!.username!
                                //         : user?.displayName ?? 'loding..'
                                //     : "laoding...",
                                style: const TextStyle(
                                    color: blackButtonColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                overflow: TextOverflow.ellipsis,
                                constuser?.username ?? "loding..",
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
                      const Text(
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
                          const Text(
                            "Change to business account",
                            style: TextStyle(
                                color: black,
                                fontSize: 10,
                                fontWeight: FontWeight.w600),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const ChooseTemplate(isReg: false));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              decoration: const BoxDecoration(
                                // borderRadius: BorderRadius.circular(10),
                                color: chipColor,
                              ),
                              child: const Text(
                                "Change Persona",
                                style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      GestureDetector(
                        onTap: () async {
                      

                          Get.to(() => OwnWebView(
                          
                              ));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          decoration: const BoxDecoration(
                            // borderRadius: BorderRadius.circular(10),
                            color: chipColor,
                          ),
                          child: const Text(
                            "View/Edit your persona",
                            style: TextStyle(
                                color: whiteColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Account",
                style: TextStyle(
                    color: blackButtonColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 2),
              const Text(
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
                  const Text(
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
              const Text(
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
              InkWell(
                onTap: () {
                  Get.to(() => const SupportScreen());
                },
                child: PreferenceTile(
                  isBlue: false,
                  title: "Support",
                  textDesc: 'We are here to Help',
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
                      const Text(
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
                      const Text(
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
                      const Text(
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
              const Text(
                "Blocked Users",
                style: TextStyle(
                    color: blackButtonColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 5,
              ),

              const Text(
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
              const Text(
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
                  final homePostsController =
                      Get.find<HomePostsController>(tag: 'HomePostsController');
                  homePostsController.page = 0;
                  //   Get.deleteAll(force: true);
                  await HiveDB.clearDB();
                  Get.off(() => const CommonAuthScreen());
                },
                child: Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 54,
                  decoration: BoxDecoration(
                      color: blackShaded,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text(
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
                child: const Text(
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
