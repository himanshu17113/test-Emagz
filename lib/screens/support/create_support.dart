import 'package:emagz_vendor/common/common_snackbar.dart';
import 'package:emagz_vendor/screens/support/support_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../social_media/common/common_appbar.dart';

class CreateSupport extends StatelessWidget {
  const CreateSupport({super.key});

  @override
  Widget build(BuildContext context) {
    String email = "";
    String reason = "";
    String message = "";

    final supportController = Get.put(SupportController());
    return Scaffold(
      backgroundColor: socialBack,
      appBar: const SocialMediaSettingAppBar(
        title: 'Support',
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: Column(
          children: [
            TextField(
              onChanged: ((value) => email = value),
              showCursor: true,
              decoration: InputDecoration(
                  fillColor: const Color(0xffFFFFFF),
                  filled: true,
                  hintText: "Email",
                  hintStyle: const TextStyle(fontSize: 13, color: textSetting),
                  contentPadding: const EdgeInsets.only(left: 35, top: 15, bottom: 15),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                      borderRadius: BorderRadius.circular(33))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: TextField(
                //   cursorColor: Colors.grey,
                onChanged: ((value) => reason = value),
                showCursor: true,
                decoration: InputDecoration(
                    fillColor: const Color(0xffFFFFFF),
                    filled: true,
                    hintText: "Reason",
                    hintStyle: const TextStyle(fontSize: 13, color: textSetting),
                    contentPadding: const EdgeInsets.only(left: 35, top: 15, bottom: 15),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                        borderRadius: BorderRadius.circular(33))),
              ),
            ),
            TextField(
              //   cursorColor: Colors.grey,
              onChanged: ((value) => message = value),
              showCursor: true,
              maxLines: 6,
              decoration: InputDecoration(
                  fillColor: const Color(0xffFFFFFF),
                  filled: true,
                  hintText: "Message",
                  hintStyle: const TextStyle(fontSize: 13, color: textSetting),
                  contentPadding: const EdgeInsets.only(left: 35, top: 15, bottom: 15, right: 15),
                  border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                      borderRadius: BorderRadius.circular(33))),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: chipColor),
                  onPressed: () async {
                    if (email.isEmpty || reason.isEmpty || message.isEmpty || !email.isEmail) {
                      CustomSnackbar.show('Please enter all the fields');
                    } else {
                      supportController.postSupport(email, message, reason);

                      email = "";
                      message = "";
                      reason = "";
                      
                    }
                  },
                  child: const Text('  Submit  ')),
            ),
          ],
        ),
      ),
    );
  }
}
