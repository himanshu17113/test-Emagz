import 'package:cached_network_image/cached_network_image.dart';
import 'package:emagz_vendor/social_media/screens/chat/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../social_media/screens/chat/controllers/socketController.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(231, 231, 254, 1),
      appBar: AppBar(
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
      body: GetBuilder<SocketController>(
        tag: "notify",
        id: "dot",
      //  assignId: true,
        init: SocketController(),
        initState: (_) {},
        builder: (socketController) => ListView.builder(
          itemCount: socketController.notifications.length,
          itemBuilder: (context, index) {
            final NotificationModel notificationModel =
                socketController.notifications[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Slidable(
                key: UniqueKey(),
                endActionPane: ActionPane(
                    dragDismissible: true,
                    dismissible: DismissiblePane(onDismissed: () {
                      socketController
                          .removeSingleNotification(notificationModel.id!,index);
                    //  socketController.notifications.removeAt(index);
                    }),
                    extentRatio: 1 / 2.2,
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        onPressed: (context) {
                          socketController
                              .removeSingleNotification(notificationModel.id!, index);
                        //  socketController.notifications.removeAt(index);
                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: '     Remove Notification     ',
                      ),
                    ]),
                child: ListTile(
                  tileColor: Colors.white,
                  leading: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                        notificationModel.notificationFrom!.profilePic!),
                  ),
                  title: Text(notificationModel.title ?? ""),
                  subtitle: Text(notificationModel.message ?? ""),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: GetBuilder<SocketController>(
          init: SocketController(),
          tag: "notify",
          id: "dot",
          builder: (socketController) => socketController
                  .notifications.isNotEmpty
              ? InkWell(
                  onTap: () => socketController.clearAllNotification(),
                  child: Container(
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
                )
              : const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No messages...yet!",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Reach out and start a chat. Great Things might happen",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                )),
    );
  }
}
