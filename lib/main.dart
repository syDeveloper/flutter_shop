import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/index_page.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:flutter_shop/provide/category_goods_list_provide.dart';
import 'package:flutter_shop/provide/detail_info.dart';
import 'package:flutter_shop/router/routers.dart';

import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:flutter_shop/provide/counter.dart';

import 'package:fluro/fluro.dart';
import 'package:flutter_shop/router/application.dart';

void main() {
  var counter = Counter();
  var childCategory = ChildCategory();
  var categoryGoodsListProvide = CategoryGoodsListProvide();
  var detailInfoProvide = DetailsInfoProvide();
  var cartProvide = CartProvide();

  var providers = Providers();

  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<ChildCategory>.value(childCategory))
    ..provide(
        Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))
    ..provide(Provider<DetailsInfoProvide>.value(detailInfoProvide))
    ..provide(Provider<CartProvide>.value(cartProvide));

  runApp(ProviderNode(
    child: MyApp(),
    providers: providers,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routers.configureRoutes(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
        title: "百姓生活P",

        onGenerateRoute: Application.router.generator,

        //去除右上角debug
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.pink),
        home: IndexPage(),
      ),
    );
  }
}
