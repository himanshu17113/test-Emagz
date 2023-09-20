import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/social_media/screens/chat/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../social_media/screens/chat/controllers/socketController.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);
  final socketController = Get.find<SocketController>();
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
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
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w800),
        ),
        elevation: 0.0,
      ),
      body: Obx(() => ListView.builder(
            itemCount: socketController.notifications.length,
            itemBuilder: (context, index) {
              final NotificationModel notificationModel =
                  socketController.notifications[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Slidable(
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 3),
                        alignment: Alignment.center,
                        height: 100,
                        width: 180,
                        color: const Color(0xff298B27),
                        child: const Text(
                          'Mute notification about this topic',
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.white,
                          ),
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
                      color: const Color(0xffFE5151),
                      child: const Text(
                        "Remove Notification",
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ]),
                  child: ListTile(
                    tileColor: Colors.white,
                    leading: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                          notificationModel.notificationFrom!.profilePic!),
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
                ),
              );
            },
            //  separatorBuilder: (context, index) => const Divider(),
          )),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(0, -1),
                blurRadius: 5,
                spreadRadius: 1),
          ],
        ),
        child: const Text(
          "Clear Notifiction",
          style: TextStyle(
            fontSize: 10,
            color: Colors.lightBlue,
          ),
        ),
      ),
    );
  }
}
