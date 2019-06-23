import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_shop/pages/detail_page/detail_bottom.dart';
import 'package:flutter_shop/pages/detail_page/detail_explain.dart';
import 'package:flutter_shop/pages/detail_page/detail_tabbar.dart';
import 'package:flutter_shop/pages/detail_page/detail_web.dart';
import 'package:flutter_shop/provide/detail_info.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/pages/detail_page/detail_top_area.dart';

class DetailsPage extends StatelessWidget {
  String goodsId;

  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _getGoodsDetailInfo(context);
    return Scaffold(
      appBar: AppBar(leading: IconButton(
          icon: Icon(Icons.arrow_back), onPressed: (){
        Navigator.pop(context);
      }),
      title:Text("商品详情"),
      ),

      body: FutureBuilder(
          future: _getGoodsDetailInfo(context),
          builder: (context,snapshot){
        if(snapshot.hasData){
          return Stack(
            children: <Widget>[
              Container(
                child: ListView(
                  children: <Widget>[
                    DetailTopArea(),
                    DetailExplain(),
                    DetailTabBar(),
                    DetailWeb(),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child:DetailBottom(),
              ),
            ],
          );
        }else{
          return Text("loading");
        }

      }),
    );
  }

  Future _getGoodsDetailInfo(BuildContext context) async {
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodsId);

    return '完成加载';
  }
}
