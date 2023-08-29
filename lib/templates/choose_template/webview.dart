import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class WebViewPersona extends StatefulWidget {
  final String index;
  const WebViewPersona({Key? key, required this.index}) : super(key: key);

  @override
  State<WebViewPersona> createState() => _WebViewPersonaState();
}

class _WebViewPersonaState extends State<WebViewPersona> {
  late final WebViewController controller;
  var loadingPercentage = 0;
  final cookieManager = WebViewCookieManager();
  Future<void> _onAddCookie(WebViewController controller) async {
    await controller.runJavaScript('''var date = new Date();
  date.setTime(date.getTime()+(30*24*60*60*1000));
  document.cookie = "FirstName=John; expires=" + date.toGMTString();''');
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Custom cookie added.'),
      ),
    );
  }
  Future<void> _onSetCookie(WebViewController controller) async {
    print("here");
    await cookieManager.setCookie(
      const WebViewCookie(name: 'E_persona_userId', value: 'bar', domain: 'ec2-15-207-150-14.ap-south-1.compute.amazonaws.com'),
    );
    await cookieManager.setCookie(
      const WebViewCookie(name: 'E_current_userId', value: 'bar', domain: 'ec2-15-207-150-14.ap-south-1.compute.amazonaws.com'),
    );
    await cookieManager.setCookie(
      const WebViewCookie(name: 'E_token', value: 'token', domain: 'ec2-15-207-150-14.ap-south-1.compute.amazonaws.com'),
    );
    if (!mounted) {
      print('cookis');
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Custom cookie is set.'),
      ),
    );
  }
  Future<void> _onListCookies(WebViewController controller) async {
    final String cookies = await controller
        .runJavaScriptReturningResult('document.cookie') as String;
    print(cookies);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(cookies.isNotEmpty ? cookies : 'There are no cookies.'),
      ),
    );
  }

  @override
  void initState() {

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              loadingPercentage = 0;
            });
          },
          onProgress: (progress) {
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageFinished: (url) {
            setState(() {
              loadingPercentage = 100;
            });
          },
      ))
      ..loadRequest(
        Uri.parse('http://ec2-15-207-150-14.ap-south-1.compute.amazonaws.com/Template${widget.index}'),
      );

    _onAddCookie(controller);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex:1,
          child: WebViewWidget(
              controller: controller
          ),
        ),
      // if(loadingPercentage < 100)
      //     LinearProgressIndicator(
      //        value: loadingPercentage / 100.0,
      //  ),
        // ElevatedButton(
        //     onPressed:() async
        // {
        //  await _onSetCookie(controller);
        //   await _onListCookies(controller);
        //   },
        //     child:Text('Get cookies'))
      ],
    );
  }
}
