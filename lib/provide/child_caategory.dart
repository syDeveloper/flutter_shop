import 'package:flutter/material.dart';
import 'package:flutter_shop/bean/category_bean_entity.dart';

class ChildCategory with ChangeNotifier {
  List<CategoryBeanDataBxmallsubdto> childCategoryList = [];

  getChildCategory(List<CategoryBeanDataBxmallsubdto> list) {
    CategoryBeanDataBxmallsubdto all = CategoryBeanDataBxmallsubdto(
        mallSubId: '00',
        mallCategoryId: '00',
        comments: 'null',
        mallSubName: '全部');
    childCategoryList = [all];

    childCategoryList.addAll(list);
    notifyListeners();
  }
}
