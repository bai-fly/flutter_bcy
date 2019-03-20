import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
class HotBCY extends StatefulWidget{
  
  @override
  _HotBCY createState() {
    // TODO: implement createState
    return _HotBCY();
  }

}
class _HotBCY extends State<HotBCY>{
  String text="";
  var data=new List<ListViewItem>();
  
  @override
  void initState() {
      
      super.initState();
      getData();
    }
  @override
  Widget build(BuildContext context) {
    
    return
        
        GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //每行三列
            childAspectRatio: 1.0 //显示区域宽高相等
          ),
          padding: const EdgeInsets.all(10.0),
          itemCount:data.length,
          itemBuilder: (context, index) {
          //如果显示到最后一个并且Icon总数小于200时继续获取数据
            if ( index > data.length-3) {
             getData();
            }
            return data[index];
          }
        );
  
    
  }
  getData() async{
    var response=await http.get('https://bcy.net/circle/timeline/showtag?since='+(data.length==0?'':data[data.length-1].id)+'&grid_type=flow&sort=hot&tag_id=399');
    var doms= dom.Document.html(response.body);
  
      var list= doms.getElementsByClassName('js-smallCards');
      var imgs=new List<ListViewItem>();
      for(int i=0;i<list.length;i++){
        var item=list[i];
        String id=item.attributes["data-since"].toString();
        String userImg=item.getElementsByClassName('_avatar')[0]?.getElementsByTagName('img')[0]?.attributes['src'];
        String cover="";
        var cardImage=item.getElementsByClassName('cardImage');
        if(cardImage!=null&&cardImage.length>0){
          cover=item.getElementsByClassName('cardImage')[0].attributes['src'];
        }
        String userName=item.getElementsByClassName('username')[0]?.text;
        imgs.add(new ListViewItem(
          id,
          userImg,
          userName,
          cover
        ));
        
      }
      setState(() {
              data.addAll(imgs);
            });
print('数据数量：'+data.length.toString());
  }
 
}

class ListViewItem extends Container{
  String id;
  ListViewItem(String id,String userImg,String userName,String cover):super(
    //child:Image.network(cover)
    child: Card(
        elevation: 4.0,
        child: Column(
          children: <Widget>[
            Image.network(cover),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  userName,
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
                
              ],
            ),
          ],
        ),
      ),
  ){
    
    this.id=id;
  }
}