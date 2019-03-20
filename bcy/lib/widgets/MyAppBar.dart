import 'package:flutter/material.dart';
class MyAppBar extends AppBar{
  MyAppBar(IconButton left,String title,FlatButton right)
  :super(
    leading:left,
    title:Text(title),
    centerTitle:true,
    actions:right==null?null:[right]
  );
}