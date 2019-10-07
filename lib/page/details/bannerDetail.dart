import 'package:flutter/material.dart';
import 'package:htjf_flutter_app/model/config.dart';
import '../../base/baseWidget.dart';

class BannerDetail extends BaseStatefulWidget{
  String imgPath;
  BannerDetail(this.imgPath);
  @override
  State<StatefulWidget> setBody() {
    return BannerState(imgPath);
  }

  @override
  Config setConfig() {
    return Config(
      title: "详情",
    );
  }

}

class BannerState extends State{
  String imgPath;
  BannerState(this.imgPath);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: getImg(imgPath)
    );
  }

  Widget getImg(String imgPath){
    if (imgPath.contains("http")){
      return Image.network(imgPath, fit: BoxFit.fill);
    } else {
      return Image.asset(imgPath, fit: BoxFit.fill);
    }
  }
}