import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyRouter{
  static push(BuildContext context,String name){
    Navigator.pushNamed(context, name);
  }
  static pushBuilder(BuildContext context,Widget page){
    Navigator.push(context, MaterialPageRoute(
      builder: (context)=>page
    ));
  }
  static pop<T extends Object>(BuildContext context,[ T result ]){
    Navigator.pop(context,result);
  }
}