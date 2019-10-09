import 'package:flutter/material.dart';
import 'package:htjf_flutter_app/model/config.dart';
import '../../../base/baseWidget.dart';
import '../../../model/PrivateProductModel.dart';
import '../../../base/baseUiWidget.dart' as BaseUI;

class PrivateProductDetail extends BaseStatefulWidget {
  PrivateProductModel model;

  PrivateProductDetail(this.model);

  @override
  State<StatefulWidget> setBody() {
    return PrivateProductState(model);
  }

  @override
  Config setConfig() {
    return Config(
      title: "产品详情",
    );
  }
}

class PrivateProductState extends State {
  PrivateProductModel model;

  PrivateProductState(this.model);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              BaseUI.BaseUIWidget().getDividerLine(),
              getDetailHeader(),
              getProductInfoArea(),
              BaseUI.BaseUIWidget().getDividerLine(),
              getAchievementArea(),
              BaseUI.BaseUIWidget().getDividerLine(),
              getProductDescArea(),
              BaseUI.BaseUIWidget().getDividerLineMargin(),
              getProductData()
            ],
          )),
        ),
        //下方的按钮部分
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xffcccccc), width: 0.5))
            ),
            height: 40,
            child: Row(
              children: <Widget>[
                Container(
                  width: 75,
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Color(0xffcccccc), width: 0.5))
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Positioned(
                        top: 2,
                        child: Image.asset("assets/images/ic_phone.png", width: 20, height: 20,),
                      ),
                      Positioned(
                        bottom: 2,
                        child: Text("咨询热线", style: TextStyle(color: Color(0xff7d7c7d), fontSize: 10),)
                      )
                    ]
                  )
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    color: Color(0xffF4CF5C),
                    child: Text("预约产品", style: TextStyle(fontSize: 14, color: Colors.white),),
                  ),
                )
              ],
            ),
          )
        )
      ],
    );
  }

  Widget getDetailHeader() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 16, right: 16, top: 11, bottom: 11),
      child: RichText(
          text: TextSpan(children: <TextSpan>[
        TextSpan(
            text: model.productTitle + "  ",
            style: TextStyle(fontSize: 16, color: Color(0xff333333))),
        TextSpan(
            text: model.productCode,
            style: TextStyle(fontSize: 14, color: Color(0xff7d7c7d))),
      ])),
    );
  }

  Widget getProductInfoArea() {
    return Container(
      height: 80,
      margin: EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(model.achievementValueDesc,
                    style: TextStyle(fontSize: 16, color: Color(0xffF4CF5C))),
                Text("业绩比较基准",
                    style: TextStyle(fontSize: 12, color: Color(0xffbbbbbb)))
              ],
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(model.timeLimit,
                    style: TextStyle(fontSize: 16, color: Color(0xff333333))),
                Text("投资期限(月)",
                    style: TextStyle(fontSize: 12, color: Color(0xffbbbbbb)))
              ],
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(model.investAmount,
                    style: TextStyle(fontSize: 16, color: Color(0xff333333))),
                Text("起投金额(万)",
                    style: TextStyle(fontSize: 12, color: Color(0xffbbbbbb)))
              ],
            ),
          ),
        ],
      ),
    );
  }

  //业绩比较基准区域
  Widget getAchievementArea() {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 15, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "业绩比较基准说明",
            style: TextStyle(fontSize: 14, color: Color(0xff333333)),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: model.achievementValue.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(top: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          model.achievementValue[index].desc,
                          style:
                              TextStyle(color: Color(0xff7d7c7d), fontSize: 12),
                        ),
                        Text(
                          model.achievementValue[index].value,
                          textAlign: TextAlign.end,
                          style:
                              TextStyle(color: Color(0xff333333), fontSize: 12),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  //产品简介区域
  Widget getProductDescArea() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text(
              "产品简介",
              style: TextStyle(fontSize: 14, color: Color(0xff333333)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "风险等级",
                  style: TextStyle(color: Color(0xff7d7c7d), fontSize: 12),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    getRiskStar(0, model.riskLevel),
                    getRiskStar(1, model.riskLevel),
                    getRiskStar(2, model.riskLevel),
                    getRiskStar(3, model.riskLevel),
                    getRiskStar(4, model.riskLevel),
                    Text("  " + model.riskLevelDesc, style:TextStyle(color: Color(0xff333333), fontSize: 12))
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "管理机构",
                  style: TextStyle(color: Color(0xff7d7c7d), fontSize: 12),
                ),
                Text(model.manageOrg, style:TextStyle(color: Color(0xff333333), fontSize: 12))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "发行规模",
                  style: TextStyle(color: Color(0xff7d7c7d), fontSize: 12),
                ),
                Text(model.issuingScale, style:TextStyle(color: Color(0xff333333), fontSize: 12))
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "募集时间",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Color(0xff7d7c7d), fontSize: 12),
                ),
                Text(
                  model.raiseTime, style:TextStyle(color: Color(0xff333333), fontSize: 12))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getRiskStar(int currentIndex, int startCount){
    return Image.asset(currentIndex < startCount? "assets/images/ic_star_full.png": "assets/images/ic_star_empty.png", width: 8, height: 8,);
  }

  Widget getProductData(){
    return Container(
      height: 40,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          Positioned(
            left: 16,
            child: Text("产品材料", style: TextStyle(fontSize: 14, color: Color(0xff333333)),),
          ),
          Positioned(
            right: 16,
            child: Image.asset("assets/images/ic_right_arrow.png", width: 7, height: 12,),
          )
        ],
      ),
    );
  }
}
