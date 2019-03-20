import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom_parsing.dart' as html;
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
  //var data=new List<ListViewItem>();
  var data=new List<ListViewItem>();
  
  @override
  void initState() {
      
      super.initState();
      getData();
  //     data.add(Image.network('https://img-bcy-qn.pstatp.com/Public/Upload/avatar/34485/6b5c7bcb5d2e4cf98fd7c5b32aa6cc0f/fat.jpg/amiddle'));
  // data.add(Image.network('https://p9-bcy.byteimg.com/img/banciyuan/user/297545/item/web/c0js0/2fe07950d73c11e8a2bfeb0b909f375a.jpg~tplv-banciyuan-2X3.jpg'));
  // data.add(Image.network('https://p1-bcy.byteimg.com/img/banciyuan/user/48093/item/web/c0jrw/75596730d46c11e8ae27770c6c575fb3.jpg~tplv-banciyuan-2X3.jpg'));
  // data.add(Image.network('https://p9-bcy.byteimg.com/img/banciyuan/user/1318806/item/c0je1/vqemm6ms2ldmchbvknc8zgyxmugey7tt.jpg~tplv-banciyuan-2X3.jpg'));
  // data.add(Image.network('https://p1-bcy.byteimg.com/img/banciyuan/user/54105/item/c0juy/dwf01s0seghwqugiky97gcudxg0id2y2.jpg~tplv-banciyuan-2X3.jpg'));
    }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // if(data.length==0){
    //   getData(this);
    // }
    return
        //  RaisedButton(child: Text("获取数据"),
        // onPressed: (){
        //   getData(this);
        // },);
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
    // GridView.count(
    //       primary: false,
    //       padding: const EdgeInsets.all(10.0),
    //       //crossAxisSpacing: 10.0,
    //       crossAxisCount: 2,
    //       children:data,
    //     );
    
  }
  getData() async{
    var response=await http.get('https://bcy.net/circle/timeline/showtag?since='+(data.length==0?'':data[data.length-1].id)+'&grid_type=flow&sort=hot&tag_id=399');
    //var response= await http.get('https://bcy.net/circle/timeline/showtag?since=&grid_type=flow&sort=hot&tag_id=399');
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
  getData1(_HotBCY w){
    http.get('https://bcy.net/circle/timeline/showtag?since=&grid_type=flow&sort=hot&tag_id=399')
    //http.get('https://bcy.net/circle/timeline/showtag?since='+(w.data.length==0?'':w.data[w.data.length-1].id)+'&grid_type=flow&sort=hot&tag_id=399')
    .then((response){
      var doms= dom.Document.html(response.body);
  
      var list= doms.getElementsByClassName('js-smallCards');
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

        //w.data.add(Image.network(cover));
        // w.data.add(new ListViewItem(
        //   id,
        //   userImg,
        //   userName,
        //   cover
        // ));
        w.setState((){
          
        });
      }
      
    });
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