import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPersona extends StatefulWidget {
  String token;
  String userId;
  String personaUserId;
  String templateId;
  WebViewPersona({Key? key, required this.token, required this.userId, required this.personaUserId,required this.templateId}) : super(key: key);

  @override
  State<WebViewPersona> createState() => _WebViewPersonaState();
}

class _WebViewPersonaState extends State<WebViewPersona> {
  late final WebViewController controller;

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {

        },
        onProgress: (progress) {

        },
        onPageFinished: (url) {
          print('http://persona.emagz.live/${widget.personaUserId}/${widget.userId}/${widget.token}');
          print(widget.personaUserId);
        },
      ))
      ..loadRequest(
        //Uri.parse('http://persona.emagz.live/64e8f2c3b9b30c1ed4b28bb6/64d33c54b6a7b2fb0be633dc/64d33c54b6a7b2fb0be633dc/eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NGQzM2M1NGI2YTdiMmZiMGJlNjMzZGMiLCJpYXQiOjE2OTM0MDA2NTB9.PgFHtbYq9V9gT3mvmSQ6S61tG-BYAEDfHtt5LLODBOY'),

        Uri.parse('http://persona.emagz.live/${widget.personaUserId}/${widget.userId}/${widget.token}'),
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
