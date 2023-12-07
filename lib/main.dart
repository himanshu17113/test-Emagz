import 'dart:io';
import 'package:emagz_vendor/constant/data.dart';
import 'package:emagz_vendor/social_media/controller/auth/hive_db.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:emagz_vendor/screens/auth/common_auth_screen.dart';
import 'package:emagz_vendor/social_media/common/bottom_nav/bottom_nav.dart';
import 'firebase_options.dart';
import 'social_media/models/user_schema.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
   Hive.registerAdapter(UserSchemaAdapter());
  await Permission.camera.request();
  await Hive.openBox("secretes");
  globToken = await HiveDB.getAuthToken();
  globUserId = await HiveDB.getUserID();
  if (globUserId != null) {
    constuser = await HiveDB.getCurrentUserDetail();
  }
  await Firebase.initializeApp(
    name: 'EmagzIos',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'eMAGZ',
        theme: ThemeData.light().copyWith(
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        home: globUserId != null ? BottomNavBar() : const CommonAuthScreen());
  }
}
