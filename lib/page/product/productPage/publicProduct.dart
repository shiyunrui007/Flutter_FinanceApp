import 'package:flutter/material.dart';
import 'package:htjf_flutter_app/page/product/productPage/productPage.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../../base/baseWidget.dart';
import '../../details/bannerDetail.dart';

class PublicProduct extends StatefulWidget {
  @override
  _PublicProduct createState() {
    return _PublicProduct();
  }
}

class _PublicProduct extends State<PublicProduct> {
  final List<String> bannerList = new List();
  final List<GoodFundModel> goodFundList = new List();
  final List<FundInfoModel> fundNewInfoList = new List();
  final List<FundInfoModel> fundReportInfoList = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bannerList
      ..add(
          "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1815325960,1420769943&fm=26&gp=0.jpg")
      ..add(
          "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1798815788,2155743867&fm=26&gp=0.jpg")
      ..add(
          "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1891676854,3495265304&fm=26&gp=0.jpg");

    goodFundList
      ..add(new GoodFundModel(
          productName: "天天货币A(100135)",
          valueType: "近一年涨幅",
          value: "3.45%",
          riskList: <String>["1000元起投", "中风险"]))
      ..add(new GoodFundModel(
          productName: "招商安达灵活配置混合(002103)",
          valueType: "近十年涨幅",
          value: "-5.45%",
          riskList: <String>["100000元起投", "高风险"]))
      ..add(new GoodFundModel(
          productName: "金鹰主题优势混合(210005)",
          valueType: "近两年涨幅",
          value: "6.87%",
          riskList: <String>["6000元起投", "中风险"]))
      ..add(new GoodFundModel(
          productName: "景顺长城内需增长贰号混合…",
          valueType: "近三个月涨幅",
          value: "12.09%",
          riskList: <String>["1000元起投", "中低风险"]))
      ..add(new GoodFundModel(
          productName: "金鹰主题优势混合(210005)",
          valueType: "近半年涨幅",
          value: "-45%",
          riskList: <String>["1000元起投", "中高风险"]));

    fundNewInfoList
      ..add(new FundInfoModel(
          title: "国海证券,三种技术风格融为一体,你该如何抉择,标题两行展示标题两行展示标题两行展示标题两行展示标题两…",
          type: "基金观点",
          data: "2019-10-03"))
      ..add(new FundInfoModel(
          title: "国海证券,三种技术风格融为一体。", type: "基金观点", data: "2019-10-03"))
      ..add(new FundInfoModel(
          title: "国海证券,三种技术风格融为一体,你该如何抉择,标题两行展示标题两行展示标题两行展示标题两行展示标题两…",
          type: "基金观点",
          data: "2019-10-03"))
      ..add(new FundInfoModel(
          title: "国海证券,三种技术风格融为一体,你该如何抉择,标题两行展示标题两行展示标题两行展示标题两行展示标题两…",
          type: "基金观点",
          data: "2019-10-03"))
      ..add(new FundInfoModel(
          title: "国海证券,三种技术风格融为一体。", type: "基金观点", data: "2019-10-03"));

