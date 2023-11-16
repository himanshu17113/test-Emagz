// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:emagz_vendor/screens/auth/common_auth_screen.dart';
import 'package:emagz_vendor/social_media/common/bottom_nav/bottom_nav.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';

import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized(); //generic
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await Permission.camera.request();

  final hiveBox = await Hive.openBox("secretes");
  final String? token = await hiveBox.get("token");
  final bool isAutharized = token != null;
  //
  await Firebase.initializeApp(
    name: 'EmagzIos',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp(isAuthorized: isAutharized));
}

class MyApp extends StatelessWidget {
  final bool isAuthorized;
  const MyApp({
    Key? key,
    this.isAuthorized = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  Get.lazyPut<SocketController>(() => SocketController());
//JWTController authController = Get.put(JWTController(), permanent: true);
    // return GetBuilder<JWTController>(
    //   init: JWTController(),
    //   initState: (_) {},
    //   builder: (authController) {
    //     return GetMaterialApp(
    //         debugShowCheckedModeBanner: false,
    //         title: 'eMAGZ',
    //         theme: ThemeData.light().copyWith(
    //           textTheme: GoogleFonts.poppinsTextTheme(),
    //         ),
    //         home: (authController.token != null)
    //             ? BottomNavBar()
    //             : const CommonAuthScreen()
    //         // home: ChatScreen(),
    //         );
    //   },
    // );

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'eMAGZ',
        theme: ThemeData.light().copyWith(
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        home: isAuthorized ? BottomNavBar() : const CommonAuthScreen());
  }
}
