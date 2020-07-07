import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String webUrl;

  ArticleView({this.webUrl});

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {

  final Completer<WebViewController> _completer = Completer<WebViewController>();


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("Flutter"),
            new Text(
              "News",
              style: new TextStyle(
                  color: Colors.blue
              ),
            ),
          ],
        ),

        actions: <Widget>[
          new Opacity(
              opacity: 0,
            child: new Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.save),
            ),
          )
        ],
      ),

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: new WebView(
          initialUrl: widget.webUrl,
          onWebViewCreated: ((WebViewController webViewController){
            _completer.complete(webViewController);
          }),
        ),
      ),
    );
  }
}
