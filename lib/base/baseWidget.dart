import 'package:flutter/material.dart';
import '../model/config.dart';
import '../net/requestAPI.dart';
import 'baseLoadingWidget.dart';
import 'dart:async';

//是否在请求网络加载数据 是的话展示loading框
bool isLoading = false;

abstract class BaseStatefulWidget extends StatelessWidget{

  //每个页面初始化的参数 自定义
  Config setConfig();

  State setBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        //通过这种形式来控制是否显示AppBar
        child: Offstage(
          offstage: setConfig().dismissAppBar,
          child: new AppBar(
            backgroundColor: Color(0xff333333),
            iconTheme: IconThemeData(size: 12),
            centerTitle: true,
            leading: GestureDetector(
              child: Container(
                padding: EdgeInsets.only(top: 9, bottom: 9),
                child: Image.asset("assets/images/ic_back_arrow.png", fit: BoxFit.fitHeight,),
              ),
              onTap: (){
                //返回上一个页面
                Navigator.of(context).pop();
              },
            ),
            title: new Text(setConfig().title, style: TextStyle(fontSize: 17),),
          ),
        ),
        preferredSize: Size.fromHeight(45),
      ),
      body: _BaseStatefullWidget(setBody()),
    );
  }
}

class _BaseStatefullWidget extends StatefulWidget{

  State bodyWidget;

  _BaseStatefullWidget(this.bodyWidget);

  @override
  State<StatefulWidget> createState() {
    return bodyWidget;
  }
}

//获取loading的Widget
Widget getLoadingWidget(){
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
            child: new Text("加载中...", style: TextStyle(color: Color(0xff333333)),),
          ),
        ],
      ),
    ),
  );
}

//跳转到下一个页面的函数
void switchNextPage(BuildContext context, Widget widget){
  Navigator.of(context).push(MaterialPageRoute(builder: (context){
    return widget;
  }));
}

typedef RequestData = void Function(dynamic value);

//基类封装的网络请求函数
void requestAPI(String action, RequestData requestData, {Map params}) async {
  //请求网络时将isLoading置为true 展示loading框
  isLoading = true;
  RequestAPI().get(action).then((value){
    //请求结束后将loading框dismiss掉
    isLoading = false;
    requestData(value);
  });
}