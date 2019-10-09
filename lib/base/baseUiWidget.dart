import 'package:flutter/material.dart';

class BaseUIWidget{
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

}