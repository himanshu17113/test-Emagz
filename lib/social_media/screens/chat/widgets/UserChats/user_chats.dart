// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:emagz_vendor/social_media/screens/chat/controllers/chatController.dart';
import 'package:emagz_vendor/social_media/screens/chat/models/chat_model.dart';
import 'package:emagz_vendor/social_media/screens/chat/widgets/user_list_card.dart';

class UserChats extends StatelessWidget {
  Future<List<Conversation>> data;
  UserChats({
    Key? key,
    required this.data,
  }) : super(key: key);

  final ScrollController scrollController = ScrollController();
  final chatController = Get.find<ConversationController>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Conversation>>(
      future: data,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          debugPrint("😡😡😡😡😡😡😡😶‍🌫️😶‍🌫️😶‍🌫️😶‍🌫️🫥🫥🫥 ${snapshot.data?.length} ");
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data?.length ?? 0,
            physics: const ScrollPhysics(),
            controller: scrollController,
            itemBuilder: (context, index) {
              //     debugPrint("USER Id : $userId");
              //   debugPrint("SENDER ID AFTER : ${snapshot.data![index].members?.singleWhere((element) => element != userId)}");
              return UserChat(
                userData: snapshot.data![index].userData,
                resentMessage: snapshot.data![index].resentMessage,
                conversationId: snapshot.data![index].data!.id!,
                senderId: snapshot.data![index].data!.members?.singleWhere((element) => element != chatController.userId) ?? "",
              );
            },
          );
        }
      },
    );
  }
}

class UserChatsWithSearch extends StatelessWidget {
  final String userId;
  final String senderName;
  UserChatsWithSearch({super.key, required this.userId, required this.senderName});

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final chatController = Get.put(ConversationController());

    return FutureBuilder<List<Conversation>>(
      future: chatController.getChatList(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          debugPrint("😡😡😡😡😡😡😡😶‍🌫️😶‍🌫️😶‍🌫️😶‍🌫️🫥🫥🫥 ${snapshot.data?.length} ");
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data?.length ?? 0,
            physics: const ScrollPhysics(),
            controller: scrollController,
            itemBuilder: (context, index) {
              if ((snapshot.data![index].userData!.username!).startsWith(senderName)) {
                return UserChat(
                  userData: snapshot.data![index].userData,
                  resentMessage: snapshot.data![index].resentMessage,
                  conversationId: snapshot.data![index].data!.id!,
                  senderId: snapshot.data![index].data!.members?.singleWhere((element) => element != userId) ?? "",
                );
              } else {
                debugPrint(senderName);
                debugPrint(snapshot.data![index].data!.members?.singleWhere((element) => element != userId) ?? "");
                debugPrint(snapshot.data![index].userData!.username);
              }
              return null;
              //     debugPrint("USER Id : $userId");
              //   debugPrint("SENDER ID AFTER : ${snapshot.data![index].members?.singleWhere((element) => element != userId)}");
            },
          );
        }
      },
    );
  }
}
