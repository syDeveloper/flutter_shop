import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/counter.dart';
import 'package:flutter_shop/router/application.dart';
import 'package:provide/provide.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("会员中心"),
      ),
      body: ListView(
        children: <Widget>[
          _topHeader(context),
          _orderTitle(),
          _orderType(),
          _actionList(),
        ],
      ),
    );
  }

  Widget _topHeader(context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20),
      color: Colors.pinkAccent,
      child: Column(
        children: <Widget>[
         InkWell(
           onTap: (){
//             Application.router.navigateTo(context, "/map");
           },
           child:  Container(
             margin: EdgeInsets.only(top: 30),
             child: ClipOval(
               child: Image.network(
                 "https://s2.ax1x.com/2019/06/23/ZPTxG6.jpg",
                 width: ScreenUtil().setWidth(200),
                 height: ScreenUtil().setHeight(200),
               ),
             ),
           ),
         ),
          Container(
            margin: EdgeInsets.only(top: 33),
            child: Text(
              "用户名",
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(36), color: Colors.black54),
            ),
          )
        ],
      ),
    );
  }

  Widget _orderTitle() {
    return Container(
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text("我的订单"),
        trailing: Icon(Icons.arrow_right),
      ),
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
    );
  }

  Widget _orderType() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.only(top: 20),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.party_mode,
                  size: 30,
                ),
                Text('待付款')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.query_builder,
                  size: 30,
                ),
                Text('待发货')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.directions_car,
                  size: 30,
                ),
                Text('待收货')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.content_paste,
                  size: 30,
                ),
                Text('待评价')
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _listTitle(title){
    return Container(
      child: ListTile(
        leading: Icon(Icons.blur_circular),
        title: Text(title),
        trailing: Icon(Icons.arrow_right),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1,color: Colors.black12),
        )

      ),
    );
  }

  Widget _actionList(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _listTitle("领取优惠券"),
          _listTitle("已领取优惠券"),
          _listTitle("地址管理"),
          _listTitle("客服电话"),
          _listTitle("关于我们"),

        ],
      ),
    );
  }
}
