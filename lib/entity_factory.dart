import 'package:flutter_shop/bean/cart_info_entity.dart';
import 'package:flutter_shop/bean/category_goods_bean_entity.dart';
import 'package:flutter_shop/bean/category_bean_entity.dart';
import 'package:flutter_shop/bean/detail_model_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "CartInfoEntity") {
      return CartInfoEntity.fromJson(json) as T;
    } else if (T.toString() == "CategoryGoodsBeanEntity") {
      return CategoryGoodsBeanEntity.fromJson(json) as T;
    } else if (T.toString() == "CategoryBeanEntity") {
      return CategoryBeanEntity.fromJson(json) as T;
    } else if (T.toString() == "DetailModelEntity") {
      return DetailModelEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}