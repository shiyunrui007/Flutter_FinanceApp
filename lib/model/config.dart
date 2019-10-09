import 'package:flutter/material.dart';
import '../base/baseWidget.dart';

typedef InitView = void Function();
typedef UpdateCallBack = void Function();

class Config {
  //传递的设置参数
  @required String title = "";
  bool dismissAppBar;

  Config({Key key, this.title, this.dismissAppBar = false});
}
