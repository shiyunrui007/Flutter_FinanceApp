import 'package:flutter/material.dart';
import 'page/assetPage.dart';
import 'package:htjf_flutter_app/page/index/indexPage.dart';
import 'package:htjf_flutter_app/page/product/productPage/productPage.dart';
import 'page/minePage.dart';
import 'package:flutter/rendering.dart';
import 'page/news/newsPage.dart';

class BottomNavigationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new BottomNavigationWidgetState();
  }
}

class BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  List<Widget> pages = new List();
  int _currentIndex = 0;

  @override
  void initState() {
    pages
      ..add(IndexPage())
      ..add(ProductPage())
      ..add(NewsPage())
      ..add(AssetPage())
      ..add(MinePage());
  }

  @override
  Widget build(BuildContext context) {
    /*
    返回一个脚手架，里面包含两个属性，一个是底部导航栏，另一个就是主体内容
     */
    return new Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        //底部导航栏的创建需要对应的功能标签作为子项，这里我就写了3个，每个子项包含一个图标和一个title。
        items: [
          getItem("assets/images/ic_index.png", "首页"),
          getItem("assets/images/ic_product.png", "产品"),
          getItem("assets/images/ic_news.png", "资讯"),
          getItem("assets/images/ic_asset.png", "资产"),
          getItem("assets/images/ic_mine.png", "我的"),
        ],
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: TextStyle(color: Colors.black),
        selectedLabelStyle: TextStyle(color: Color(0xffDFB379)),
        //这是底部导航栏自带的位标属性，表示底部导航栏当前处于哪个导航标签。给他一个初始值0，也就是默认第一个标签页面。
        currentIndex: _currentIndex,
        //这是点击属性，会执行带有一个int值的回调函数，这个int值是系统自动返回的你点击的那个标签的位标
        onTap: (int i) {
          //进行状态更新，将系统返回的你点击的标签位标赋予当前位标属性，告诉系统当前要显示的导航标签被用户改变了。
          setState(() {
            _currentIndex = i;
          });
        },
      ),
      body: pages[_currentIndex],
    );
  }

  BottomNavigationBarItem getItem(imgPath, title){
    return BottomNavigationBarItem(
        icon: Image.asset(
          imgPath,
          width: 25,
          height: 25,
        ),
        title: new Text(
          title,
          style: new TextStyle(
            color: Colors.black
          ),
        )
    );
  }
}

void main(){
//  debugPaintSizeEnabled  = true;
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '恒天财富Flutter',
      home: new BottomNavigationWidget(),
      debugShowCheckedModeBanner: false,
    );
  }
}
