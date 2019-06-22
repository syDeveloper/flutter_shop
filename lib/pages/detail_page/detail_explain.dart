import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/detail_info.dart';
import 'package:provide/provide.dart';
import 'package:flutter/material.dart';

class DetailExplain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(10),
      child: Text("说明：> 极速送达 > 正品保证",
          style: TextStyle(
              color: Colors.deepOrange, fontSize: ScreenUtil().setSp(30))),
    );
  }
}
