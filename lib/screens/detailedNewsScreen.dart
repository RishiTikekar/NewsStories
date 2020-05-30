import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

// void main() => runApp(MaterialApp(home: WikipediaExplorer()));

class DetailedNewsScreen extends StatefulWidget {
  String url;
  DetailedNewsScreen(this.url);
  @override
  _DetailedNewsScreenState createState() => _DetailedNewsScreenState();
}

class _DetailedNewsScreenState extends State<DetailedNewsScreen> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  final Set<String> _favorites = Set<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Datails'),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
      ),
      body: WebView(
        initialUrl: widget.url,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}
