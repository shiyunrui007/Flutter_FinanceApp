import '../base/baseWidget.dart';
import 'package:flutter/material.dart';
import '../model/config.dart';
import 'package:fl_chart/fl_chart.dart';
import 'product/productDetail/publicProductDetail.dart';

class AssetPage extends BaseStatefulWidget {
  @override
  Config setConfig() {
    return Config(
        title: "资产",
        dismissAppBar: true
    );
  }

  @override
  State<StatefulWidget> setBody() {
    return AssetState();
  }
}

class AssetState extends State {
  //刚进来的时候默认是显示的
  bool isShow = true;
  String totalAssets = "6,200,800.00";
  String yesterdayEarn = "-5,000,000.00";
  List<AssetDetailModel> assetDetailModelList = new List();

  List<PieChartSectionData> pieChartList = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    assetDetailModelList
      ..add(new AssetDetailModel(0xffE7B17C, "私募资产", 12000000.00, "12,000,000.00"))
      ..add(new AssetDetailModel(0xff4D73B2, "公募资产", 500000.00, "500,000.00"))
      ..add(new AssetDetailModel(0xffE6891E, "活期理财", 100000.00, "100,000.00"))
      ..add(new AssetDetailModel(0xff9A39AD, "定融定投", 4000000.00, "4,000,000.00"))
      ..add(new AssetDetailModel(0xffDBECF8, "公募智投", 650000.00, "650,000.00"));

    assetDetailModelList.forEach((model){
      pieChartList.add(PieChartSectionData(showTitle: false, value: model.value, color: Color(model.color)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //主视图列表
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            getAssetHeader(),
            getPieChart(),
            getAssetDetail()
          ],
        ),
      ),
    );
  }

  Widget getAssetHeader() {
    return Container(
      height: 190,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            child: Image.asset("assets/images/iv_assets_bg.png", height: 155),
          ),
          Positioned(
            top: 44,
            child: Text(
              "账户资产",
              style: TextStyle(fontSize: 20, color: Color(0xffDFB379)),
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            left: 20,
            top: 92,
            child: Text(
              "尊敬的李先生",
              style: TextStyle(fontSize: 16, color: Color(0xffDFB379)),
              textAlign: TextAlign.center,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 65,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Color(0xffF1F6FB)),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      "总资产     ",
                      style: TextStyle(fontSize: 14, color: Color(0xff7D7C7D)),
                      textAlign: TextAlign.left,
                    ),
                    GestureDetector(
                      child: Image.asset(
                        isShow
                            ? "assets/images/icon_show.png"
                            : "assets/images/icon_dismiss.png",
                        width: 18,
                        height: 12,
                      ),
                      onTap: () {
                        setState(() {
                          isShow = !isShow;
                        });
                      },
                    )
                  ],
                ),
                Container(
                  child: Text(
                    isShow ? totalAssets : "********",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff333333),
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            left: 190,
            bottom: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "昨日收益(元)",
                  style: TextStyle(fontSize: 14, color: Color(0xff7D7C7D)),
                  textAlign: TextAlign.left,
                ),
                Container(
                  child: Text(
                    isShow ? yesterdayEarn : "********",
                    style: TextStyle(
                        fontSize: 20,
                        color: isShow
                            ? yesterdayEarn.substring(0, 1) == "-"
                                ? Colors.green
                                : Colors.red
                            : Color(0xff333333),
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getPieChart() {
    return Container(
      child: FlChart(
          chart: PieChart(PieChartData(
              sections: pieChartList,
              centerSpaceRadius: 40,
              borderData: FlBorderData(show: false),
              sectionsSpace: 0))),
    );
  }

  Widget getAssetDetail() {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      padding: EdgeInsets.only(left: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color(0xffFBFBFB)
      ),
      child: GridView.builder(
          itemCount: assetDetailModelList.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //横向数量
            crossAxisCount: 2,
            childAspectRatio: 5/2
          ),
          itemBuilder: (BuildContext context, int index){
            return getAssetDetailItem(assetDetailModelList[index]);
          }),
    );
  }

  Widget getAssetDetailItem(AssetDetailModel model) {
    return GestureDetector(
      onTap: () {
        switchNextPage(context, PublicProductDetail(model.valueDesc, model.title));
      },
      child: Container(
        child: Stack(
          overflow: Overflow.clip,
          children: <Widget>[
            Positioned(
              top: 17,
              child: Container(
                color: Color(model.color),
                width: 10,
                height: 10,
              ),
            ),
            Positioned(
              top: 12,
              left: 16,
              child: Text(model.title,
                style: TextStyle(fontSize: 13, color: Color(0xff82878D)),),
            ),
            Positioned(
              top: 32,
              child: Text(model.valueDesc,
                style: TextStyle(fontSize: 13, color: Color(0xff333333)),),
            )
          ],
        ),
      ),
    );
  }
}

class AssetDetailModel{
  AssetDetailModel(this.color, this.title, this.value, this.valueDesc);
  int color;
  String title;
  double value;
  String valueDesc;
}