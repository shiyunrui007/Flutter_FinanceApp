
import 'package:flutter/material.dart';
import 'package:htjf_flutter_app/model/config.dart';
import '../../base/baseWidget.dart';
import '../details/newsDetail.dart';
import '../../model/newsModel.dart';

class NewsList extends BaseStatefulWidget{

  String _url;//当前的类型 0：头条 1：社会 2：体育 3：科技 4：财经
  NewsList(this._url);

  @override
  State<StatefulWidget> setBody() {
    // TODO: implement setBody
    return _NewsList(_url);
  }

  @override
  Config setConfig() {
    return Config(
      title: "",
      dismissAppBar: true
    );
  }
}

class _NewsList extends State{

  _NewsList(this._url);

  List<Data> _newsListData = new List();
  String _url;
  int _currentPage = 1;//当前的页数
  ScrollController _scrollController;
  bool _noMoreData = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //请求网络 拿到数据
    requestData(true);
    _scrollController = ScrollController();
    _scrollController.addListener((){
      //test
      if (_currentPage == 1){
        _noMoreData = true;
      }

      if (_noMoreData){
        //无更多数据了 不允许上拉加载更多了
        return;
      }
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        //滚动到了底部
        requestData(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        RefreshIndicator(
          onRefresh: _onRefresh,
          child: ListView.builder(
            controller: _scrollController,
            physics: BouncingScrollPhysics(),
            //这里+1是为了放上拉加载的结果Widget
            itemCount: _newsListData.isEmpty? 0: _newsListData.length + 1,
            itemBuilder: (BuildContext context, int index){
              if (index == _newsListData.length){
                return getPullUpResultWidget();
              }
              return GestureDetector(
                child: Container(
                  height: 80,
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: <Widget>[
                      Positioned(
                        child: Image.network(_newsListData[index].thumbnailPicS, height: 70, width: 70, fit: BoxFit.fill,),
                        left: 16,
                      ),
                      Positioned(
                        top: 5,
                        left: 102,
                        right: 16,
                        child: Text(_newsListData[index].title, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 15, color: Color(0xff333333)),),
                      ),
                      Positioned(
                        left: 102,
                        right: 16,
                        bottom: 5,
                        child: Text(_newsListData[index].authorName + "   " + _newsListData[index].date, style: TextStyle(color: Color(0x6f333333), fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis,),
                      )
                    ],
                  ),
                ),
                onTap: (){
                  switchNextPage(context, NewsDetail(_newsListData[index].url));
                },
              );
            }
          ),
        ),
        Offstage(
          offstage: !isLoading,
          child: getLoadingWidget(),
        )
      ],
    );
  }

  //下拉刷新函数
  Future _onRefresh() async{
    requestData(true);
  }

  void requestData(bool isFirstRequest){
    //isFirstRequest用来区分是第一次加载还是上拉加载更多 如果是第一次加载或者下拉刷新
    //这里要分页加载 注意传参
    if (isFirstRequest){
      _newsListData.clear();
      _currentPage = 1;
      _noMoreData = false;
    }
    requestAPI(_url, (value){
      setState(() {
        _newsListData.addAll(NewsModel.fromJson(value).result.data);
        _currentPage ++;
      });
    });
  }


  //上拉加载更多的Widget 包括上拉加载更多和暂无更多数据两种类型
  Widget getPullUpResultWidget(){
    if (!_noMoreData){
      //加载更多
      return Container(
        height: 45,
        padding: EdgeInsets.only(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(strokeWidth: 3,),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text("加载中..."),
            )
          ],
        )
      );
    } else {
      //暂无更多数据
      return Container(
        alignment: Alignment.center,
        height: 45,
        child: Text("暂无更多数据")
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}