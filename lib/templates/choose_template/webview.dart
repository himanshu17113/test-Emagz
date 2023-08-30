import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class WebViewPersona extends StatefulWidget {
  String E_Persona;
  String E_Token;
  String E_CurrId;
  final index;
  WebViewPersona({Key? key, this.index,required this.E_CurrId,required this.E_Persona,required this.E_Token}) : super(key: key);

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
    try {
      await cookieManager.setCookie(
        WebViewCookie(name: 'E_persona_userId',
            value: widget.E_Persona,
            domain: 'persona.emagz.live'),
      );
    }
    catch(e)
    {
      print('error setting cookie');
      print(e);
    }
    await cookieManager.setCookie(
    WebViewCookie(name: 'E_current_userId', value: widget.E_CurrId, domain: 'persona.emagz.live'),
    );
    // try {
    //   await cookieManager.setCookie(
    //
    //     WebViewCookie(name: 'E_token',
    //         value: widget.E_Token,
    //         domain: '.emagz.live'),
    //   );
    // }
    // catch(re)
    // {
    //   print('errotin token');
    //   print(re);
    // }
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
          onPageFinished: (url) async{
            await _onSetCookie(controller);
           // await _onListCookies(controller);
            setState(() {
              loadingPercentage = 100;
            });

          },
        onWebResourceError: (we){
            print('hrr');
            print(we);
        },
        onUrlChange: (url)async{
            //await _onSetCookie(controller);
            print('hr');
            print(url.url);
            //await _onSetCookie(controller);
      }
      ))
      ..loadRequest(
        Uri.parse('http://persona.emagz.live/${widget.index.toString()}'),
      );

    //_onSetCookie(controller);
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
      //   ElevatedButton(
      //       onPressed:() async
      //   {
      //    await _onSetCookie(controller);
      //     await _onListCookies(controller);
      //     },
      //       child:Text('Get cookies'))
      ],
    );
  }
}
