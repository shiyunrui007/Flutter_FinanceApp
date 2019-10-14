///新闻列表页


import 'package:flutter/material.dart';
import 'package:htjf_flutter_app/model/config.dart';
import '../../base/baseWidget.dart';
import 'newsList.dart';

class NewsPage extends BaseStatefulWidget{
  @override
  State<StatefulWidget> setBody() {
    return _NewsPage();
  }

  @override
  Config setConfig() {
    return Config(title: "", dismissAppBar: true);
  }
}

class _NewsPage extends State with TickerProviderStateMixin{

  TabController _tabController;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 45,
          margin: EdgeInsets.only(left: 16, right: 16, top: 23),
          child: TabBar(
            labelColor: Color(0xffE7B17C),
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            unselectedLabelColor: Colors.black,
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Color(0xffE7B17C),
            controller: _tabController,
            onTap: (index){
              _pageController.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.ease);
            },
            tabs: <Widget>[
              Text("头条"),
              Text("社会"),
              Text("体育"),
              Text("科技"),
              Text("财经"),
            ],
          ),
        ),
        Expanded(
          child: PageView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index){
              return NewsList(getUrl(index));
            },
            controller: _pageController,
            onPageChanged: (index){
              _tabController.animateTo(index, duration: Duration(milliseconds: 200));
            },
          ),
        )
      ],
    );
  }

  //通过当前的页面 获取URL
  String getUrl(int index){
    switch(index){
      case 0:
        return "index";

      case 1:
        return "shehui";

      case 2:
        return "tiyu";

      case 3:
        return "keji";

      case 4:
        return "caijing";

      default:
        return "index";
    }
  }
}