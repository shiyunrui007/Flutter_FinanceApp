import 'package:htjf_flutter_app/model/config.dart';
import '../../base/baseWidget.dart';
import 'package:flutter/material.dart';
import '../../model/config.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../model/bannerModel.dart';
import '../details/bannerDetail.dart';
import '../../base/baseUiWidget.dart' as BaseUI;
import '../../model/NewsListModel.dart';
import '../../page/product/productDetail/publicProductDetail.dart';
import '../details/newsDetail.dart';

class IndexPage extends BaseStatefulWidget {
  @override
  Config setConfig() {
    return Config(title: "首页", dismissAppBar: true);
  }

  @override
  State setBody() {
    return IndexState();
  }
}

class IndexState extends State with TickerProviderStateMixin {
  BuildContext buildContext;
  List<KingKangModel> gridList = new List();
  NewsListModel _newsListModel;
  //banner相关的model
  BannerModel _bannerModel;

  @override
  void initState() {
    super.initState();
    //initView放在里面
    gridList
      ..add(new KingKangModel("assets/images/icon_account.png", "开户/认证"))
      ..add(new KingKangModel("assets/images/icon_private.png", "热销私募"))
      ..add(new KingKangModel("assets/images/icon_cash.png", "现金管理"))
      ..add(new KingKangModel("assets/images/icon_current.png", "活期理财"))
      ..add(new KingKangModel("assets/images/icon_public_group.png", "公募组合"))
      ..add(new KingKangModel("assets/images/icon_public_fixed.png", "公募定投"))
      ..add(new KingKangModel("assets/images/icon_public_smart.png", "公募智投"))
      ..add(new KingKangModel("assets/images/icon_heng_shop.png", "恒乐汇商场"));

    requestAPI("get_banner_info", (value){
      //请求banner图的数据
      setState(() {
        _bannerModel = new BannerModel.fromJson(value);
      });
    });

    requestAPI("get_news_list", (value){
      //请求新闻列表的数据
      setState(() {
        _newsListModel = new NewsListModel.fromJson(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return getBody();
  }

  Widget getBody(){
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              getRow(),
              getGrideView(),
              BaseUI.BaseUIWidget().getDividerLine(),
              getBanner(),
              getNewsView(),
              getMoreInfo(),
              BaseUI.BaseUIWidget().getDividerLine(),
              BaseUI.BaseUIWidget().getTitle("精选专题"),
              getSelectedTopic(),
              BaseUI.BaseUIWidget().getDividerLineMargin(),
              BaseUI.BaseUIWidget().getTitle("平台资质"),
              getQualifications()
            ],
          ),
        ),
        Offstage(
          offstage: !isLoading,
          child: getLoadingWidget(),
        )
      ],
    );
  }

