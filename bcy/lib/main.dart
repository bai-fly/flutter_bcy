import 'package:flutter/material.dart';
//import 'index.dart';
import 'pages/bcy.dart';
import 'pages/bcy/detail.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Bcy(),
      routes: <String, WidgetBuilder>{
        '/bcyDetail': (BuildContext context) => BcyDetail('id'),
      },
    );
  }
}

class Test extends StatelessWidget{
  String text="测试";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Row(
        children: <Widget>[
          Text(text),
          RaisedButton(
            child: Text("测试"),
            onPressed: (){
AlertDialog(
  title: Text('弹窗'),
);
            },
          )
        ],
      ),
    );
  }
  

}