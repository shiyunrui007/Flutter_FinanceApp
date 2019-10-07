import 'package:flutter/material.dart';

///私募产品model
///
class PrivateProductModel{

  PrivateProductModel({
    Key key,
    @required this.productTitle,
    @required this.productCode,
    this.achievementValue = const <AchievementValueModel>[],
    this.achievementValueDesc = "7.2％～7.5%",
    this.timeLimit = "12",
    this.investAmount = "100",
    this.riskLevel = 2,
    this.riskLevelDesc = "平衡型",
    this.manageOrg = "东北证券公司",
    this.issuingScale = "10,000",
    this.raiseTime = "2016-01-01~2017-12-03"
  });

  String productTitle;//产品名称
  String productCode;//产品Code
  String achievementValueDesc;//业绩比较基准描述
  List<AchievementValueModel> achievementValue;//业绩比较基准列表
  String timeLimit;//投资期限
  String investAmount;//起投金额

  int riskLevel = 2;//产品风险等级 代表几颗星
  String riskLevelDesc;//产品风险等级
  String manageOrg;//管理机构
  String issuingScale;//发行规模
  String raiseTime;//募集时间
}

class AchievementValueModel{
  AchievementValueModel(this.desc, this.value);
  String desc;
  String value;
}