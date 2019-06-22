import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert';
import 'package:flutter_shop/bean/category_bean_entity.dart';
import 'package:flutter_shop/bean/category_goods_bean_entity.dart';
import 'package:flutter_shop/provide/category_goods_list_provide.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:provide/provide.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CategoryPageState();
  }
}

class _CategoryPageState extends State<CategoryPage> {
  List<CategoryBeanData> categoryList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("商品分类"),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategoryNav(),
                CategoryGoodsList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/**
 * 左侧菜单
 */
class LeftCategoryNav extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LeftCategoryNavState();
  }
}

class LeftCategoryNavState extends State<LeftCategoryNav> {
  List<CategoryBeanData> categoryList = [];
  var listIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCategory();
    _getGoodsList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Container(
        child: ListView.builder(
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            return _leftInkWell(index);
          },
        ),
      ),
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1, color: Colors.black12))),
    );
  }

  Widget _leftInkWell(int index) {
    bool isClick = false;
    isClick = (index == listIndex) ? true : false;

    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });
        //左侧点击
        var childList = categoryList[index].bxMallSubDto;
        Provide.value<ChildCategory>(context)
            .getChildCategory(childList, categoryList[index].mallCategoryId);

        _getGoodsList(categoryId: categoryList[index].mallCategoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
            color: isClick ? Color.fromRGBO(236, 236, 236, 1) : Colors.white,
            border:
            Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Text(
          categoryList[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }

  void _getCategory() async {
    await request('getCategory').then((val) {
      var data = json.decode(val.toString());
      CategoryBeanEntity categoryBeanEntity = CategoryBeanEntity.fromJson(data);
      setState(() {
        categoryList = categoryBeanEntity.data;
      });
      //默认选中第一个
      Provide.value<ChildCategory>(context).getChildCategory(
          categoryList[0].bxMallSubDto, categoryList[0].mallCategoryId);
    });
  }

  void _getGoodsList({String categoryId}) async {
    var data = {
      'categoryId': categoryId == null ? '4' : categoryId,
      'categorySubId': '',
      'page': 1
    };

    await request('getMallGoods', formData: data).then((val) {
      var data = jsonDecode(val);

      CategoryGoodsBeanEntity goodsList =
      CategoryGoodsBeanEntity.fromJson(data);

      Provide.value<CategoryGoodsListProvide>(context)
          .getCategoryGoodsList(goodsList.data);
    });
  }
}

/**
 * 二级右侧导航菜单
 */
class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() {
    return _RightCategoryNavState();
  }
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Provide<ChildCategory>(builder: (context, child, childCategory) {
      return Container(
        height: ScreenUtil().setHeight(80),
        width: ScreenUtil().setWidth(570),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
                color: Colors.black12,
                width: 1,
              )),
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: childCategory.childCategoryList.length,
          itemBuilder: (context, index) {
            return _rightInWell(index, childCategory.childCategoryList[index]);
          },
        ),
      );
    });
  }

  Widget _rightInWell(int index, CategoryBeanDataBxmallsubdto item) {
    bool isClick = false;
    isClick = (index == Provide
        .value<ChildCategory>(context)
        .childIndex)
        ? true
        : false;

    return InkWell(
      onTap: () {
        Provide.value<ChildCategory>(context)
            .changeChildIndex(index, item.mallSubId);
        _getGoodsList(item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Text(
          item.mallSubName,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: isClick ? Colors.pink : Colors.black),
        ),
      ),
    );
  }

  void _getGoodsList(String categorySubId) async {
    var data = {
      'categoryId': Provide
          .value<ChildCategory>(context)
          .categoryId,
      'categorySubId': categorySubId,
      'page': 1
    };

    await request('getMallGoods', formData: data).then((val) {
      var data = jsonDecode(val);

      CategoryGoodsBeanEntity goodsList =
      CategoryGoodsBeanEntity.fromJson(data);

      if (goodsList.data == null) {
        Provide.value<CategoryGoodsListProvide>(context)
            .getCategoryGoodsList([]);

        Fluttertoast.showToast(msg: "已经到底了",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.pink,
        textColor: Colors.white,
        fontSize: ScreenUtil().setSp(18));
      } else {
        Provide.value<CategoryGoodsListProvide>(context)
            .getCategoryGoodsList(goodsList.data);
      }
    });
  }
}

