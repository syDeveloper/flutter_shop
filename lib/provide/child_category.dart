import 'package:flutter/material.dart';
import 'package:flutter_shop/bean/category_bean_entity.dart';

class ChildCategory with ChangeNotifier {
  List<CategoryBeanDataBxmallsubdto> childCategoryList = [];
  int childIndex = 0; //二级菜单索引
  String categoryId = "4"; //大类id默认白酒为4
  String subId = ""; //二级菜单小类id
  int page = 1;
  String noMoreText = ''; //没有数据显示文字

  getChildCategory(List<CategoryBeanDataBxmallsubdto> list, String id) {
    page = 1;
    noMoreText = '';
    categoryId = id;
    childIndex = 0; //每次点击大类把二级菜单索引设为0
    CategoryBeanDataBxmallsubdto all = CategoryBeanDataBxmallsubdto(
        mallSubId: '',
        mallCategoryId: '00',
        comments: 'null',
        mallSubName: '全部');
    childCategoryList = [all];

    childCategoryList.addAll(list);
    notifyListeners();
  }

  //修改二级菜单索引
  changeChildIndex(index, String id) {
    page = 1;
    noMoreText = '';
    childIndex = index;
    subId = id;
    notifyListeners();
  }

  //下拉page++
  pageAdd() {
    page++;
  }

  changeNoMoreText(String text) {
    noMoreText = text;
    notifyListeners();
  }
}
