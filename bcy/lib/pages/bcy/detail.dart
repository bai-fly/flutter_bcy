import 'package:bcy/widgets/MyAppBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import '../../widgets/WebView.dart';
import '../../utils/router.dart';

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
    print("详情url:"+'https://bcy.net'+_id);
  }
  // @override
  // void initState() {
  //     // TODO: implement initState
  //     super.initState();
  //     getDetail();
  //   }
  @override
  Widget build(BuildContext context) {
    return WebView('https://bcy.net'+_id,
    appBar: MyAppBar(
      IconButton(icon: Icon(Icons.arrow_back),
      onPressed: toBack,),
      '详情',
      null
    ),
    );
    // TODO: implement build
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('详情'+_id),
    //   ),
    //   body: SingleChildScrollView(
    //      child:Row(
    //     children: _list,
    //   ))
        
    //   );
  }
  toBack(){
    MyRouter.pop(this.context);
  }
  getDetail() async{
    print('url:'+'https://bcy.net/'+_id);
    var response=await http.get('https://bcy.net/'+_id);
    // setState(() {
    //       _list.add(
    //         Text(response.body),
            
    //       );
    //     });
    print(response.body);
    var doms= dom.Document.html(response.body);
    var list= doms.getElementsByClassName('img-wrap-inner');
    var urls=new List<String>();
    for(var item in list){
      var imgs=item.getElementsByTagName('img');
      if(imgs!=null&&imgs.length>0){
        urls.add(imgs[0].attributes['src']);
        print(imgs[0].attributes['src']);
      }
    }
    
  }

}