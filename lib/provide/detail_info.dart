import 'package:flutter/material.dart';
import 'package:flutter_shop/bean/detail_model_entity.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'dart:convert';

class DetailsInfoProvide with ChangeNotifier {
  DetailModelEntity goodsInfo = null;

  getGoodsInfo(String id) {
    var formData = {'goodId': id};
    request('getGoodDetailById', formData: formData).then((val) {
      var responseData = json.decode(val.toString());
      goodsInfo =  DetailModelEntity.fromJson(responseData);

      notifyListeners();
    });
  }
}
