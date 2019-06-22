import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/index_page.dart';

import 'package:provide/provide.dart';
import 'package:flutter_shop/provide/child_caategory.dart';
import 'package:flutter_shop/provide/counter.dart';

void main() {
  var counter = Counter();
  var childCategory = ChildCategory();
  var providers = Providers();

  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(Provider<ChildCategory>.value(childCategory));

  runApp(ProviderNode(
    child: MyApp(),
    providers: providers,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: "百姓生活P",
        //去除右上角debug
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.pink),
        home: IndexPage(),
      ),
    );
  }
}
