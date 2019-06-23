import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/bean/cart_info_entity.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:provide/provide.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: EdgeInsets.all(5),
        color: Colors.white,
        child: Provide<CartProvide>(builder: (context, child, val) {
          return Row(
            children: <Widget>[
              selectAllBtn(context),
              allPriceArea(context),
              goButton(context),
            ],
          );
        }));
  }

  Widget selectAllBtn(context) {

    bool isAllCheck=Provide.value<CartProvide>(context).isAllCheck;
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: isAllCheck,
            activeColor: Colors.pink,
            onChanged: (bool val) {
              Provide.value<CartProvide>(context).changeAllCheck(val);
            },
          ),
          Text('全选'),
        ],
      ),
    );
  }

  Widget allPriceArea(context) {
    double allPrice = Provide.value<CartProvide>(context).allPrice;
    return Container(
      width: ScreenUtil().setWidth(430),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(280),
                child: Text(
                  "合计",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(36),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: ScreenUtil().setWidth(150),
                child: Text(
                  "¥${allPrice}",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(36),
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(430),
            alignment: Alignment.centerRight,
            child: Text(
              "满10元免配送费，预购免配送费",
              style: TextStyle(
                  color: Colors.black38, fontSize: ScreenUtil().setSp(22)),
            ),
          ),
        ],
      ),
    );
  }

  Widget goButton(context) {
    int allGoodCount = Provide.value<CartProvide>(context).allGoodCount;

    return Container(
      width: ScreenUtil().setWidth(160),
      padding: EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Text(
            "结算(${allGoodCount})",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
