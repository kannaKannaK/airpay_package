import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
 // final String url;
 // WebViewPage({Key key,@required this.url}) : super(key : key);
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final URL = 'https://google.com.tr';
  double progress = 0;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                (progress != 1.0)? LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent)) : null,
            Expanded(
              child: WebView(
                  initialUrl: URL //widget.url,
                 /* onWebViewCreated: (InAppWebViewController controller) {},
                  onLoadStart:  (InAppWebViewController controller, String url) {},
                  onProgressChanged: (InAppWebViewController controller, int progress) {
                    setState(() {
                      this.progress = progress/100;
                    });
                },*/
              ),
                )
              ].where((Object o) => o != null).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

