import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/bean/cart_info_entity.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:provide/provide.dart';

class CartCount extends StatelessWidget {
  var item;

  CartCount(this.item);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: ScreenUtil().setWidth(165),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Row(
        children: <Widget>[
          _reduceBtn(context),
          _countItem(),
          _addBtn(context),
        ],
      ),
    );
  }

  Widget _reduceBtn(context) {
    return InkWell(
      onTap: () {
        Provide.value<CartProvide>(context).addOrReduceAction(item, 'reduce');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: item.count > 1 ? Colors.white : Colors.black12,
            border: Border(right: BorderSide(color: Colors.black12, width: 1))),
        child: item.count > 1 ? Text('-') : Text(""),
      ),
    );
  }

  Widget _addBtn(context) {
    return InkWell(
      onTap: () {
        Provide.value<CartProvide>(context).addOrReduceAction(item, 'add');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(left: BorderSide(color: Colors.black12, width: 1))),
        child: Text('+'),
      ),
    );
  }

  Widget _countItem() {
    return Container(
      height: ScreenUtil().setHeight(45),
      width: ScreenUtil().setWidth(70),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text("${item.count}"),
    );
  }
}
