import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/constant/data.dart';
import 'package:emagz_vendor/screens/auth/common_auth_screen.dart';
import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:emagz_vendor/screens/auth/widgets/my_custom_textfiled.dart';
import 'package:emagz_vendor/screens/support/support_screen.dart';
import 'package:emagz_vendor/social_media/controller/auth/hive_db.dart';
import 'package:emagz_vendor/social_media/models/user_schema.dart';
import 'package:emagz_vendor/social_media/screens/account/controllers/account_setup_controller.dart';
import 'package:emagz_vendor/social_media/screens/chat/controllers/socketController.dart';
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
  final socketController = Get.find<SocketController>(tag: "notify");

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

  bool myLocation = true;
  bool playNotification = true;
  bool desktopNotification = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: socialBack,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: false,
        title: const Text(
          "Setting",
          style: TextStyle(
              color: blackButtonColor,
              fontSize: 22,
              fontWeight: FontWeight.w600),
        ),
        actions: [
          InkWell(
            onTap: () {
              final HomePostsController homePostsController =
                  Get.find(tag: "HomePostsController");
              homePostsController.pageUpdate(0);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              alignment: Alignment.center,
              // height: 50,
              // width: 50,
              padding: const EdgeInsets.fromLTRB(15, 5, 5, 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: chipColor,
              ),
              child: const Icon(
                Icons.arrow_back_ios,
                size: 24,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Account",
                style: TextStyle(
                    color: blackButtonColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),

            Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
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
                            valueListenable: Hive.box("secretes").listenable(),
                            builder: (context, box, widget) {
                              UserSchema user = box.get("user");
                              return Stack(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: CachedNetworkImageProvider(
                                      user.profilePic ??
                                          constuser?.profilePic ??
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
                                            user.profilePic =
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
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              overflow: TextOverflow.ellipsis,
                              constuser?.username ?? "loding..",
                              // user != null
                              //     ? user!.accountType == "professional"
                              //         ? user!.username!
                              //         : user?.displayName ?? 'loding..'
                              //     : "laoding...",
                              style: const TextStyle(
                                  color: blackButtonColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              overflow: TextOverflow.ellipsis,
                              constuser?.displayName ?? "loding..",
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Bio",
                          style: TextStyle(
                              color: bottomBarIconColor.withOpacity(.8),
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                        GestureDetector(
                          onTap: () => updateBio(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 10),
                            decoration: const BoxDecoration(
                              // borderRadius: BorderRadius.circular(10),
                              color: chipColor,
                            ),
                            child: const Text(
                              "Change Bio",
                              style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        constuser?.bio ??
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque volutpat faucibus mattis lacus, dignissim. Sollicitudin eget ut enim, quis. Hendrerit.",
                        style: const TextStyle(
                            letterSpacing: .5,
                            color: black,
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
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
                              Get.to(() => const ChooseTemplate(
                                    isReg: false,
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
                    ),
                    GestureDetector(
                      onTap: () async {
                        Get.to(() => const OwnWebView());
                      },
                      child: const Card(
                        color: chipColor,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          child: Text(
                            "View/Edit your persona",
                            style: TextStyle(
                                color: whiteColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),

            const Text(
              "Account",
              style: TextStyle(
                  color: blackButtonColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Text(
                "Your friends and contacts will see when you’re active ",
                style: TextStyle(
                    color: blackButtonColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
            ),

            Row(
              children: [
                ValueListenableBuilder<Box>(
                    valueListenable: Hive.box("secretes").listenable(),
                    builder: (context, box, widget) {
                      bool isOnline = box.get('isonline', defaultValue: true);
                      return FlutterSwitch(
                          activeColor: whiteAcent,
                          toggleColor: pendingColor,
                          padding: 2,
                          height: 20,
                          width: 45,
                          value: isOnline,
                          onToggle: (isOnline) {
                            box.put('isonline', isOnline);
                            if (isOnline) {
                              debugPrint(isOnline.toString());
                              socketController.iAmActive();
                            } else {
                              socketController.iamOffline();
                            }
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

            PreferenceTile(
                title: "Persona Insights  ",
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const ProfileInsightScreen()))),

            PreferenceTile(
                title: "Privacy",
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const PrivacyScreen()))),

            PreferenceTile(
                title: "Security",
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const SecurityScreen()))),

            PreferenceTile(
                title: "Support",
                textDesc: 'We are here to Help',
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const SupportScreen()))),

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
                  color: chipColor, fontSize: 12, fontWeight: FontWeight.w600),
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
    );
  }

  updateBio(BuildContext context) {
    TextEditingController bioControllaer = TextEditingController();
    return showModalBottomSheet(
        isScrollControlled: true,
        elevation: 0.0,
        barrierColor: const Color(0xff252525).withOpacity(.4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        context: context,
        builder: (ctx) {
          return Container(
            height: MediaQuery.of(context).size.height * .45 +
                MediaQuery.of(context).viewInsets.bottom,
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
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
                const FormHeadingText(
                  headings: "Update Your",
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  color: lightBlack,
                ),
                const SizedBox(
                  height: 5,
                ),
                const FormHeadingText(
                  headings: "Please enter your Bio",
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: unselectedLabel,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: FormHeadingText(
                    headings: "New Bio",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: lightBlack,
                  ),
                ),
                MyCustomTextfiled(
                  hint: "your bio",
                  controller: bioControllaer,
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      constuser!.bio = bioControllaer.text;
                    });
                    await accountSetupController.updateBio(bioControllaer.text);

                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 51,
                    decoration: BoxDecoration(
                      color: const Color(0xff3A0DBB),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 4.07),
                            blurRadius: 20,
                            color: const Color(0xff000040).withOpacity(.25))
                      ],
                    ),
                    child: const FormHeadingText(
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
