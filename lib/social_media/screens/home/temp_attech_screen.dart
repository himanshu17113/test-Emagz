import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/templates/screens/template_five.dart';
import 'package:emagz_vendor/templates/screens/template_one.dart';
import 'package:emagz_vendor/templates/screens/template_seven.dart';
import 'package:emagz_vendor/templates/screens/template_six.dart';
import 'package:emagz_vendor/templates/screens/template_two.dart';
import 'package:emagz_vendor/templates/screens/templete_three.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../templates/screens/template_eight.dart';
import '../../../templates/screens/template_four.dart';
import '../../../templates/screens/template_nine.dart';
import '../../../templates/screens/template_ten.dart';

class TempAttachScreen extends StatelessWidget {
  const TempAttachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          CustomButton(
            title: "Temp 1 ",
            function: () {
              Get.to(() => const TemplateOne());
            },
          ),
          CustomButton(
            title: "Temp 2 ",
            function: () {
              Get.to(() => const TemplateTwoScreen());
            },
          ),
          CustomButton(
            title: "Temp 3 ",
            function: () {
              Get.to(() => const TemplateThree());
            },
          ),
          CustomButton(
            title: "Temp 4 ",
            function: () {
              Get.to(() => const TemplateFourScreen());
            },
          ),
          CustomButton(
            title: "Temp 5 ",
            function: () {
              Get.to(() => const TemplateFiveScreen());
            },
          ),
          CustomButton(
            title: "Temp 5 ",
            function: () {
              Get.to(() => const TemplateSixScreen());
            },
          ),
          CustomButton(
            title: "Temp 7 ",
            function: () {
              Get.to(() => const TemplateSevenScreen());
            },
          ),
          CustomButton(
            title: "Temp 8 ",
            function: () {
              Get.to(() => const TemplateEightScreen());
            },
          ),
          CustomButton(
            title: "Temp 9 ",
            function: () {
              Get.to(() => const TemplateNineScreen());
            },
          ),
          CustomButton(
            title: "Temp 10 ",
            function: () {
              Get.to(() => const TemplateTenScreen());
            },
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final Function function;
  final String title;
  const CustomButton({super.key, required this.function, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        function();
      },
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 10),
        height: 50,
        color: black,
        child: Text(
          title,
          style: const TextStyle(color: whiteColor),
        ),
      ),
    );
  }
}
