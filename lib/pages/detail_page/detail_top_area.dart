import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/detail_info.dart';
import 'package:provide/provide.dart';
import 'package:flutter/material.dart';

class DetailTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Provide<DetailsInfoProvide>(
      builder: (context, child, val) {
        var goodInfo =
            Provide
                .value<DetailsInfoProvide>(context)
                .goodsInfo
                .data
                .goodInfo;

        if (goodInfo == null) {
          return Text("loading");
        } else {
          return Container(
            color: Colors.white,
            child: Column(children: <Widget>[
              _goodsImage(goodInfo.image1),
              _goodsName(goodInfo.goodsName),
              _goodsNum(goodInfo.goodsSerialNumber),
              Row(
                children: <Widget>[
                  _goodsPrice(goodInfo.presentPrice),
                  _goodsMarketPrice(goodInfo.oriPrice),
                ],
              ),
            ],),
          );
        }
      },
    );
  }

  Widget _goodsImage(url) {
    return Image.network(
      url,
      width: ScreenUtil().setWidth(740),
    );
  }

  Widget _goodsName(name) {
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15),
      child: Text(
        name,
        style: TextStyle(fontSize: ScreenUtil().setSp(30)),
      ),
    );
  }

  Widget _goodsNum(num) {
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 14),
      margin: EdgeInsets.only(top: 8),
      child: Text(
        '编号:${num}',
        style:
        TextStyle(color: Colors.black26, fontSize: ScreenUtil().setSp(20)),
      ),
    );
  }

  Widget _goodsPrice(price) {
    return Container(
      width: ScreenUtil().setWidth(140),
      padding: EdgeInsets.only(left: 14),
      margin: EdgeInsets.only(top: 8),
      child: Text(
        '¥${price}',
        style: TextStyle(
            color: Colors.deepOrangeAccent, fontSize: ScreenUtil().setSp(32)),
      ),
    );
  }

  Widget _goodsMarketPrice(marketPrice) {
    return Container(
      width: ScreenUtil().setWidth(340),
      padding: EdgeInsets.only(left: 14),
      margin: EdgeInsets.only(top: 8),
      child: Text(
        '市场价：${marketPrice}',
        style: TextStyle(
            color: Colors.black26,
            fontSize: ScreenUtil().setSp(28),
            decoration: TextDecoration.lineThrough),
      ),
    );
  }
}
