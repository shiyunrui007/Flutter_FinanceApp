import '../../../base/baseWidget.dart';
import 'package:flutter/material.dart';
import '../../../model/config.dart';
import 'package:htjf_flutter_app/page/product/productPage/privateProduct.dart';
import 'package:htjf_flutter_app/page/product/productPage/publicProduct.dart';


class ProductPage extends BaseStatefulWidget {
  @override
  Config setConfig() {
    return Config(
        title: "产品",
        dismissAppBar: true
    );
  }

  @override
  State setBody() {
    return bodyWidget();
  }
}

class bodyWidget extends State with SingleTickerProviderStateMixin {
  //tabview的controller
  TabController _tabController;
  //pageview的controller
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener((){
      //添加tabview的监听
      pageChange(_tabController.index, true);
    });
    //下方的pageView的controller
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[getTabView(), getPageView()],
    );
  }

  void pageChange(int currentPage, bool isTabViewChange){
    if (isTabViewChange){
      //如果是tabview切换 则让下方的pageView联动
      _pageController.animateToPage(currentPage, duration: Duration(milliseconds: 200), curve: Curves.ease);
    } else {
      //如果是pageivew切换 则让上方的tabview联动
      _tabController..animateTo(currentPage, duration: Duration(milliseconds: 200), curve: Curves.ease);
    }
  }

  Widget getTabView() {
    return Container(
      margin: EdgeInsets.only(top: 30.0, left: 90, right: 90),
      child: TabBar(
        labelColor: Color(0xffE7B17C),
        labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        unselectedLabelColor: Colors.black,
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Color(0xffE7B17C),
        tabs: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Text("私募"),
          ),
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Text("公募"),
          )
        ],
        controller: _tabController,
      ),
    );
  }

  Widget getPageView() {
    return Expanded(
      child: PageView.builder(
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          //第一页是私募 第二页是公募
          if(0 == index){
            return PrivateProduct();
          } else {
            return PublicProduct();
          }
        },
        controller: _pageController,
        onPageChanged: (int index) {
          pageChange(index, false);
        },
      ),
    );
  }
}

