import '../base/baseWidget.dart';
import 'package:flutter/material.dart';
import '../model/config.dart';

class MinePage extends BaseStatefulWidget{
  @override
  Config setConfig() {
    return Config(
        title: "我的",
        dismissAppBar: true
    );
  }

  @override
  State<StatefulWidget> setBody() {
    return MineState();
  }
  
}

class MineState extends State{
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          getMineHeader(),
          getDividerLine(),
          getOpenArea(),
          getDividerLine(),
          getItem("我的信息", "assets/images/ic_basic_info.png"),
          getDividerLineSine(),
          getItem("我的银行卡", "assets/images/ic_bank_card.png"),
          getDividerLineSine(),
          getItem("我的理财师", "assets/images/ic_licaishi.png"),
          getDividerLineSine(),
          getItem("我的银行卡", "assets/images/ic_bank_card.png"),
          getDividerLineSine(),
          getItem("风险测评", "assets/images/ic_risk_test.png"),
          getDividerLineSine(),
          getItem("监管账户查询", "assets/images/ic_employee_info.png"),
          getDividerLine()
        ],
      ),
    );
  }

  Widget getMineHeader(){
    return Container(
      height: 184,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/images/iv_mine_header.png"), fit: BoxFit.fill)
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 60,
            width: 35,
            child: Image.asset("assets/images/icon_mine_header.png"),
          ),
          Positioned(
            bottom: 52,
            child: Text("186****0970，您好！", style: TextStyle(fontSize: 14, color: Colors.white),),
          ),
          Positioned(
            top: 32,
            right: 16,
            child: GestureDetector(
              child: Row(
                children: <Widget>[
                  Icon(Icons.settings_applications),
                  Text("设置", style: TextStyle(fontSize: 12, color: Colors.white),)
                ],
              ),
              onTap: (){
                //todo 去设置页面
              },
            )
          )
        ],
      ),
    );
  }

  Widget getOpenArea(){
    return Container(
      height: 70,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          Positioned(
            top: 14,
            left: 16,
            child: Text("公募开户", style: TextStyle(fontSize: 14, color: Color(0xff333333))),
          ),
          Positioned(
            bottom: 14,
            left: 16,
            child: Text("涓涓细流，可汇江海", style: TextStyle(fontSize: 12, color: Color(0xff7d7c7d))),
          ),
          Positioned(
            right: 16,
            child: Container(
              padding: EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffF4CF5C)),
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: Text("立即开户", style: TextStyle(fontSize: 14, color: Color(0xffF4CF5C))),
            ),
          )
        ],
      ),
    );
  }

  Widget getItem(String title, String imgPath){
    return Container(
      height: 40,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          Positioned(
            left: 20,
            top: 15,
            child: Image.asset(imgPath, height: 14, width: 14,),
          ),
          Positioned(
            left: 42,
            child: Text(title, style: TextStyle(fontSize: 14, color: Color(0xff333333)),),
          ),
          Positioned(
            right: 12,
            child: Image.asset("assets/images/ic_right_arrow.png", height: 12, width: 7,),
          ),
        ],
      ),
    );
  }

  Widget getDividerLineSine() {
    return Container(
      margin: EdgeInsets.only(left: 16),
      height: 1.0,
      color: Color(0xfff8f8f8),
    );
  }

}