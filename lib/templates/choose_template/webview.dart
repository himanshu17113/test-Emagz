import 'dart:io';

import 'package:emagz_vendor/social_media/screens/chat/chat_screen.dart';
import 'package:emagz_vendor/social_media/screens/chat/controllers/chatController.dart';
import 'package:emagz_vendor/templates/choose_template/choose_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

import 'package:image_picker/image_picker.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../constant/data.dart';

class WebViewPersona extends StatefulWidget {
  final String? personaUserId;
  const WebViewPersona({
    super.key,
    this.personaUserId,
  });

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
          debugPrint(request.url.toString());
          if (request.url.startsWith('https://www.emagz.live/Chat/')) {
            int index = int.parse(request.url.replaceAll("https://www.emagz.live/Chat/", ""));
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
        Uri.parse('http://persona.emagz.live/${widget.personaUserId ?? globUserId}/$globUserId/$globToken'),
      );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // status bar color
    ));
    return SafeArea(child: WebViewWidget(controller: controller));
  }
}

class OwnWebView extends StatelessWidget {
  const OwnWebView({
    super.key,

    // required this.templateId
  });
  static final WebViewController controller = WebViewController();
  static final chatController = Get.put(ConversationController());

  void addFileSelectionListener() async {
    if (Platform.isAndroid) {
      final androidController = controller.platform as AndroidWebViewController;
      await androidController.setOnShowFileSelector(_androidFilePicker);
    }
  }

  Future<List<String>> _androidFilePicker(FileSelectorParams params) async {
    final result = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (result != null) {
      final file = File(result.path);
      return [file.uri.toString()];
    } else {
      return [];
    }
  }

  void initState() {
    debugPrint('https://persona.emagz.live/$globUserId/$globUserId/$globToken');
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) => debugPrint(url),
        onProgress: (progress) {},
        onPageFinished: (url) => debugPrint(url),
        onNavigationRequest: (NavigationRequest request) async {
          debugPrint(request.url.toString());
          if (request.url.toString().startsWith('https://www.emagz.live/ChoseTemplate')) {
            Get.off(() => const ChooseTemplate(
                  isReg: false,
                ));
          }
          if (request.url.startsWith('https://www.emagz.live/Chat/')) {
            int index = int.parse(request.url.replaceAll("https://www.emagz.live/Chat/", ""));
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
        Uri.parse('https://persona.emagz.live/$globUserId/$globUserId/$globToken'),
      );
    // addFileSelectionListener();
  }

  @override
  Widget build(BuildContext context) {
    initState();
    //   String tempId = chatController.tempID!;
    //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return GetBuilder<ConversationController>(
        init: ConversationController(),
        id: "rotate",
        builder: (chatController) =>
            RotatedBox(quarterTurns: chatController.isRotate ? 1 : 0, child: WebViewWidget(controller: controller))); //first user you want to see
  }
}

class WebViewOnlyView extends StatefulWidget {
  String token;
  String userId;
  String personaUserId;
  String templateId;
  WebViewOnlyView({super.key, required this.token, required this.userId, required this.personaUserId, required this.templateId});

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
          debugPrint('http://persona.emagz.live/${widget.userId}/${widget.token}');
        },
      ))
      ..loadRequest(
        //Uri.parse('http://persona.emagz.live/64e8f2c3b9b30c1ed4b28bb6/64d33c54b6a7b2fb0be633dc/64d33c54b6a7b2fb0be633dc/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NGQzM2M1NGI2YTdiMmZiMGJlNjMzZGMiLCJpYXQiOjE2OTM0MDA2NTB9.PgFHtbYq9V9gT3mvmSQ6S61tG-BYAEDfHtt5LLODBOY'),

        Uri.parse('http://persona.emagz.live/${widget.templateId}/${widget.token}'),
      );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:
            // Row(
            //   children: [
            //     AspectRatio(
            //       aspectRatio: 9 / 19.5,
            //       child: Expanded(child:
            WebViewWidget(controller: controller)
        //),
        //     ),
        //   ],
        // ),
        );
  }
}
