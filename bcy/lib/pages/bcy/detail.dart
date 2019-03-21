import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

class BcyDetail extends StatefulWidget{
  
  String _id;
  BcyDetail(String id){
    _id=id;
  }
  @override
  _Detail createState() {
  
    // TODO: implement createState
    return _Detail(_id);
  }

}

class _Detail extends State<BcyDetail>{
  String _id;
  List<Widget> _list=new List<Widget>();
  _Detail(String id){
    _id=id;
  }
  @override
  void initState() {
      // TODO: implement initState
      super.initState();
      getDetail();
    }
  @override
  Widget build(BuildContext context) {
    
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('详情'+_id),
      ),
      body: SingleChildScrollView(
         child:Row(
        children: _list,
      ))
        
      );
  }

  getDetail() async{
    var response=await http.get('https://bcy.net/'+_id);
    setState(() {
          _list.add(
            Text(response.body),
            
          );
        });
    var doms= dom.Document.html(response.body);
    print(response.body);
  }

}