import 'package:emagz_vendor/social_media/screens/chat/controllers/chatController.dart';
import 'package:emagz_vendor/social_media/screens/chat/models/chat_model.dart';
import 'package:emagz_vendor/social_media/screens/chat/widgets/user_list_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class UserChats extends StatelessWidget {
  final String userId;
  UserChats({super.key,required this.userId});

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var chatController = Get.put(ConversationController());

    return FutureBuilder<List<Conversation>>(
    future: chatController.getChatList(),
    builder:(context, snapshot) {
      if(!snapshot.hasData){
        return Center(child: CircularProgressIndicator());
      }
      return ListView.builder(
      shrinkWrap: true,
      itemCount: snapshot.data?.length ?? 0,
      physics: ScrollPhysics(),
      controller: scrollController,
      itemBuilder: (context, index) {
        print("USER Id : ${userId}");
        print("SENDER ID AFTER : ${snapshot.data![index].members!.singleWhere((element) => element != userId)}");
        return UserChat(
          conversationId: snapshot.data![index].sId!,
          senderId: snapshot.data![index].members!.singleWhere((element) => element != userId),
        );
      },
    );
    },);
  }
}