class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() {
    return _CategoryGoodsListState();
  }
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  GlobalKey<RefreshFooterState> _footerkey = GlobalKey<RefreshFooterState>();

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data) {
        try {
          if (Provide
              .value<ChildCategory>(context)
              .page == 1) {
            scrollController.jumpTo(0);
          }
        } catch (e) {
          print('进入界面第一次初始化');
        }

        if (data.CategoryGoodsListData != null &&
            data.CategoryGoodsListData.length > 0) {
          return Expanded(
            flex: 1,
            child: Container(
                width: ScreenUtil().setWidth(570),
                child: EasyRefresh(
                  refreshFooter: ClassicsFooter(
                    bgColor: Colors.white,
                    textColor: Colors.pink,
                    moreInfoColor: Colors.pink,
                    showMore: true,
                    noMoreText:
                    Provide
                        .value<ChildCategory>(context)
                        .noMoreText,
                    moreInfo: '加载中...',
                    loadReadyText: '上拉加载',
                    key: _footerkey,
                  ),
                  child: ListView.builder(
                    controller: scrollController,
                      itemCount: data.CategoryGoodsListData.length,
                      itemBuilder: (context, index) {
                        return _getListItemWidget(
                            data.CategoryGoodsListData, index);
                      }),
                  loadMore: () async {
                    _getMoreList();
                  },
                )),
          );
        } else {
          return Center(
            child: Text("暂无数据"),
          );
        }
      },
    );
  }

  void _getMoreList() async {
    Provide.value<ChildCategory>(context).pageAdd();

    var data = {
      'categoryId': Provide
          .value<ChildCategory>(context)
          .categoryId,
      'categorySubId': Provide
          .value<ChildCategory>(context)
          .subId,
      'page': Provide
          .value<ChildCategory>(context)
          .page,
    };

    await request('getMallGoods', formData: data).then((val) {
      var data = jsonDecode(val);

      CategoryGoodsBeanEntity goodsList =
      CategoryGoodsBeanEntity.fromJson(data);

      if (goodsList.data == null) {
        Provide.value<ChildCategory>(context).changeNoMoreText("没有更多");
      } else {
        Provide.value<CategoryGoodsListProvide>(context)
            .getMoreCategoryGoodsList(goodsList.data);
      }
    });
  }
}

Widget _getGoodsListImage(List newList, index) {
  return Container(
    width: ScreenUtil().setWidth(200),
    child: Image.network(newList[index].image),
  );
}

Widget _getGoodsListName(List newList, index) {
  return Container(
    padding: EdgeInsets.all(5),
    width: ScreenUtil().setWidth(370),
    child: Text(
      newList[index].goodsName,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: ScreenUtil().setSp(28)),
    ),
  );
}

Widget _getGoodsListPrice(List newList, index) {
  return Container(
    width: ScreenUtil().setWidth(370),
    margin: EdgeInsets.only(top: 20),
    child: Row(
      children: <Widget>[
        Text(
          '价格：¥${newList[index].presentPrice}',
          style:
          TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(30)),
        ),
        Text(
          '¥${newList[index].oriPrice}',
          style: TextStyle(
              color: Colors.black26, decoration: TextDecoration.lineThrough),
        ),
      ],
    ),
  );
}

Widget _getListItemWidget(List newList, index) {
  return InkWell(
    onTap: () {},
    child: Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Row(
        children: <Widget>[
          _getGoodsListImage(newList, index),
          Column(
            children: <Widget>[
              _getGoodsListName(newList, index),
              _getGoodsListPrice(newList, index),
            ],
          )
        ],
      ),
    ),
  );
}
