import 'package:flutter/material.dart';
import 'package:flutter_shop/bean/cart_info_entity.dart';
import 'package:flutter_shop/bean/detail_model_entity.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvide with ChangeNotifier {
  String cartString = '[]';
  List<CartInfoEntity> cartList = [];

  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    cartString = sharedPreferences.getString("cartInfo");
    var temp = cartString == null ? [] : json.decode(cartString.toString());

    List<Map> tempList = (temp as List).cast();
    bool isHave = false;
    int ival = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList[ival]['count']++;
        cartList[ival].count++;
        isHave = true;
      }
      ival++;
    });

    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images
      };
      cartList.add(CartInfoEntity.fromJson(newGoods));
      tempList.add(newGoods);
    }

    cartString = json.encode(tempList).toString();
    print("cartString:" + cartString);
    sharedPreferences.setString('cartInfo', cartString);
    notifyListeners();
  }

  remove() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('cartInfo');
    cartList = [];
    print('清除cartString完成');
    notifyListeners();
  }

  getCartInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    cartString = sharedPreferences.getString('cartInfo');
    cartList = [];
    if (cartString == null) {
      cartList = [];
    } else {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      tempList.forEach((item){
        cartList.add(CartInfoEntity.fromJson(item));
      });
    }
    notifyListeners();
  }
}
