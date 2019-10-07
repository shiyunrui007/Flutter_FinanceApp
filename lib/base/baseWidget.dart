import 'package:flutter/material.dart';
import '../model/config.dart';

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
  final State state;
  _BaseStatefullWidget(this.state);

  @override
  State<StatefulWidget> createState() {
    return state;
  }
}

//跳转到下一个页面的函数
void switchNextPage(BuildContext context, Widget widget){
  Navigator.of(context).push(MaterialPageRoute(builder: (context){
    return widget;
  }));
}

//分割线 居上边8dp
Widget getDividerLineMargin() {
  return Container(
    height: 8.0,
    margin: EdgeInsets.only(top: 16.0),
    color: Color(0xfff4f4f4),
  );
}

//分割线 没有margin
Widget getDividerLine() {
  return Container(
    height: 8.0,
    color: Color(0xfff4f4f4),
  );
}



//UI相关
Text getBaseText(String title){
  return Text(
    title,
    style: getBaseTextStyle(),
  );
}

TextStyle getBaseTextStyle(){
  return TextStyle(
    fontSize: 16.0,
    color: Colors.black,
  );
}

//产品分类的title
Widget getTitle(String title) {
  return Container(
    margin: EdgeInsets.only(top: 16.0),
    child: Row(
      children: <Widget>[
        Container(
          height: 20.0,
          width: 4.0,
          color: Color(0xffDFB379),
        ),
        Container(
          margin: EdgeInsets.only(left: 12.0),
          child: Text(title,
              style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold)),
        )
      ],
    ),
  );
}