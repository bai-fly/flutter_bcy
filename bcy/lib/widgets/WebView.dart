import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebView extends StatefulWidget {
  String _url;
  AppBar _appBar;
  WebView(url,{
    AppBar appBar
  }){
    _url=url;
    _appBar=appBar;
  }
  @override
  _WebViewState createState() => _WebViewState(_url,_appBar);
}

class _WebViewState extends State<WebView> {
  String _url;
  AppBar _appBar;
  _WebViewState(url,AppBar appBar){
    this._url=url;
    this._appBar=appBar;
  }
  TextEditingController controller = TextEditingController();
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
 

  launchUrl() {
    setState(() {
      _url = controller.text;
      flutterWebviewPlugin.reloadUrl(_url);
    });
  }

  @override
  void initState() {
    super.initState();

    flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged wvs) {
      //print(wvs.type);
    });
    // flutterWebviewPlugin.onUrlChanged.listen((event){
    //   print(event);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: _appBar,
      // appBar: AppBar(
      //   title: TextField(
      //     autofocus: false,
      //     controller: controller,
      //     textInputAction: TextInputAction.go,
      //     onSubmitted: (url) => launchUrl(),
      //     style: TextStyle(color: Colors.white),
      //     decoration: InputDecoration(
      //       border: InputBorder.none,
      //       hintText: "Enter Url Here",
      //       hintStyle: TextStyle(color: Colors.white),
      //     ),
      //   ),
      //   actions: <Widget>[
      //     IconButton(
      //       icon: Icon(Icons.navigate_next),
      //       onPressed: () => launchUrl(),
      //     )
      //   ],
      // ),
      url: _url,
      withZoom: false,
    );
  }
}