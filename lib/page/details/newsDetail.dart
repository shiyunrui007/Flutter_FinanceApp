///WebView 展示链接
///
///

import "package:flutter/material.dart";
import 'package:htjf_flutter_app/model/config.dart';
import '../../base/baseWidget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetail extends BaseStatefulWidget{

  String _url;
  NewsDetail(this._url);

  @override
  State<StatefulWidget> setBody() {
    return _NewsDetail(_url);
  }

  @override
  Config setConfig() {
    return Config(
      title: "基金详情"
    );
  }
}

class _NewsDetail extends State{

  String _url;
  _NewsDetail(this._url);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: WebView(
        initialUrl: _url,
      ),
    );
  }

}