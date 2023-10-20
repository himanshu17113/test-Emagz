import 'package:emagz_vendor/screens/auth/common_auth_screen.dart';
import 'package:emagz_vendor/social_media/common/bottom_nav/bottom_nav.dart';
import 'package:emagz_vendor/social_media/controller/auth/jwtcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'firebase_options.dart';
import 'social_media/controller/bottom_nav_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized(); //generic
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  await Permission.camera.request();
  await Hive.openBox("secretes");
  await Firebase.initializeApp(
    name: 'EmagzIos',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(NavController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  Get.lazyPut<SocketController>(() => SocketController());
    JWTController authController = Get.put(JWTController(), permanent: true);
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
        //home: ChooseTemplate()
        // home: const BottomNavBar(),
        home: authController.isAuthorised.value
            ? BottomNavBar()
            : const CommonAuthScreen()
        // home: ChatScreen(),
        );
  }
}