  Widget getGrideView() {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: gridList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //横向数量
              crossAxisCount: 4,
              childAspectRatio: 5 / 4),
          itemBuilder: (BuildContext context, int index) {
            return getGrideItem(gridList[index]);
          }),
    );
  }

  Widget getGrideItem(KingKangModel model) {
    return Container(
      width: 30,
      child: Column(
        children: <Widget>[
          Image.asset(model.imgPath, width: 30.0, height: 30.0),
          Container(
            margin: EdgeInsets.only(top: 2),
            child: Text(
              model.title,
              style: TextStyle(fontSize: 12, color: Color(0xff222222)),
            ),
          )
        ],
      ),
    );
  }

  //获取信息列表
  //下面使用PageView来实现 不用ListView
  Widget getNewsTab() {
    TabController tabController = new TabController(length: 3, vsync: this);
    return Container(
      width: 200,
      child: TabBar(
        labelPadding: EdgeInsets.all(10.0),
        //选中的字体样式
        labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        //未选中的字体样式
        unselectedLabelStyle:
        TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        //选中的字体颜色
        labelColor: Color(0xffDFB379),
        //未选中的字体颜色
        unselectedLabelColor: Color(0xff999999),
        //下面标识条的颜色
        indicatorColor: Color(0xffDFB379),
        indicatorPadding: EdgeInsets.only(bottom: 7),
        tabs: <Widget>[
          Container(
            child: Text("市场"),
          ),
          Container(
            child: Text("快讯"),
          ),
          Container(
            child: Text("研报"),
          ),
        ],
        indicatorSize: TabBarIndicatorSize.label,
        controller: tabController,
//      onTap: (int index) {
//        setState(() {
//          newsList.forEach((model){
//            model.title = model.title + index.toString();
//          });
//        });
//      },
      ),
    );
  }

  Widget getNewsListViewArea() {
    return Container(
        child: getNewsListView());
  }

  Widget getNewsListView(){
    if (_newsListModel != null && _newsListModel.newsList.isNotEmpty){
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Container(
              margin: EdgeInsets.only(left: 16),
              padding: EdgeInsets.only(right: 16, top: 12, bottom: 12),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Color(0xffeeeeee), width: 0.5))),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _newsListModel.newsList[index].title + index.toString(),
                      style: TextStyle(fontSize: 14, color: Color(0xff222222)),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 12),
                    child: Text(
                      _newsListModel.newsList[index].date,
                      style: TextStyle(fontSize: 12, color: Color(0xff999999)),
                      textAlign: TextAlign.left,
                    ),
                  )
                ],
              ),
            ),
            onTap: (){
              switchNextPage(context, NewsDetail("http://www.jnlc.com/article/20191012248576.shtml"));
            },
          );
        },
        itemCount: _newsListModel.newsList.length,
      );
    } else {
      return SizedBox();
    }
  }

  Widget getNewsView() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 16),
            height: 50,
            child: getNewsTab(),
          ),
          Container(
            child: getNewsPageView(),
          )
        ],
      ),
    );
  }

  Widget getNewsPageView() {
    return Container(
      alignment: Alignment.topCenter,
      child: getNewsListViewArea(),
    );
  }

  Widget getBanner() {
    return Container(
      margin: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
      height: 80.0,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        child: getSwiper()
      ),
    );
  }

  Widget getSwiper(){
    if (_bannerModel != null && _bannerModel.bannerList.isNotEmpty){
      return Swiper(
        itemCount: _bannerModel.bannerList.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(_bannerModel.bannerList[index].imgPath, fit: BoxFit.fill);
        },
        autoplay: true,
        autoplayDelay: 2000,
        autoplayDisableOnInteraction: true,
        duration: 500,
        plugins: <SwiperPlugin>[],
      );
    } else {
      return SizedBox();
    }
  }

  Widget getRow() {
    return Container(
      margin: EdgeInsets.only(left: 16.0, top: 32.0, right: 16.0, bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new GestureDetector(
            child: Image.asset("assets/images/index_header_1.png",
                width: 100, height: 50),
            onTap: () {
            },
          ),
          new GestureDetector(
            child: Image.asset("assets/images/index_header_2.png",
                width: 100, height: 50),
            onTap: () {},
          ),
          new GestureDetector(
            child: Image.asset("assets/images/index_header_3.png",
                width: 100, height: 50),
            onTap: () {},
          )
        ],
      ),
    );
  }

  Widget getMoreInfo() {
    return Container(
      padding: EdgeInsets.only(left: 13, right: 13, top: 3, bottom: 3),
      margin: EdgeInsets.only(top: 12, bottom: 12),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xffDFB379), width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Text("查看更多",
          style: TextStyle(fontSize: 12, color: Color(0xffDFB379))),
    );
  }

  //精选专题
  Widget getSelectedTopic() {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        children: <Widget>[
          GestureDetector(
            child: Container(
              height: 130,
              decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage("http://img1.gtimg.com/sports/pics/hv1/202/84/1781/115831147.jpg"), fit: BoxFit.fill),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            onTap: (){
              switchNextPage(context, BannerDetail("http://img1.gtimg.com/sports/pics/hv1/202/84/1781/115831147.jpg"));
            },
          ),
          GestureDetector(
            child: Container(
              height: 130,
              margin: EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage("http://b.hiphotos.baidu.com/zhidao/wh%3D450%2C600/sign=9e30f243ca3d70cf4cafa209cdecfd36/adaf2edda3cc7cd96c1e94a33a01213fb80e919d.jpg"), fit: BoxFit.fill),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            onTap: (){
              switchNextPage(context, BannerDetail("http://b.hiphotos.baidu.com/zhidao/wh%3D450%2C600/sign=9e30f243ca3d70cf4cafa209cdecfd36/adaf2edda3cc7cd96c1e94a33a01213fb80e919d.jpg"));
            },
          )
        ],
      ),
    );
  }

  //精选专题
  Widget getQualifications() {
    return Container(
      height: 90,
      margin: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/ic_team.png"), fit: BoxFit.fill),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              onTap: (){
                switchNextPage(context, BannerDetail("assets/images/ic_team.png"));
              },
            ),
          ),
          Expanded(
            child: GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 12),
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/images/ic_qualifacation.png"), fit: BoxFit.fill),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              onTap: (){
                switchNextPage(context, BannerDetail("assets/images/ic_qualifacation.png"));
              },
            ),
          )
        ],
      ),
    );
  }
}

class KingKangModel {
  String imgPath;
  String title;

  KingKangModel(this.imgPath, this.title);

  void tapListener() {}
}
