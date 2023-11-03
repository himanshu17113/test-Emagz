import 'package:emagz_vendor/common/common_snackbar.dart';
import 'package:emagz_vendor/screens/support/support_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../social_media/common/common_appbar.dart';
class CreateSupport extends StatefulWidget {
  const CreateSupport({Key? key}) : super(key: key);

  @override
  State<CreateSupport> createState() => _CreateSupportState();
}

class _CreateSupportState extends State<CreateSupport> {
  TextEditingController emailControl = TextEditingController();
  TextEditingController reasonControl = TextEditingController();
  TextEditingController msgControl = TextEditingController();
  var supportController= Get.put(SupportController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: socialBack,
      appBar: const SocialMediaSettingAppBar(title: 'Support',),
      body: Container(
        child: Column(
          children: [
            const SizedBox(height: 30,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 62,
              decoration: BoxDecoration(
                  color: const Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(100)),
              child: TextField(
                controller: emailControl,
                onSubmitted: (value) {
                  setState(() {

                  });
                },
                showCursor: false,
                decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(
                        fontSize: 13, color: textSetting),
                    contentPadding:
                    const EdgeInsets.only(left: 35, top: 5),
                    border: InputBorder.none),
              ),
            ),
            const SizedBox(height: 30,),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 62,
              decoration: BoxDecoration(
                  color: const Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(100)),
              child: TextField(
                controller: reasonControl,
                onSubmitted: (value) {
                  setState(() {

                  });
                },
                showCursor: false,
                decoration: InputDecoration(
                    hintText: "Select Reason",
                    hintStyle: TextStyle(
                        fontSize: 13, color: textSetting),
                    contentPadding:
                    const EdgeInsets.only(left: 35, top: 5),
                    border: InputBorder.none),
              ),
            ),
            const SizedBox(height: 30,),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 250,
              decoration: BoxDecoration(
                  color: const Color(0xffFFFFFF),
                  borderRadius: BorderRadius.circular(20)),
              child: TextField(
                controller: msgControl,
                onSubmitted: (value) {
                  setState(() {

                  });
                },
                showCursor: false,
                decoration: InputDecoration(
                    hintText: "Message",
                    hintStyle: TextStyle(
                        fontSize: 13, color: textSetting),
                    contentPadding:
                    const EdgeInsets.only(left: 35, top: 5),
                    border: InputBorder.none),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: chipColor),
                    onPressed: () async
                    {
                      if(emailControl.text==' ' || msgControl.text==' ' || reasonControl.text==' ')
                        {
                          CustomSnackbar.show('Please enter all the fields');
                        }
                      else{
                        supportController.postSupport(emailControl.text, msgControl.text, reasonControl.text);

                        setState(() {
                          emailControl.clear();
                          msgControl.clear();
                          reasonControl.clear();
                        });
                      }

                    },
                    child: const Text('Submit')
                ),
                const SizedBox(width: 30,)
              ],
            )
          ],
        ),
      ),
    );
  }
}
