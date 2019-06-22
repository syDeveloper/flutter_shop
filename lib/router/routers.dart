import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:flutter_shop/router/router_handler.dart';

class Routers {
  static String root = '/root';
  static String detailsPage = '/detail';

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("error!route not found!");
    });
    router.define(detailsPage, handler: detailsHandler);
  }
}
