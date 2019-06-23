import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/bean/cart_info_entity.dart';
import 'package:flutter_shop/pages/cart_pages/cart_count.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:provide/provide.dart';

class CartItem extends StatelessWidget {
  CartInfoEntity cartInfoEntity;

  CartItem(this.cartInfoEntity);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.fromLTRB(5, 2, 5, 2),
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black12),
        ),
      ),
      child: Row(
        children: <Widget>[
          _cartCheckBtn(context, cartInfoEntity),
          _cartImage(cartInfoEntity),
          _cartGoodsName(cartInfoEntity),
          _cartPrice(context, cartInfoEntity),
        ],
      ),
    );
  }

  Widget _cartCheckBtn(context, item) {
    return Container(
      child: Checkbox(
        value: item.isCheck,
        onChanged: (bool val) {
          item.isCheck = val;
          Provide.value<CartProvide>(context).changCheckState(item);
        },
        activeColor: Colors.pink,
      ),
    );
  }

  Widget _cartImage(item) {
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Image.network(item.images),
    );
  }

  Widget _cartGoodsName(item) {
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[Text(item.goodsName), CartCount(item)],
      ),
    );
  }

  Widget _cartPrice(context, item) {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('¥${item.price}'),
          Container(
            child: InkWell(
              onTap: () {
                //删除
                Provide.value<CartProvide>(context).deleteGood(item.goodsId);
              },
              child: Icon(
                Icons.delete_forever,
                color: Colors.black26,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
