import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:emagz_vendor/user/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class SocialNotificationScreen extends StatelessWidget {
  const SocialNotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: socialBack,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Notification",
                    style: TextStyle(
                        color: blackButtonColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back_ios_sharp,
                      color: blackButtonColor,
                      size: 18,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            return Slidable(
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 3),
                    alignment: Alignment.center,
                    height: 100,
                    width: 180,
                    decoration: const BoxDecoration(
                      color: Color(0xff298B27),
                    ),
                    child: FormHeadingText(
                      headings: 'Mute notification about this topic',
                      fontSize: 9,
                      color: whiteColor,
                    ),
                  )
                ],
              ),
              endActionPane:
                  ActionPane(motion: const ScrollMotion(), children: [
                Container(
                  margin: const EdgeInsets.only(top: 3),
                  alignment: Alignment.center,
                  height: 90,
                  width: 180,
                  decoration: const BoxDecoration(
                    color: Color(0xffFE5151),
                  ),
                  child: FormHeadingText(
                    headings: "Remove Notification",
                    fontSize: 9,
                    color: whiteColor,
                  ),
                )
              ]),
              child: Container(
                margin: const EdgeInsets.only(top: 3),
                decoration: const BoxDecoration(
                    // borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        products[index].image.toString(),
                        // "https://images.unsplash.com/photo-1613040809024-b4ef7ba99bc3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8aGVhZHBob25lfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Get.size.width / 2,
                          child: const Text(
                            "Congrats",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          width: Get.size.width / 2,
                          child: const Text(
                            "Your post has been sucessfully posted",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Text(
                      "2 min",
                      style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: Container(
          alignment: Alignment.center,
          height: 50,
          decoration: BoxDecoration(
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                  color: grayColor,
                  offset: const Offset(0, -10),
                  blurRadius: 10,
                  spreadRadius: 2),
            ],
          ),
          child: FormHeadingText(
            headings: "Clear Notifiction",
            fontSize: 10,
            color: blueColor,
          ),
        ),
      ),
    );
  }
}
