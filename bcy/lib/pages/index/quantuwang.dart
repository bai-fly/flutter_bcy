import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
//import 'detail.dart';

class QuanTuWang extends StatefulWidget{
  QuanTuWang({Key key}):super(key:key);
  @override
  _QuanTuWang createState() {
    // TODO: implement createState
    return _QuanTuWang();
  }

}
class _QuanTuWang extends State<QuanTuWang> with AutomaticKeepAliveClientMixin{
  String text="";
  int index=1;
  List category=[
            {"name":"秀人网","url":"http://www.quantuwang.co/meinv/xiuren/"},
            {"name":"美媛馆","url":"http://www.quantuwang.co/meinv/mygirl/"},
            {"name":"模范学院","url":"http://www.quantuwang.co/meinv/mfstar/"},
            {"name":"嗲囡囡","url":"http://www.quantuwang.co/meinv/feilin/"},
            {"name":"花の颜","url":"http://www.quantuwang.co/meinv/huayan/"},
            {"name":"爱蜜社","url":"http://www.quantuwang.co/meinv/imiss/"},
            {"name":"星乐园","url":"http://www.quantuwang.co/meinv/leyuan/"},
            {"name":"蜜桃社","url":"http://www.quantuwang.co/meinv/miitao/"},
            {"name":"魅妍社","url":"http://www.quantuwang.co/meinv/mistar/"},
            {"name":"尤物馆","url":"http://www.quantuwang.co/meinv/youwu/"},
            {"name":"顽味生活","url":"http://www.quantuwang.co/meinv/taste/"},
            {"name":"兔几盟","url":"http://www.quantuwang.co/meinv/tukmo/"},
            {"name":"优星馆","url":"http://www.quantuwang.co/meinv/uxing/"},
            {"name":"影私荟","url":"http://www.quantuwang.co/meinv/wings/"},
            {"name":"DK御女郎","url":"http://www.quantuwang.co/meinv/dkgirl/"},
            {"name":"尤蜜荟","url":"http://www.quantuwang.co/meinv/youmi/"},
            {"name":"薄荷叶","url":"http://www.quantuwang.co/meinv/mintye/"},
            {"name":"糖果画报","url":"http://www.quantuwang.co/meinv/candy/"},
            {"name":"猫萌榜","url":"http://www.quantuwang.co/meinv/micat/"},
            {"name":"瑞丝馆","url":"http://www.quantuwang.co/meinv/ruisg/"},
            {"name":"星颜社","url":"http://www.quantuwang.co/meinv/xingyan/"},
            {"name":"模特联盟","url":"http://www.quantuwang.co/meinv/mtmeng/"},
            {"name":"花漾show","url":"http://www.quantuwang.co/meinv/huayang/"},
            {"name":"语画界","url":"http://www.quantuwang.co/meinv/xiaoyu/"},
            {"name":"波萝社","url":"http://www.quantuwang.co/meinv/bololi/"},
            {"name":"激萌文化","url":"http://www.quantuwang.co/meinv/kimoe/"},
            {"name":"村长的宝物","url":"http://www.quantuwang.co/meinv/cuz/"},
            {"name":"萌缚","url":"http://www.quantuwang.co/meinv/mf/"},
            {"name":"尤果网","url":"http://www.quantuwang.co/meinv/ugirls/"},
            {"name":"爱尤物","url":"http://www.quantuwang.co/meinv/ugirlsapp/"},
            {"name":"轰趴猫","url":"http://www.quantuwang.co/meinv/partycat/"},
            {"name":"潘多拉","url":"http://www.quantuwang.co/meinv/pdlone/"},
            {"name":"雅拉伊","url":"http://www.quantuwang.co/meinv/yalayi/"},
            {"name":"猎女神","url":"http://www.quantuwang.co/meinv/slady/"},
            {"name":"尤美网","url":"http://www.quantuwang.co/meinv/youmei/"},
            {"name":"阳光宝贝","url":"http://www.quantuwang.co/meinv/sungirl/"},
            {"name":"果团网","url":"http://www.quantuwang.co/meinv/girlt/"},
            {"name":"风之领域","url":"http://www.quantuwang.co/meinv/fzly/"},
            {"name":"MT蜜团","url":"http://www.quantuwang.co/meinv/mtgirl/"},
            {"name":"青豆客","url":"http://www.quantuwang.co/meinv/qingdouke/"},
            {"name":"推女神","url":"http://www.quantuwang.co/meinv/tgod/"},
            {"name":"头条女神","url":"http://www.quantuwang.co/meinv/toutiaogirls/"},
            {"name":"ROSI","url":"http://www.quantuwang.co/meinv/rosi/"},
            {"name":"ROSI口罩","url":"http://www.quantuwang.co/meinv/rosikz/"},
            {"name":"ROSI情趣","url":"http://www.quantuwang.co/meinv/rosiqq/"},
            {"name":"ROSI艺学妹","url":"http://www.quantuwang.co/meinv/rosiyxm/"}
  ];


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
            crossAxisCount: 3, //每行2列
            childAspectRatio: 0.6 //显示区域宽高比
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
  init() async{

  }
  getData() async{
    String url='http://www.quantuwang.co/meinv/xiuren/';

    //index_2.html
    if(index>1){
      url+='index_$index.html';
    }
    print(url);
    var response=await http.get(url);
    var doms= dom.Document.html(response.body);
    var div = doms.getElementsByClassName('index_left')[0];
    print(div.innerHtml);
    var list = div.getElementsByTagName('li');
    

      var imgs=new List<ListViewItem>();
      for(int i=0;i<list.length;i++){
        var item=list[i];
        print(item);
        String id='';
        String userImg=item.getElementsByTagName('img')[0]?.attributes['src'];
        String cover=item.getElementsByTagName('img')[0]?.attributes['src'];
        
        
        String url=item.getElementsByTagName('a')[0]?.attributes['href'];
        
        String userName=item.getElementsByTagName('a')[0]?.attributes['title'];
        imgs.add(new ListViewItem(
          this.context,
          id,
          userImg,
          userName,
          cover,
          url
        ));
        
      }
      setState(() {
              data.addAll(imgs);
            });
        index++;
        print('数据数量：'+data.length.toString());
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

 
}

class ListViewItem extends Container{
  String id;
  String _url;
  ListViewItem(BuildContext context,String id,String userImg,String userName,String cover,String url):super(
    //child:Image.network(cover)
    child: Card(
        elevation: 4.0,
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Image.network(cover),
              onTap: (){
                
                // Navigator.push(context, MaterialPageRoute(
                //   builder: (context)=>BcyDetail(url)
                // ));
              },
            ),
            
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  userName,
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
                  overflow: TextOverflow.ellipsis,
                ),
                
              ],
            ),
          ],
        ),
      ),
  ){
    this.id=id;
    _url=url;
  }
}