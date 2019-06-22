import 'package:flutter/material.dart';
import 'package:flutter_shop/bean/category_goods_bean_entity.dart';

class CategoryGoodsListProvide with ChangeNotifier {
  List<CategoryGoodsBeanData> CategoryGoodsListData = [];

  getCategoryGoodsList(List<CategoryGoodsBeanData> list) {
    CategoryGoodsListData=list;
    notifyListeners();
  }
  getMoreCategoryGoodsList(List<CategoryGoodsBeanData> list) {
    CategoryGoodsListData.addAll(list);
    notifyListeners();
  }
}
