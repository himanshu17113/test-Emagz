
import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:emagz_vendor/templates/choose_template/template_model.dart';
import 'package:emagz_vendor/templates/choose_template/webview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/get_core/src/get_main.dart';
import 'dart:math' as math;
import '../../constant/colors.dart';
import '../../social_media/controller/auth/jwtcontroller.dart';
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
  final ScrollController _scrollController = ScrollController();
  Future<void> _showMyDialog(int indexx) async {
    return showDialog<void>(
      context: context,
      //barrierDismissible: false, // user must tap button!
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
                  SizedBox(
                      width: 200, child: customYesNoButton("Yes", 1, indexx)),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      width: 200, child: customYesNoButton("No", 2, indexx)),
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
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    Obx(()
                    {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: accountSetUpController.templates!.length,
                        itemBuilder: (ctx,index){
                          String url = accountSetUpController.templates![index]!.thumbnail.toString();
                          String url2 = accountSetUpController.templates![index]!.id.toString();
                          if (url == 'null' || url2 == 'null') {
                          } else {
                            return Persona(
                                accountSetUpController.templates![index]!.id,
                                accountSetUpController.templates![index]!.thumbnail,
                                const Color.fromRGBO(255, 199, 1, 1.0),
                                index + 1);
                          }
                          return null;
                        },
                      );
                    }),


                  ]),
            )));
  }

  Widget Persona(String? id, String? ImgPath,
      Color BackGround, int ind) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, left: 1, right: 1, top: 1),
      child: GestureDetector(
        onTap: () {
          _showMyDialog(ind);
          print(id);
        }, //_launchUrl

        child: Stack(children: [
          Container(
            height: 220,
            width: 450,
            decoration: BoxDecoration(
              color: BackGround,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          ImgPath == null
              ? Container(
                  child: const Text('Loading...'),
                )
              : Positioned(
                  top: 60,
                  left: 50,
                  child: Container(
                    width: 250.0,
                    height: 160.0,
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.all(Radius.circular(8.0)),
                      color: Colors.redAccent,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: ImgPath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          Positioned(
              left: 300,
              top: 20,
              child: GestureDetector(
                onTap: () async {
                  var jwtController = Get.put(JWTController());
                   var token = await jwtController.getAuthToken();
                   var userId = await jwtController.getUserId();

                  Get.to(()=>WebViewOnlyView(token: token!, userId: userId!, personaUserId: userId, templateId: id.toString()));
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
      ),
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

  Widget customYesNoButton(String text, int index, int tmpInd) {
    return InkWell(
      onTap: () {
        if (index == 1) {
          accountSetUpController
              .userTemplate(accountSetUpController.templates![tmpInd].id!);
          //Get.to(() => WebViewPersona(index: tmpInd.toString()));
        } else {
          Navigator.pop(context);
        }
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


}
