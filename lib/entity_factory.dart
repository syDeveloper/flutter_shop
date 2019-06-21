import 'package:flutter_shop/bean/category_bean_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "CategoryBeanEntity") {
      return CategoryBeanEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}