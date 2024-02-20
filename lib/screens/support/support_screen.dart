import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/support/support_controller.dart';
import 'package:emagz_vendor/screens/support/supportchat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
//  void _showOrHide( ) {

//       _bottomSheetController = _scaffoldKey.currentState.showBottomSheet(
//         (_) => Container(
//           // height: MediaQuery.of(context).size.height / 4,
//           // width: MediaQuery.of(context).size.width,
//           child: Text('This is a BottomSheet'),
//         ),
//         backgroundColor: Colors.white,
//       );

//   }

  @override
  Widget build(BuildContext context) {
    String tick = '';
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      // key: _scaffoldKey,
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
              assignId: true,
              init: SupportController(),
              builder: (supportController) {
                final tickets = supportController.tickets.reversed.toList();
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: tickets.length,
                    //      separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (ctx, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 12.5),
                          child: ListTile(
                            minLeadingWidth: 10,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            // leading: const SizedBox(
                            //   width: 0,
                            // ),
                            dense: true,
                            contentPadding: const EdgeInsets.only(top: 5, left: 10, right: 20, bottom: 5),
                            //minVerticalPadding: 2,
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SupportChat(
                                    userId: tickets[index].userId!,
                                    conversationId: tickets[index].id!,
                                  ),
                                )),
                            tileColor: Colors.white,
                            isThreeLine: true,
                            selectedColor: chipColor,
                            subtitle: Text(
                              DateFormat('dd MMMM yyyy').format(tickets[index].createdAt ?? DateTime.now()),
                              style: const TextStyle(color: textSetting, fontSize: 10, fontWeight: FontWeight.w500),
                            ),
                            trailing: const Text(
                              'Open',
                              style: TextStyle(color: textSetting, fontSize: 10, fontWeight: FontWeight.w500),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ticket No#${tickets[index].ticketNumber ?? "12345"}',
                                  style: const TextStyle(color: textSetting, fontSize: 10, fontWeight: FontWeight.w500),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Text(tickets[index].ticketTitle!),
                                ),
                              ],
                            ),
                          ),
                        ));
              },
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
              assignId: true,
              init: SupportController(),
              builder: (supportController) => ListView.separated(
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: supportController.ticketsClosed.length,
                  separatorBuilder: (context, index) => const Padding(
                        padding: EdgeInsets.all(18.0),
                        child: Divider(),
                      ),
                  itemBuilder: (ctx, index) => ListTile(
                        tileColor: Colors.white,
                        isThreeLine: true,
                        subtitle: Text(
                          supportController.ticketsClosed[index].createdAt.toString(),
                          style: const TextStyle(color: textSetting, fontSize: 10, fontWeight: FontWeight.w500),
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
              showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))),
                context: context,
                builder: (contexts) => Container(
                    decoration: const BoxDecoration(
                        color: Color(0xf0E7E9FE),
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(10))),
                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                    height: s.height * .6,
                    width: s.width,
                    child: Column(children: [
                      TextField(
                        onChanged: ((value) => tick = value),
                        showCursor: true,
                        decoration: InputDecoration(
                            fillColor: const Color(0xffFFFFFF),
                            filled: true,
                            hintText: "What is the issue you are facing?",
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
                        padding: const EdgeInsets.only(top: 10),
                        child: GetBuilder<SupportController>(
                            init: SupportController(),
                            initState: (_) {},
                            builder: (supportController) => ElevatedButton(
                                onPressed: () async {
                                  await supportController.createTicket(tick);
                                },
                                child: const Text("Submit"))),
                      )
                    ])),
              );

              //    Get.to(() => const CreateSupport());
            },
            child: const Text('Raise Ticket')),
      ),
    );
  }
}
