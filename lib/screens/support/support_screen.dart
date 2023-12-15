import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/support/create_support.dart';
import 'package:emagz_vendor/screens/support/support_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../social_media/common/common_appbar.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);
  static time(DateTime dateTime) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays == 1) {
      return 'yesterday';
    } else {
      return '${difference.inDays} days ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: socialBack,
      appBar: const SocialMediaSettingAppBar(
        title: 'Support',
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'Recent',
                style: TextStyle(color: textSetting, fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            GetBuilder<SupportController>(
              id: "support",
              init: SupportController(),
              builder: (supportController) => ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: supportController.tickets.length,
                  itemBuilder: (ctx, index) => ListTile(
                        tileColor: Colors.white,
                        isThreeLine: true,
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              supportController.tickets[index].createdAt.toString(),
                              style: const TextStyle(color: textSetting, fontSize: 10, fontWeight: FontWeight.w500),
                            ),
                            const Divider(),
                          ],
                        ),
                        trailing: const Text(
                          'Closed',
                          style: TextStyle(color: textSetting, fontSize: 10, fontWeight: FontWeight.w500),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ticket No#${supportController.tickets[index].ticketNumber ?? "12345"}',
                              style: const TextStyle(color: textSetting, fontSize: 10, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(supportController.tickets[index].ticketTitle!),
                          ],
                        ),
                      )),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'History',
                style: TextStyle(color: textSetting, fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            GetBuilder<SupportController>(
              id: "support",
              init: SupportController(),
              builder: (supportController) => ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: supportController.ticketsClosed.length,
                  itemBuilder: (ctx, index) => ListTile(
                        tileColor: Colors.white,
                        isThreeLine: true,
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              supportController.ticketsClosed[index].createdAt.toString(),
                              style: const TextStyle(color: textSetting, fontSize: 10, fontWeight: FontWeight.w500),
                            ),
                            const Divider(),
                          ],
                        ),
                        trailing: const Text(
                          'Closed',
                          style: TextStyle(color: textSetting, fontSize: 10, fontWeight: FontWeight.w500),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ticket No#${supportController.ticketsClosed[index].ticketNumber ?? "12345"}',
                              style: const TextStyle(color: textSetting, fontSize: 10, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(supportController.ticketsClosed[index].ticketTitle!),
                          ],
                        ),
                      )),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        width: s.width,
        height: 60,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: chipColor),
            onPressed: () {
              Get.to(() => const CreateSupport());
            },
            child: const Text('Raise Ticket')),
      ),
    );
  }
}
