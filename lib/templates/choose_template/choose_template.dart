import 'dart:io';

import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:emagz_vendor/templates/choose_template/webview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
//import 'package:get/get_core/src/get_main.dart';
import 'dart:math' as math;
import '../../constant/colors.dart';
import '../../social_media/screens/account/controllers/account_setup_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class ChooseTemplate extends StatefulWidget {
  const ChooseTemplate({Key? key}) : super(key: key);

  @override
  State<ChooseTemplate> createState() => _ChooseTemplateState();
}

class _ChooseTemplateState extends State<ChooseTemplate> {
  int value = 1;
  var accountSetUpController = Get.put(SetupAccount());
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 3,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0))),
          backgroundColor: Colors.white,
          title: FormHeadingText(
            textAlign: TextAlign.center,
            headings: 'Do You want to Use this Persona?',
            fontWeight: FontWeight.bold,
            fontSize: 16,
            isItalic: FontStyle.italic,
          ),
          content: Column(
            children: [
              Text(
                "You can always change your persona Later",
                style: TextStyle(
                    color: accountGray,
                    fontSize: 9,
                    fontWeight: FontWeight.w200),
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 200, child: customYesNoButton("Yes", 1)),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(width: 200, child: customYesNoButton("No", 2)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            // width: double.infinity,
            // decoration: const BoxDecoration(
            //   gradient: LinearGradient(
            //     begin: Alignment.bottomLeft,
            //     end: Alignment.topRight,
            //     colors: [
            //       Color(0xffF8F8F8),
            //       Color(0xffDCE5FF),
            //     ],
            //   ),
            // ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                "assets/png/new_logo.png",
                width: 50,
                color: const Color(0xff1B47C1),
              ),
              const SizedBox(
                height: 30,
              ),
              FormHeadingText(
                headings: 'Choose Your Persona',
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                "Please Choose Your Persona",
                style: TextStyle(
                    color: accountGray,
                    fontSize: 14,
                    fontWeight: FontWeight.w200),
              ),
              const SizedBox(
                height: 28,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: customRadioButton("Personal", 1)),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(child: customRadioButton("Business", 2)),
                ],
              ),
              const SizedBox(
                height: 28,
              ),
              Expanded(
                child: ListView(children: [
                  GestureDetector(
                      onTap: () {
                        Get.to(()=>WebViewPersona());
                      },
                      child: Persona(
                          "assets/png/cameronWilliamson.png",
                          "assets/png/cameronMobile.png",
                          const Color.fromRGBO(255, 199, 1, 1.0))),
                  const SizedBox(
                    height: 20,
                  ),
                  Persona(
                      "assets/png/jamesWills.png",
                      "assets/png/jamesMobile.png",
                      const Color.fromRGBO(202, 42, 243, 1.0)),
                  const SizedBox(
                    height: 20,
                  ),
                  Persona(
                      "assets/png/cameronWilliamson.png",
                      "assets/png/cameronMobile.png",
                      const Color.fromRGBO(255, 199, 1, 1.0)),
                  const SizedBox(
                    height: 20,
                  ),
                ]),
              )
            ])));
  }

  Widget Persona(String ImgPath, String MobileImgPath, Color BackGround) {
    return GestureDetector(
      onTap: () => Get.to(()=>WebViewPersona()),//_launchUrl

      child: Stack(children: [
        Container(
          height: 220,
          width: 450,
          decoration: BoxDecoration(
            color: BackGround,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Positioned(
          top: 60,
          left: 50,
          child: Container(
            width: 250.0,
            height: 160.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage(ImgPath)),
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              color: Colors.redAccent,
            ),
          ),
        ),
        Positioned(
          top: 80,
          left: 245,
          child: SizedBox(
            height: 140,
            child: AspectRatio(
              aspectRatio: 0.5,
              child: Image.asset(
                MobileImgPath,
                fit: BoxFit.cover,
                //height: 100,
              ),
            ),
          ),
        ),
        Positioned(
            left: 300,
            top: 20,
            child: GestureDetector(
              onTap: () {
                _showMyDialog();
              },
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: const Color(0xff1B47C1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Transform.rotate(
                    angle: 135 * math.pi / 180,
                    child: const Icon(
                      Icons.arrow_back_sharp,
                      color: Colors.white,
                      size: 17,
                    )),
              ),
            ))
      ]),
    );
  }

  Widget customRadioButton(String text, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          value = index;
        });
      },
      child: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        height: 45,
        decoration: BoxDecoration(
            color: (value == index)
                ? const Color.fromRGBO(1, 26, 251, 1.0)
                : selectionButton,
            // border: Border.all(
            //   color: (value == index) ? chipColor : Colors.black,
            // ),
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          text,
          style: TextStyle(
              color: (value == index)
                  ? whiteColor
                  : blackButtonColor.withOpacity(.5),
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget customYesNoButton(String text, int index) {

    return InkWell(
      onTap: () {
        //_launchUrl();
        Get.to(()=>WebViewPersona());
        //Navigator.pop(context);
      },
      child: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        height: 45,
        decoration: BoxDecoration(
            color: (value == index)
                ? const Color.fromRGBO(1, 26, 251, 1.0)
                : selectionButton,
            // border: Border.all(
            //   color: (value == index) ? chipColor : Colors.black,
            // ),
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          text,
          style: TextStyle(
              color: (value == index)
                  ? whiteColor
                  : blackButtonColor.withOpacity(.5),
              fontSize: 12,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse(
        'http://ec2-15-207-150-14.ap-south-1.compute.amazonaws.com/Template8');
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url, mode: LaunchMode.inAppWebView,
        webViewConfiguration: const WebViewConfiguration(
            enableJavaScript: true,
            enableDomStorage: true,
            headers: <String, String>{
              'Authorization':
                  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NGM0ZjUxZjkzZGExZjNjNTIxM2Q1MDkiLCJpYXQiOjE2OTE2NDk0NTN9.-3p_gugs-9SnBoaprWnEMkGM9NhsEnZQPpq8dKSPyeQ'
            }),

        // forceWebView = true,
        // enableJavaScript = false
      );
    } else {
      throw Exception('Could not launch $url');
    }
  }



}
