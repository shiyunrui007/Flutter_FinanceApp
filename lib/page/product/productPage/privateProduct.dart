import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:htjf_flutter_app/page/product/productPage/productPage.dart';
import '../../../base/baseWidget.dart';
import '../../details/bannerDetail.dart';
import '../../../model/PrivateProductModel.dart';
import '../../product/productDetail/privateProductDetail.dart';

class PrivateProduct extends StatefulWidget {
  @override
  _PrivateProduct createState() {
    return _PrivateProduct();
  }
}

class _PrivateProduct extends State<PrivateProduct> {
  final List<String> bannerList = new List();
  final List<RecommendModel> recommendList = new List();
  final List<HotProductModel> hotProductList = new List();
  BuildContext buildContext;

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

    recommendList
      ..add(new RecommendModel(
          "人气产品", "1.1197", "单位净值", "04-19", "(春华68号)琅琊3号母基金"))
      ..add(new RecommendModel(
          "把握新经济", "4.3445", "最新净值", "11-14", "(春华68号)琅琊3号母基金 (春华68号)琅琊3号母基金"))
      ..add(new RecommendModel(
          "CTA策划", "5.13537", "万份收益", "06-09", "(春华68号)琅琊3号母基金"))
      ..add(new RecommendModel(
          "琅琊母基金", "9.4667", "累计净值", "08-25", "(春华68号)琅琊3号母基金"));

