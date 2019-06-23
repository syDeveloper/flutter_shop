import 'package:flutter/material.dart';
import 'package:flutter_shop/bean/cart_info_entity.dart';
import 'package:flutter_shop/bean/detail_model_entity.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvide with ChangeNotifier {
  String cartString = '[]';
  List<CartInfoEntity> cartList = [];
  double allPrice = 0;
  int allGoodCount = 0;
  bool isAllCheck = true;

  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    cartString = sharedPreferences.getString("cartInfo");
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    allGoodCount = 0;
    allPrice = 0;

    List<Map> tempList = (temp as List).cast();
    bool isHave = false;
    int ival = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        ++tempList[ival]['count'];
        ++cartList[ival].count;
        isHave = true;
      }
      if (item['isCheck']) {
        allPrice += (cartList[ival].price * cartList[ival].count);
        allGoodCount += (cartList[ival].count);
      }
      ival++;
    });

    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
        'isCheck': true,
      };
      cartList.add(CartInfoEntity.fromJson(newGoods));
      tempList.add(newGoods);

      allPrice += (count * price);
      allGoodCount += count;
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
      isAllCheck = true;
      allGoodCount = 0;
      allPrice = 0;
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      tempList.forEach((item) {
        if (item['isCheck']) {
          allPrice += (item['count'] * item['price']);
          allGoodCount += item['count'];
        } else {
          isAllCheck = false;
        }
        cartList.add(CartInfoEntity.fromJson(item));
      });
    }
    notifyListeners();
  }

  deleteGood(String goodId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    cartString = sharedPreferences.getString('cartInfo');

    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int delIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodId) {
        delIndex = tempIndex;
      }
      tempIndex++;
    });

    tempList.removeAt(delIndex);
    cartString = json.encode(tempList).toString();
    sharedPreferences.setString('cartInfo', cartString);
    getCartInfo();
  }

  changCheckState(CartInfoEntity cartItem) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    cartString = sharedPreferences.getString('cartInfo');

    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    sharedPreferences.setString("cartInfo", cartString);
    getCartInfo();
  }

  changeAllCheck(bool isCheck) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    cartString = sharedPreferences.getString('cartInfo');

    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();

    List<Map> newList = [];
    for (var item in tempList) {
      var newItem = item;
      newItem['isCheck'] = isCheck;
      newList.add(newItem);
    }

    cartString = json.encode(newList).toString();
    sharedPreferences.setString('cartInfo', cartString);
    getCartInfo();
  }

  addOrReduceAction(var cartItem, String todo) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    cartString = sharedPreferences.getString('cartInfo');

    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    if (todo == 'add') {
      cartItem.count++;
    } else if (cartItem.count > 1) {
      cartItem.count--;
    }

    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    sharedPreferences.setString("cartInfo", cartString);
    getCartInfo();
  }
}
