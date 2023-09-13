import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/social_media/screens/chat/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../social_media/screens/chat/controllers/socketController.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);
  final socketController = Get.find<SocketController>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(231, 231, 254, 1),
      appBar: AppBar(
        // flexibleSpace: Container(
        //   decoration: BoxDecoration(gradient: myGradient),
        // ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 22,
              color: Colors.black,
            ),
          ),
        ],
        leading: const SizedBox(),
        toolbarHeight: 70,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Notification",
          style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w800),
        ),
        elevation: 0.0,
      ),
      body: Obx(() => ListView.builder(
            itemCount: socketController.notifications.length,
            itemBuilder: (context, index) {
              final NotificationModel notificationModel = socketController.notifications[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: ListTile(
                  tileColor: Colors.white,
                  leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(notificationModel.notificationFrom!.profilePic!),
                    // child: CachedNetworkImage(
                    //   imageUrl: notificationModel.notificationFrom!.profilePic!,
                    //   placeholder: (context, url) => const CircularProgressIndicator(),
                    //   errorWidget: (context, url, error) => const Icon(Icons.error),
                    // ),
                  ),

                  //const SizedBox(),
                  title: Text(notificationModel.title ?? ""),
                  subtitle: Text(notificationModel.message ?? ""),
                ),
              );
            },
            //  separatorBuilder: (context, index) => const Divider(),
          )),
    );
  }
}
