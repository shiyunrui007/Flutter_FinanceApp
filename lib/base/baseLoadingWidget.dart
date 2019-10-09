/*
 * 自定义等待加载提示框
 * Created by ZhangJun on 2018-11-29
 */

import 'package:flutter/material.dart';

class LoadingDialog extends Dialog {
  final String text;

  LoadingDialog({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Material(
      type: MaterialType.transparency,
      child: new Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new CircularProgressIndicator(),
            new Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
              ),
              child: new Text(text, style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}