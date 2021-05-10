import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SampleScreen extends StatefulWidget {
  @override
  _SampleScreenState createState() => _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample Profiles"),
      ),
      body: WebView(
        initialUrl: "https://saloneverywhere.com/sample-profiles",
        gestureNavigationEnabled: true,
      ),
    );
  }
}
