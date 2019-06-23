import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/currentIndex.dart';
import 'package:provide/provide.dart';

import 'cart_page.dart';
import 'category_page.dart';
import 'home_page.dart';
import 'member_page.dart';

class IndexPage extends StatelessWidget {

  int currentIndex = 0;
  var currentPage;

  List<Widget> tabPages = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage(),
  ];

  List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text("首页")),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search), title: Text("分类")),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart), title: Text("购物车")),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), title: Text("会员中心")),
  ];


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);

    return Provide<CurrentIndexProvide>(
      builder: (context,child,val){
        int currentIndex=Provide.value<CurrentIndexProvide>(context).currentIndex;

        return Scaffold(
          backgroundColor: Color.fromRGBO(244, 245, 245, 1),
          body: IndexedStack(
            index: currentIndex,
            children: tabPages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            items: bottomTabs,
            onTap: (index) {
              Provide.value<CurrentIndexProvide>(context).changeIndex(index);
            },

          ),
        );
      },
    );
  }
}




//class IndexPage extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() {
//
//    // TODO: implement createState
//    return _IndexPageState();
//  }
//}
//
//class _IndexPageState extends State<IndexPage> {
//  int currentIndex = 0;
//  var currentPage;
//
//  List<Widget> tabPages = [
//    HomePage(),
//    CategoryPage(),
//    CartPage(),
//    MemberPage(),
//  ];
//
//  List<BottomNavigationBarItem> bottomTabs = [
//    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text("首页")),
//    BottomNavigationBarItem(
//        icon: Icon(CupertinoIcons.search), title: Text("分类")),
//    BottomNavigationBarItem(
//        icon: Icon(CupertinoIcons.shopping_cart), title: Text("购物车")),
//    BottomNavigationBarItem(
//        icon: Icon(CupertinoIcons.profile_circled), title: Text("会员中心")),
//  ];
//
//  @override
//  void initState() {
//    currentPage = tabPages[currentIndex];
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
//
//    // TODO: implement build
//    return Scaffold(
//      backgroundColor: Color.fromRGBO(244, 245, 245, 1),
//      body: IndexedStack(
//        index: currentIndex,
//        children: tabPages,
//      ),
//      bottomNavigationBar: BottomNavigationBar(
//        type: BottomNavigationBarType.fixed,
//        currentIndex: currentIndex,
//        items: bottomTabs,
//        onTap: (index) {
//          setState(() {
//            currentIndex = index;
//            currentPage = tabPages[currentIndex];
//          });
//        },
//
//      ),
//    );
//  }
//}
