import 'package:flutter/material.dart';
import 'package:htjf_flutter_app/model/config.dart';
import '../../../base/baseWidget.dart';


///此页面隐藏掉baseAppBar，自定义一个类似于appBar的空间浮在上面，搞成沉浸式
//总资产数量
String _totalAsset = "";
//页面title
String _pageTitle = "";

class PublicProductDetail extends BaseStatefulWidget {

  PublicProductDetail(totalAsset, pageTitle){
    _totalAsset = totalAsset;
    _pageTitle = pageTitle;
  }

  @override
  State<StatefulWidget> setBody() {
    return _PublicProductDetail();
  }

  @override
  Config setConfig() {
    return Config(title: "", dismissAppBar: true);
  }
}

class _PublicProductDetail extends State with SingleTickerProviderStateMixin{

  bool _isShow = false;
  TabController _tabController;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener((){
      _pageController.animateToPage(_tabController.index, duration: Duration(milliseconds: 200), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        NotificationListener(
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Column(
                children: <Widget>[
                  getHeader(),
                  getTabBar(),
                  getPageView()
                ],
              ),
            ),
            onNotification: (ScrollNotification scrollNotification) {
              if (scrollNotification.metrics.axisDirection == AxisDirection.down && scrollNotification is ScrollEndNotification){
                //只有在上下滚动且滚动到头或者底 才去做判断
                if (scrollNotification.metrics.extentAfter == 0){
                  //滚动到底部
                  //ScrollView滚动到了底部 这个时候让listview可以滚动
                  setState(() {
                    _isShow = true;
                  });
                }
                if (scrollNotification.metrics.extentBefore == 0){
                  //滚动到顶部
                  //这个时候禁止listview滚动事件， 让scrollview来滚动
                  setState(() {
                    _isShow = false;
                  });
                }
              }
              return true;
            }
        ),
        Offstage(
          offstage: !_isShow,
          child: Container(
            margin: EdgeInsets.only(top: 68),
            child: getTabBar(),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          child: getAppBar(),
        )
      ],
    );
  }

  Widget getHeader(){
    return Container(
      height: 282,
      color: Color(0xfff5f5f5),
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Positioned(
            child: Image.asset("assets/images/ic_header.png", height: 208, fit: BoxFit.fill,)
          ),
          Positioned(
            top: 82,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("总资产(元)", style: TextStyle(fontSize: 12, color: Color.fromARGB(127, 255, 255, 255)),),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Image.asset("assets/images/ic_tip_yellow.png", width: 12, height: 12, color: Colors.white,),
                )
              ],
            ),
          ),
          Positioned(
            top: 111,
            child: Text(_totalAsset, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),),
          ),
          Positioned(
            bottom: 0,
            left: 16,
            right: 16,
            child: Container(
              height: 118,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 20,
                    left: 60,
                    child: Text("已持仓(元)", style: TextStyle(fontSize: 12, color: Color(0xff999999)),),
                  ),
                  Positioned(
                    top: 20,
                    left: 200,
                    child: Text("待确认(元)", style: TextStyle(fontSize: 12, color: Color(0xff999999)),),
                  ),
                  Positioned(
                    top: 43,
                    left: 60,
                    child: Text("+98,87", style: TextStyle(fontSize: 14, color: Color(0xff695a37)),),
                  ),
                  Positioned(
                    top: 43,
                    left: 200,
                    child: Text("2098.00", style: TextStyle(fontSize: 14, color: Color(0xffd75e33)),),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(left: 16, right: 16),
                      decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: Color(0xfff5f5f5)))
                      ),
                      height: 45,
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Positioned(
                            left: 0,
                            child: Image.asset("assets/images/ic_asset_profit.png", width: 14,),
                          ),
                          Positioned(
                            left: 19,
                            child: Text("资产证明", style: TextStyle(fontSize: 14, color: Color(0xff333333)),),
                          ),
                          Positioned(
                            right: 0,
                            child: Image.asset("assets/images/ic_right_triangle.png", width: 6,),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getAppBar(){
    return Container(
      padding: EdgeInsets.only(top: 23),
      color: _isShow? Colors.white: Colors.transparent,
      height: 68,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            left: 16,
            child: GestureDetector(
              child: Container(
                child: Image.asset("assets/images/ic_back_arrow.png", height: 20, color: getChangedColor(),),
              ),
              onTap: (){
                Navigator.of(context).pop();
              },
            ),
          ),
          Positioned(
            child: Text(_pageTitle, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: getChangedColor())),
          ),
          Positioned(
            right: 16,
            child: Image.asset("assets/images/ic_detail.png", height: 12, width: 20, color: getChangedColor()),
          )
        ],
      ),
    );
  }

  Widget getTabBar(){
    return Container(
      color: Color(0xfff5f5f5),
      padding: EdgeInsets.only(left: 60, right: 60),
      height: 45,
      child: TabBar(
        controller: _tabController,
        labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
        labelColor: Color(0xff3c3c3c),
        indicatorColor: Colors.redAccent,
        tabs: <Widget>[
          Container(
            child: Text("已持仓资产"),
          ),
          Container(
            child: Text("待确认资产"),
          )
        ],
      ),
    );
  }
  
  Color getChangedColor(){
    if (!_isShow){
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  ScrollPhysics getScrollPhysics(bool isShow){
    if (isShow){
      return BouncingScrollPhysics();
    } else {
      return NeverScrollableScrollPhysics();
    }
  }

  Widget getPageView(){
    return Container(
      //高度为屏幕的高度
      height: MediaQuery.of(context).size.height - 113,
      color: Color(0xfff5f5f5),
        child: PageView.builder(
          controller: _pageController,
          onPageChanged: (int index){
            if (_tabController != null){
              _tabController.animateTo(index);
            }
          },
          itemCount: 2,
          itemBuilder: (BuildContext context, int index){
            if (index == 0){
              return ListView.builder(
                shrinkWrap: true,
                physics: getScrollPhysics(_isShow),
                itemBuilder: (BuildContext context, int index){
                  return getListItem(index);
                },
                itemCount: 8,
              );
            } else {
              return ListView.builder (
                shrinkWrap: true,
                physics: getScrollPhysics(_isShow),
                itemBuilder: (BuildContext context, int index){
                  return getListItem(index);
                },
                itemCount: 13,
              );
            }
          }
        )
    );
  }

  Widget getListItem(int index){
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 10),
      padding: EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 12),
            child: Text("北京中泰项目北京中泰项目北京中泰项目北京中泰项目北京中泰项目北京中泰项目北京中泰项目北京中泰项目北京中泰项目北京中泰项目北京中泰项目北京中泰项目北京中泰项目北京中泰项目北京中泰项目北京中泰项目北京中泰项目北京中泰项目北京中泰项目",
              style: TextStyle(fontSize: 14, color: Color(0xff3c3c3c), fontWeight: FontWeight.bold), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,),
          ),
          getListItemChild("认购金额", "100,000,000.00万"),
          getListItemChild("成立日期", "2019-09-09"),
          getListItemChild("index", index.toString()),
        ],
      ),
    );
  }

  Widget getListItemChild(String title, String value){
    return Container(
      color: Color(0xfff5f5f5),
      padding: EdgeInsets.only(left: 8, right: 8),
      margin: EdgeInsets.only(top: 4),
      height: 28,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: <Widget>[
          Text(title, style: TextStyle(color: Color(0xffa48e5f), fontSize: 12),),
          Align(
            alignment: Alignment.centerRight,
            child: Text(value, style: TextStyle(fontSize: 12, color: Color(0xff695a37)),),
          )
        ],
      ),
    );
  }
}
