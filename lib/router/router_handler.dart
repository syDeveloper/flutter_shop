import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/detail_page.dart';
import 'package:flutter_shop/pages/map_page.dart';

Handler detailsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String goodsId = params['id'].first;
  return DetailsPage(goodsId);
});
Handler mapHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return MapFlutterPage();
    });
