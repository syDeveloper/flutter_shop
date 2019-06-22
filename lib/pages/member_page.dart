import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/counter.dart';
import 'package:provide/provide.dart';
class MemberPage extends  StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MemberPageState();
  }

}

class _MemberPageState extends State<MemberPage>{



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 210),
      child: Provide<Counter>  (
          builder: (context,child,counter){
            return Text('${counter.value}',style: Theme.of(context).textTheme.display1,);
          }
      ) ,
    );
  }
}