import 'package:emagz_vendor/social_media/screens/chat/chat_screen.dart';
import 'package:emagz_vendor/social_media/screens/chat/controllers/chatController.dart';
import 'package:emagz_vendor/templates/choose_template/choose_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../constant/data.dart';

class WebViewPersona extends StatefulWidget {
  final String? personaUserId;
  const WebViewPersona({
    Key? key,
    this.personaUserId,
  }) : super(key: key);

  @override
  State<WebViewPersona> createState() => _WebViewPersonaState();
}

class _WebViewPersonaState extends State<WebViewPersona> {
  late final WebViewController controller;
  final chatController = Get.put(ConversationController());
  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {},
        onProgress: (progress) {},
        onPageFinished: (url) {},
        onNavigationRequest: (NavigationRequest request) async {
          if (request.url.startsWith('https://www.emagz.live/Chat/')) {
            int index = int.parse(
                request.url.replaceAll("https://www.emagz.live/Chat/", ""));
            await chatController.getChatList();
            Get.to(() => ChatScreen(
                  user: chatController.chatList[index].userData,
                  conversationId: chatController.chatList[index].data!.id!,
                  //  messages: messages,
                ));
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(
        //Uri.parse('http://persona.emagz.live/64e8f2c3b9b30c1ed4b28bb6/64d33c54b6a7b2fb0be633dc/64d33c54b6a7b2fb0be633dc/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NGQzM2M1NGI2YTdiMmZiMGJlNjMzZGMiLCJpYXQiOjE2OTM0MDA2NTB9.PgFHtbYq9V9gT3mvmSQ6S61tG-BYAEDfHtt5LLODBOY'),
        Uri.parse(
            'http://persona.emagz.live/${widget.personaUserId ?? globUserId}/$globUserId/$globToken'),
      );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller);
  }
}

class OwnWebView extends StatelessWidget {
  // String templateId;
  const OwnWebView({
    Key? key,

    // required this.templateId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //   String tempId = chatController.tempID!;
    //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return GetBuilder<ConversationController>(
        init: ConversationController(),
        id: "rotate",
        initState: (_) {},
        builder: (chatController) => SafeArea(
              child: RotatedBox(
                quarterTurns: chatController.isRotate ? 1 : 0,
                child: InAppWebView(
                    onUpdateVisitedHistory: (_, Uri? uri, __) async {
                      if (uri.toString().endsWith("desktop")) {
                        chatController.rotate();
                      }
                      if (uri.toString() == 'https: //www.emagz.live/Home') {
                        //    chatController.rotate();
                      }

                      debugPrint(uri.toString());
                      if (uri
                          .toString()
                          .startsWith('https://www.emagz.live/Chat')) {
                        int len = uri!.path.length;

                        int index = int.parse(uri.path[len - 1]);
                        debugPrint(index.toString());

                        await chatController.getChatList();
                        Get.off(() => ChatScreen(
                              user: chatController.chatList[index].userData,
                              conversationId:
                                  chatController.chatList[index].data!.id!,
                              //  messages: messages,
                            ));
                      }

                      if (uri
                          .toString()
                          .startsWith('https://www.emagz.live/ChoseTemplate')) {
                        Get.off(() => const ChooseTemplate(
                              isReg: false,
                            ));
                      }
                    },
                    initialUrlRequest: URLRequest(
                        url: Uri.parse(
                            'https://persona.emagz.live/$globUserId/$globUserId/$globToken'))),
              ),
            )); //first user you want to see
  }
}

class WebViewOnlyView extends StatefulWidget {
  String token;
  String userId;
  String personaUserId;
  String templateId;
  WebViewOnlyView(
      {Key? key,
      required this.token,
      required this.userId,
      required this.personaUserId,
      required this.templateId})
      : super(key: key);

  @override
  State<WebViewOnlyView> createState() => _WebViewOnlyViewState();
}

class _WebViewOnlyViewState extends State<WebViewOnlyView> {
  late final WebViewController controller;

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {},
        onProgress: (progress) {},
        onPageFinished: (url) {
          debugPrint(
              'http://persona.emagz.live/${widget.userId}/${widget.token}');
        },
      ))
      ..loadRequest(
        //Uri.parse('http://persona.emagz.live/64e8f2c3b9b30c1ed4b28bb6/64d33c54b6a7b2fb0be633dc/64d33c54b6a7b2fb0be633dc/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NGQzM2M1NGI2YTdiMmZiMGJlNjMzZGMiLCJpYXQiOjE2OTM0MDA2NTB9.PgFHtbYq9V9gT3mvmSQ6S61tG-BYAEDfHtt5LLODBOY'),

        Uri.parse(
            'http://persona.emagz.live/${widget.templateId}/${widget.token}'),
      );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: WebViewWidget(controller: controller),
        ),
      ],
    );
  }
}