    hotProductList
      ..add(HotProductModel(
          productName: "（DZ银杏40号）恒天财富稳1号第一次开放",
          productType: "灵活配置",
          value: "1.1130",
          valueType: "单位净值",
          data: "04-19",
          type: <String>["期限短", "流动性强", "定期开放"]))
      ..add(HotProductModel(
          productName: "（DZ银杏40号）恒天财富稳1号第一次开放",
          productType: "股权投资",
          value: "1.1130",
          valueType: "单位净值",
          data: "04-19",
          type: <String>["期限短", "流动性强", "定期开放"]))
      ..add(HotProductModel(
          productName: "（DZ银杏40号）恒天财富稳1号第一次开放",
          productType: "百亿私募",
          value: "1.1130",
          valueType: "单位净值",
          data: "04-19",
          type: <String>["期限短", "流动性强", "定期开放"]))
      ..add(HotProductModel(
          productName: "（DZ银杏40号）恒天财富稳1号第一次开放",
          productType: "灵活配置",
          value: "1.1130",
          valueType: "单位净值",
          data: "04-19",
          type: <String>["期限短", "流动性强", "定期开放"]));
  }

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          getBanner(),
          getFunctionArea(),
          getDividerLineMargin(),
          getTitle("精品推荐"),
          getRecommendArea(),
          getDividerLineMargin(),
          getTitle("猜你喜欢"),
          getLikeArea(),
          getDividerLineMargin(),
          getTitle("热门私募"),
          getHotProductArea()
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
              onTap: () {
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
      height: 70.0,
      margin: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(child: Image.asset("assets/images/iv_private_market.png")),
          Container(
            width: 12.0,
          ),
          Expanded(child: Image.asset("assets/images/iv_video.png"))
        ],
      ),
    );
  }

  //精品推荐
  Widget getRecommendArea() {
    return Container(
        margin: EdgeInsets.only(top: 16.0),
        height: 151.0,
        child: ListView.builder(
          itemCount: recommendList.length,
          itemBuilder: (BuildContext context, int index) {
            return getRecommendItem(recommendList[index]);
          },
          scrollDirection: Axis.horizontal,
        ));
  }

  Widget getRecommendItem(RecommendModel model) {
    return GestureDetector(
      onTap: () {
        switchNextPage(
            buildContext,
            PrivateProductDetail(PrivateProductModel(
                productTitle: model.desc,
                productCode: "003274",
                achievementValue: <AchievementValueModel>[
                  AchievementValueModel("100万(含)-300万", "7.2%"),
                  AchievementValueModel("300万(含)-500万", "8.2%"),
                  AchievementValueModel("500万(含)以上", "9.5%"),
                ])));
      },
      child: Container(
        width: 136.0,
        margin: EdgeInsets.only(left: 16.0),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: Container(
              color: Color(0xfff8f8f8),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 12),
                    child: Text(model.productName,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff333333),
                            fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Text(
                      model.value,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff333333),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    child: Text(
                      model.valueType + "(" + model.data + ")",
                      style: TextStyle(fontSize: 10, color: Color(0xff7d7c7d)),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 12, top: 13, right: 12),
                    child: Text(
                      model.desc,
                      style: TextStyle(fontSize: 12, color: Color(0xff7d7c7d)),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.left,
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  Widget getLikeArea() {
    return GestureDetector(
      onTap: () {
        switchNextPage(
            buildContext,
            PrivateProductDetail(PrivateProductModel(
                productTitle: "新手推荐产品",
                productCode: "003274",
                achievementValue: <AchievementValueModel>[
                  AchievementValueModel("100万(含)-300万", "7.2%"),
                  AchievementValueModel("300万(含)-500万", "8.2%"),
                  AchievementValueModel("500万(含)以上", "9.5%"),
                ])));
      },
      child: Container(
          height: 80,
          margin: EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Stack(
            children: <Widget>[
              Image.asset("assets/images/iv_guest_like.png", fit: BoxFit.fill),
              Positioned(
                left: 18,
                top: 13,
                child: Text("尊敬的王先生",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
              Positioned(
                left: 18,
                bottom: 13,
                child: Container(
                  padding: EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
                  color: Color(0xffDFB379),
                  child: Text("适合您的产品在这里",
                      style: TextStyle(fontSize: 13, color: Colors.white)),
                ),
              )
            ],
          )),
    );
  }

  Widget getHotProductArea() {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: hotProductList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return getHotProductItem(hotProductList[index]);
        });
  }

  Widget getHotProductItem(HotProductModel model) {
    return GestureDetector(
      onTap: () {
        switchNextPage(
            buildContext,
            PrivateProductDetail(PrivateProductModel(
                productTitle: model.productName,
                productCode: "003274",
                achievementValue: <AchievementValueModel>[
                  AchievementValueModel("100万(含)-300万", "7.2%"),
                  AchievementValueModel("300万(含)-500万", "8.2%"),
                  AchievementValueModel("500万(含)以上", "9.5%"),
                ])));
      },
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
        height: 103,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Container(
            color: Color(0xfff8f8f8),
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: Image.asset("assets/images/icon_tip_red.png"),
                ),
                Positioned(
                  left: 14,
                  child: Text(
                    model.productType,
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 40,
                  child: Text(model.value,
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff222222),
                          fontWeight: FontWeight.bold)),
                ),
                Positioned(
                  top: 40,
                  left: 110,
                  right: 16,
                  child: Text(model.productName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 16, color: Color(0xff222222))),
                ),
                Positioned(
                  left: 8,
                  bottom: 16,
                  child: Text(model.valueType + "(" + model.data + ")",
                      style: TextStyle(fontSize: 12, color: Color(0xff999999))),
                ),
                Positioned(
                  height: 20,
                  left: 112,
                  bottom: 15,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: model.type.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                              border:
                              Border.all(color: Color(0xffDFB379), width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(3))),
                          padding: EdgeInsets.only(left: 3, right: 3),
                          child: Text(model.type[index],
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xffDFB379))),
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}

class RecommendModel {
  RecommendModel(
      this.productName, this.value, this.valueType, this.data, this.desc);

  String productName;
  String value;
  String valueType;
  String data;
  String desc;
}

class HotProductModel {
  HotProductModel(
      {Key key,
      this.productName,
      this.productType,
      this.value,
      this.valueType,
      this.data,
      this.type});

  String productName;
  String productType;
  String value;
  String valueType;
  String data;
  List<String> type;
}