    fundReportInfoList
      ..add(
          new FundInfoModel(title: "公募基金市场业绩周回顾（2019年15期）", data: "2019-10-03"))
      ..add(
          new FundInfoModel(title: "公募基金市场业绩周回顾（2019年15期）", data: "2019-10-03"))
      ..add(
          new FundInfoModel(title: "公募基金市场业绩周回顾（2019年15期）", data: "2019-10-03"))
      ..add(
          new FundInfoModel(title: "公募基金市场业绩周回顾（2019年15期）", data: "2019-10-03"))
      ..add(new FundInfoModel(
          title: "公募基金市场业绩周回顾（2019年15期）", data: "2019-10-03"));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          getBanner(),
          getFunctionArea(),
          getDividerLineMargin(),
          getTitle("优选基金"),
          getGoodFund(),
          getDividerLineMargin(),
          getTitle("基金时讯"),
          getFundInfo(fundNewInfoList),
          getDividerLineMargin(),
          getTitle("基金研报"),
          getFundInfo(fundReportInfoList),
        ],
      ),
    );
  }

  Widget getBanner() {
    return Container(
      margin: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      height: 80.0,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        child: Swiper(
          itemCount: bannerList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: Image.network(bannerList[index], fit: BoxFit.fill),
              onTap: (){
                switchNextPage(context, BannerDetail(bannerList[index]));
              },
            );
          },
          autoplay: true,
          autoplayDelay: 2000,
          autoplayDisableOnInteraction: true,
          duration: 500,
          controller: SwiperController(),
          plugins: <SwiperPlugin>[],
        ),
      ),
    );
  }

  Widget getFunctionArea() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 16, right: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Image.asset("assets/images/icon_public_rank.png",
                    width: 30, height: 30),
                Container(
                    margin: EdgeInsets.only(top: 2),
                    child: Text("基金排行",
                        style:
                            TextStyle(fontSize: 12, color: Color(0xff222222))))
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Image.asset("assets/images/icon_public_grad.png",
                    width: 30, height: 30),
                Container(
                    margin: EdgeInsets.only(top: 2),
                    child: Text("基金评级",
                        style:
                            TextStyle(fontSize: 12, color: Color(0xff222222))))
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Image.asset("assets/images/icon_new_public.png",
                    width: 30, height: 30),
                Container(
                    margin: EdgeInsets.only(top: 2),
                    child: Text("新发基金",
                        style:
                            TextStyle(fontSize: 12, color: Color(0xff222222))))
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Image.asset("assets/images/icon_selected_public.png",
                    width: 30, height: 30),
                Container(
                    margin: EdgeInsets.only(top: 2),
                    child: Text("自选基金",
                        style:
                            TextStyle(fontSize: 12, color: Color(0xff222222))))
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Image.asset("assets/images/icon_public_education.png",
                    width: 30, height: 30),
                Container(
                    margin: EdgeInsets.only(top: 2),
                    child: Text("财商教育",
                        style:
                            TextStyle(fontSize: 12, color: Color(0xff222222))))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getGoodFund() {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: goodFundList.length,
          itemBuilder: (BuildContext context, int index) {
            return getGoodFundItem(goodFundList[index], index);
          }),
    );
  }

  Widget getGoodFundItem(GoodFundModel model, int index) {
    return Container(
      height: 76,
      margin: EdgeInsets.only(left: 16, right: 16),
      decoration: BoxDecoration(
          border: index == goodFundList.length - 1
              ? null
              : Border(bottom: BorderSide(color: Color(0xffeeeeee)))),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 16,
            child: Text(model.value,
                style: TextStyle(
                    color: model.value.substring(0, 1) == "-"
                        ? Colors.green
                        : Colors.red,
                    fontSize: 21,
                    fontWeight: FontWeight.bold)),
          ),
          Positioned(
            left: 109,
            top: 18,
            child: Text(model.productName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Color(0xff222222), fontSize: 15)),
          ),
          Positioned(
            bottom: 16,
            child: Text(model.valueType,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Color(0xff999999), fontSize: 12)),
          ),
          Positioned(
            height: 20,
            bottom: 14,
            left: 109,
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: model.riskList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.only(right: 4),
                    child: Text(model.riskList[index],
                        style:
                            TextStyle(color: Color(0xff999999), fontSize: 12)),
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget getFundInfo(List<FundInfoModel> list) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return getFundInfoItem(list, index);
          }),
    );
  }

  Widget getFundInfoItem(List<FundInfoModel> list, int index) {
    FundInfoModel model = list[index];
    String desc;
    if (model.type != null && model.type.isNotEmpty) {
      desc = model.type + "    " + model.data;
    } else {
      desc = model.data;
    }
    return Container(
      decoration: BoxDecoration(
          border: index == list.length - 1
              ? null
              : Border(bottom: BorderSide(color: Color(0xffeeeeee)))),
      child: Container(
        padding: EdgeInsets.only(top: 16, bottom: 12),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                model.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, color: Color(0xff222222)),
              ),
            )
            ,
            Container(
              margin: EdgeInsets.only(top: 12),
              alignment: Alignment.centerLeft,
              child: Text(
                desc,
                style: TextStyle(fontSize: 12, color: Color(0xff999999)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GoodFundModel {
  GoodFundModel(
      {Key key, this.productName, this.valueType, this.value, this.riskList});

  String productName;
  String value;
  String valueType;
  List<String> riskList;
}

class FundInfoModel {
  FundInfoModel({Key key, this.title, this.type, this.data});

  String title;
  String type;
  String data;
}
