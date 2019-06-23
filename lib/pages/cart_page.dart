import 'package:flutter/material.dart';
import 'package:flutter_shop/bean/cart_info_entity.dart';
import 'package:flutter_shop/pages/cart_pages/cart_bottom.dart';
import 'package:flutter_shop/pages/cart_pages/cart_item.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:flutter_shop/provide/counter.dart';
import 'package:provide/provide.dart';
import 'package:flutter/cupertino.dart';

class CartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CartPageState();
  }
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("购物车"),
      ),
      body: FutureBuilder(
          future: _getCartInfo(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<CartInfoEntity> cartList =
                  Provide.value<CartProvide>(context).cartList;

              return Stack(
                children: <Widget>[
                  Provide<CartProvide>(
                    builder: (context, child, data) {
                      cartList = Provide.value<CartProvide>(context).cartList;
                      return ListView.builder(
                        itemCount: cartList.length,
                        itemBuilder: (context, index) {
                          return CartItem(cartList[index]);
                        },
                      );
                    },
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: CartBottom(),
                  ),
                ],
              );
            } else {
              return Text("loading...");
            }
          }),
    );
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfo();
    return "end";
  }
}
