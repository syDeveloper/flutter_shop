import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_shop/config/service_url.dart';

//首页内容
Future getHomePageContent() async {
//  var formData = {'lon': '120.867953', 'lat': '32.030336'};
//  request(servicePath['homePageContent'], formData);
//
//
  try {
    print("http start");
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    var formData = {'lon': '120.867953', 'lat': '32.030336'};
    response = await dio.post(servicePath['homePageContent'], data: formData);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('home page error');
    }
  } catch (e) {
    print("error:" + e.toString());
  }
}

//首页火爆专区
Future getHomePageBelowConten() async {
  try {
    print("http start");
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    int page = 1;
    response = await dio.post(servicePath['homePageBelowConten'], data: page);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('home page error');
    }
  } catch (e) {
    print("error:" + e.toString());
  }
}

Future request(url, {formData}) async {
  try {
    print("http start");
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(url+":"+response.data.toString());
      return response.data;
    } else {
      throw Exception('home page error');
    }
  } catch (e) {
    print("error:" + e.toString());
  }
}
