import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Article extends StatefulWidget {
  final String url;
  final String category;

  Article({this.url, this.category});

  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        widget.category,
        style: TextStyle(color: Theme.of(context).accentColor),
      )),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController controller) {
          _controller.complete(controller);
        },
        onPageFinished: (controller) async {
          (await _controller.future)
              .evaluateJavascript("document.getElementById('navigation-sticky-wrapper').style.display='none';");
          (await _controller.future).evaluateJavascript(
              "document.getElementsByClassName('penci-footer-social-media penci-lazy')[0].style.display='none';");
          (await _controller.future).evaluateJavascript("document.getElementById('widget-area').style.display='none';");
        },
      ),
    );
  }
}
