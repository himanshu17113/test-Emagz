import 'package:emagz_vendor/social_media/screens/chat/controllers/chatController.dart';
import 'package:emagz_vendor/social_media/screens/chat/models/chat_model.dart';
import 'package:emagz_vendor/social_media/screens/chat/widgets/user_list_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserChats extends StatelessWidget {
  final String userId;
  UserChats({super.key, required this.userId});

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
          debugPrint(
              "😡😡😡😡😡😡😡😶‍🌫️😶‍🌫️😶‍🌫️😶‍🌫️🫥🫥🫥 ${snapshot.data?.length} ");
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data?.length ?? 0,
            physics: const ScrollPhysics(),
            controller: scrollController,
            itemBuilder: (context, index) {
         //     print("USER Id : $userId");
              //   print("SENDER ID AFTER : ${snapshot.data![index].members?.singleWhere((element) => element != userId)}");
              return UserChat(
                userData: snapshot.data![index].userData,
                resentMessage: snapshot.data![index].resentMessage,
                conversationId: snapshot.data![index].data!.id!,
                senderId: snapshot.data![index].data!.members
                        ?.singleWhere((element) => element != userId) ??
                    "",
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
          debugPrint(
              "😡😡😡😡😡😡😡😶‍🌫️😶‍🌫️😶‍🌫️😶‍🌫️🫥🫥🫥 ${snapshot.data?.length} ");
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data?.length ?? 0,
            physics: const ScrollPhysics(),
            controller: scrollController,
            itemBuilder: (context, index) {
              if(

              (snapshot.data![index].userData!.username!)== senderName)
                {
                  return UserChat(
                    userData: snapshot.data![index].userData,
                    resentMessage: snapshot.data![index].resentMessage,
                    conversationId: snapshot.data![index].data!.id!,
                    senderId: snapshot.data![index].data!.members
                        ?.singleWhere((element) => element != userId) ??
                        "",
                  );
                }
              else
                {
                  print(senderName);
                  print(snapshot.data![index].data!.members
                      ?.singleWhere((element) => element != userId) ??
                      "");
                  print(snapshot.data![index].userData!.username);
                }
              //     print("USER Id : $userId");
              //   print("SENDER ID AFTER : ${snapshot.data![index].members?.singleWhere((element) => element != userId)}");

            },
          );
        }
      },
    );
  }
}