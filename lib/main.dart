import 'package:emagz_vendor/screens/auth/common_auth_screen.dart';
import 'package:emagz_vendor/social_media/common/bottom_nav/bottom_nav.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:emagz_vendor/templates/choose_template/choose_template.dart';
import 'package:emagz_vendor/templates/personal_template/p_template_two_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'social_media/controller/bottom_nav_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await Hive.openBox("secretes");
  Get.put(NavController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authController = Get.put(JWTController(), permanent: true);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eMAGZ',
      theme: ThemeData.light().copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
       //home: PTemplateTwoScreen(),
      // home: TemplateFiveScreen(),
      //home: DefaultBusinesstempScreen(),
      // home: PersonalProfileInsightScreen(),
      //  home: SupportScreen(),
      //home: ChooseTemplate(),
    // home: const BottomNavBar(),
      home: Obx(() =>  authController.isAuthorised.value ? const BottomNavBar() : const CommonAuthScreen()),
      // home: ChatScreen(),
    );
  }
}
