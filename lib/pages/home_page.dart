import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/config/service_url.dart';
import 'package:flutter_shop/router/application.dart';
import 'package:flutter_shop/router/routers.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  String homePageContent = "loading...";
  int page = 1;
  List<Map> hotGoodsList = [];
  GlobalKey<RefreshFooterState> _footerkey = GlobalKey<RefreshFooterState>();

  @override
  void initState() {
    getHomePageContent().then((val) {
      setState(() {
        homePageContent = val.toString();
      });
    });
    // TODO: implement initState
    print("home页面加载");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var formData = {'lon': '120.867953', 'lat': '32.030336'};

    return Scaffold(
        appBar: AppBar(
          title: Text("百姓生活+"),
        ),
        body: FutureBuilder(
          future: request('homePageContent', formData: formData),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = jsonDecode(snapshot.data.toString());
              List<Map> swiper = (data['data']['slides'] as List).cast();
              List<Map> navgatorList =
                  (data['data']['category'] as List).cast();
              String adPicture =
                  data['data']['advertesPicture']['PICTURE_ADDRESS'];

              String leaderPicture = data['data']['shopInfo']['leaderImage'];
              String phone = data['data']['shopInfo']['leaderPhone'];

              List<Map> recommendList =
                  (data['data']['recommend'] as List).cast();
              recommendList.add(recommendList[0]);
              recommendList.add(recommendList[1]);

              String floorName1 = data['data']['floor1Pic']['PICTURE_ADDRESS'];
              String floorName2 = data['data']['floor2Pic']['PICTURE_ADDRESS'];
              String floorName3 = data['data']['floor3Pic']['PICTURE_ADDRESS'];

              List<Map> picturesList1 = (data['data']['floor1'] as List).cast();
              List<Map> picturesList2 = (data['data']['floor2'] as List).cast();
              List<Map> picturesList3 = (data['data']['floor3'] as List).cast();

              return EasyRefresh(
                refreshFooter: ClassicsFooter(
                  bgColor: Colors.white,
                  textColor: Colors.pink,
                  moreInfoColor: Colors.pink,
                  showMore: true,
                  noMoreText: '没有更多',
                  moreInfo: '加载中...',
                  loadReadyText: '上拉加载',
                  key: _footerkey,
                ),
                child: ListView(
                  children: <Widget>[
                    SwiperDiy(
                      swiperDataList: swiper,
                    ),
                    TopNavigator(
                      navigatorList: navgatorList,
                    ),
                    AdBanner(adPicture),
                    LeaderPhone(leaderPicture, phone),
                    Recommend(recommendList),
                    FloorTitle(floorName1),
                    FloorContent(picturesList1),
                    FloorTitle(floorName2),
                    FloorContent(picturesList2),
                    FloorTitle(floorName3),
                    FloorContent(picturesList3),
                    _hotGoods(),
                  ],
                ),
                loadMore: () async {
                  await request('homePageBelowConten', formData: page)
                      .then((val) {
                    var data = jsonDecode(val.toString());
                    List<Map> newGoodsList = (data['data'] as List).cast();
                    setState(() {
                      hotGoodsList.addAll(newGoodsList);
                      page++;
                    });
                  });
                },
              );
            } else {
              return Center(
                child: Text("加载中"),
              );
            }
          },
        ));
  }

  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10),
    alignment: Alignment.center,
    color: Colors.transparent,
    child: Text("火爆专区"),
  );

  Widget _wrapList() {
    if (hotGoodsList.length != 0) {
      List<Widget> listWidgets = hotGoodsList.map((val) {
        return InkWell(
          onTap: () {
            Application.router
                .navigateTo(context, '/detail?id=${val['goodsId']}');
          },
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(bottom: 3),
            child: Column(
              children: <Widget>[
                Image.network(
                  val['image'],
                  width: ScreenUtil().setWidth(370),
                ),
                Text(
                  val['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
                ),
                Row(
                  children: <Widget>[
                    Text('¥${val['mallPrice']}'),
                    Text(
                      '¥${val['price']}',
                      style: TextStyle(
                          color: Colors.black26,
                          decoration: TextDecoration.lineThrough),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList();
      return Wrap(
        spacing: 2,
        children: listWidgets,
      );
    } else {
      return Text("");
    }
  }

  Widget _hotGoods() {
    return Container(
      child: Column(
        children: <Widget>[
          hotTitle,
          _wrapList(),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

/*
  首页轮播组件
 */
class SwiperDiy extends StatelessWidget {
  List swiperDataList;

  SwiperDiy({this.swiperDataList});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: Image.network("${swiperDataList[index]['image']}"),
            onTap: (){
              Application.router.navigateTo(context, "/detail?id=${swiperDataList[index]['goodsId']}");
            },
          );
        },
        itemCount: swiperDataList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

class TopNavigator extends StatelessWidget {
  final List navigatorList;

  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'], width: ScreenUtil().setWidth(95)),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: ScreenUtil().setHeight(500),
      padding: EdgeInsets.all(3),
      child: GridView.count(
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 5,
          padding: EdgeInsets.all(5),
          children: navigatorList.map((item) {
            return gridViewItemUI(context, item);
          }).toList()),
    );
  }
}

class AdBanner extends StatelessWidget {
  String path;

  AdBanner(this.path);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Image.network(path),
    );
  }
}

class LeaderPhone extends StatelessWidget {
  String imagePath;
  String phone;

  LeaderPhone(this.imagePath, this.phone);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: InkWell(
        onTap: () => _launchURL(phone),
        child: Image.network(imagePath),
      ),
    );
  }

  void _launchURL(String url) async {
//    String urlStr='tel:'+url;
//    if(await canLaunch(urlStr)){
//      await launch(urlStr);
//    }else{
//      throw Exception("no launch");
//    }
  }
}

class Recommend extends StatelessWidget {
  List recommendList;

  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10, 2, 0, 5),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Text(
        "商品推荐",
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  Widget _item(context,index) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(context, "/detail?id=${recommendList[index]['goodsId']}");
      },
      child: Container(
        height: ScreenUtil().setHeight(333),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(left: BorderSide(width: 1, color: Colors.black12))),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('¥${recommendList[index]['mallPrice']}'),
            Text(
              '¥${recommendList[index]['price']}',
              style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.black12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recommendList() {
    return Container(
      height: ScreenUtil().setHeight(333),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context, index) {
          return _item(context,index);
        },
      ),
    );
  }

  Recommend(this.recommendList);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: ScreenUtil().setHeight(400),
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[_titleWidget(), _recommendList()],
      ),
    );
  }
}

class FloorContent extends StatelessWidget {
  List picturesList;

  FloorContent(this.picturesList);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[_firstRow(context), _otherGoods(context)],
      ),
    );
  }

  Widget _firstRow(context) {
    return Row(
      children: <Widget>[
        _goodsItem(context,picturesList[0]),
        Column(
          children: <Widget>[
            _goodsItem(context,picturesList[1]),
            _goodsItem(context,picturesList[2]),
          ],
        )
      ],
    );
  }

  Widget _otherGoods(context) {
    return Row(
      children: <Widget>[
        _goodsItem(context,picturesList[3]),
        _goodsItem(context,picturesList[4]),
      ],
    );
  }

  Widget _goodsItem(BuildContext context,Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        child: Image.network(goods['image']),
        onTap: () {
          Application.router.navigateTo(context, "/detail?id=${goods['goodsId']}");

        },
      ),
    );
  }
}

class FloorTitle extends StatelessWidget {
  String pictures;

  FloorTitle(this.pictures);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(8),
      child: Image.network(pictures),
    );
  }
}
