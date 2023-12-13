import 'package:emagz_vendor/social_media/screens/chat/chat_screen.dart';
import 'package:emagz_vendor/social_media/screens/chat/controllers/chatController.dart';
import 'package:emagz_vendor/templates/choose_template/choose_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../social_media/screens/chat/models/chat_model.dart';

class WebViewPersona extends StatefulWidget {
  String token;
  String userId;
  String personaUserId;
  WebViewPersona({
    Key? key,
    required this.token,
    required this.userId,
    required this.personaUserId,
  }) : super(key: key);

  @override
  State<WebViewPersona> createState() => _WebViewPersonaState();
}

class _WebViewPersonaState extends State<WebViewPersona> {
  late final WebViewController controller;
  final chatController = Get.find<ConversationController>();
  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {},
        onProgress: (progress) {},
        onPageFinished: (url) {},
        onNavigationRequest: (NavigationRequest request) async {
          if (request.url.startsWith('http://www.emagz.live/Chat/')) {
            int index = int.parse(
                request.url.replaceAll("http://www.emagz.live/Chat/", ""));
            final List<Conversation> list = await chatController.getChatList();
            Get.to(() => ChatScreen(
                  user: list[index].userData,
                  conversationId: list[index].data!.id!,
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
            'http://persona.emagz.live/${widget.personaUserId}/${widget.userId}/${widget.token}'),
      );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: controller);
  }
}

class OwnWebView extends StatefulWidget {
  String token;
  String userId;
  String personaUserId;
  String templateId;
  OwnWebView(
      {Key? key,
      required this.token,
      required this.userId,
      required this.personaUserId,
      required this.templateId})
      : super(key: key);

  @override
  State<OwnWebView> createState() => _OwnWebViewState();
}

class _OwnWebViewState extends State<OwnWebView> {
  final chatController = Get.find<ConversationController>();
  @override
  Widget build(BuildContext context) {
    //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Container(
      height: 200,
      width: 90,
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: InAppWebView(
          onUpdateVisitedHistory: (_, Uri? uri, __) async {
            // uri containts newly loaded url
            debugPrint(uri.toString());
            if (uri.toString().startsWith('http://www.emagz.live/Chat')) {
              int len = uri!.path.length;

              int index = int.parse(uri.path[len - 1]);
              debugPrint(index.toString());
              final List<Conversation> list =
                  await chatController.getChatList();
              Get.off(() => ChatScreen(
                    user: list[index].userData,
                    conversationId: list[index].data!.id!,
                    //  messages: messages,
                  ));
            }

            if (uri
                .toString()
                .startsWith('http://www.emagz.live/ChoseTemplate')) {
              Get.off(() => const ChooseTemplate(
                    isReg: false,
                  ));
            }
          },
          initialUrlRequest: URLRequest(
              url: Uri.parse(
                  'http://persona.emagz.live/${widget.personaUserId}/${widget.userId}/${widget.token}'))),
    );
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
