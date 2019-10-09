import 'package:flutter/material.dart';

///网络请求的基类，用于请求网络和loading页面

//网络请求的状态 分为成功，失败，加载中，无数据
enum requestStatus{ Success, Error, Loading, Empty}

class BaseNetWidget extends StatefulWidget{

  //当前的状态
  var _currentStatus = requestStatus.Loading;
  final State successState;
  BaseNetWidget(this.successState);


  @override
  State<StatefulWidget> createState() {
    return successState;
  }
}