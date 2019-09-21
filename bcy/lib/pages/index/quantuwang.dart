import 'dart:convert';

import 'package:bcy/entity/KeyValue.dart';
import 'package:bcy/pages/photoView/photoList.dart';
import 'package:bcy/utils/database/imageListDb.dart';
import 'package:bcy/utils/router.dart';
import 'package:bcy/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:cached_network_image/cached_network_image.dart';

import 'index.dart';
//import 'detail.dart';

class QuanTuWang extends ShowMoreWidget {
  _QuanTuWang _quanTuWang;

  @override
  _QuanTuWang createState() {
    // TODO: implement createState
    this._quanTuWang = _QuanTuWang();
    return _quanTuWang;
  }

  @override
  showMore() {
    _quanTuWang.showMore();
  }
}

class _QuanTuWang extends State<QuanTuWang> with AutomaticKeepAliveClientMixin {
  String text = "";
  int index = 1;
  bool finish = false;
  bool _showMore = false;
  String _url = '';
  String _doman = 'http://www.quantuwang.co/';
  bool _loading=false;//加载状态
  List<KeyValue> category = [
    KeyValue('秀人网', 'http://www.quantuwang.co/meinv/xiuren/'),
    KeyValue('美媛馆', 'http://www.quantuwang.co/meinv/mygirl/'),
    KeyValue('模范学院', 'http://www.quantuwang.co/meinv/mfstar/'),
    KeyValue('嗲囡囡', 'http://www.quantuwang.co/meinv/feilin/'),
    KeyValue('花の颜', 'http://www.quantuwang.co/meinv/huayan/'),
    KeyValue('爱蜜社', 'http://www.quantuwang.co/meinv/imiss/'),
    KeyValue("星乐园", "http://www.quantuwang.co/meinv/leyuan/"),
    KeyValue("蜜桃社", "http://www.quantuwang.co/meinv/miitao/"),
    KeyValue("魅妍社", "http://www.quantuwang.co/meinv/mistar/"),
    KeyValue("尤物馆", "http://www.quantuwang.co/meinv/youwu/"),
    KeyValue("顽味生活", "http://www.quantuwang.co/meinv/taste/"),
    KeyValue("兔几盟", "http://www.quantuwang.co/meinv/tukmo/"),
    KeyValue("优星馆", "http://www.quantuwang.co/meinv/uxing/"),
    KeyValue("影私荟", "http://www.quantuwang.co/meinv/wings/"),
    KeyValue("DK御女郎", "http://www.quantuwang.co/meinv/dkgirl/"),
    KeyValue("尤蜜荟", "http://www.quantuwang.co/meinv/youmi/"),
    KeyValue("薄荷叶", "http://www.quantuwang.co/meinv/mintye/"),
    KeyValue("糖果画报", "http://www.quantuwang.co/meinv/candy/"),
    KeyValue("猫萌榜", "http://www.quantuwang.co/meinv/micat/"),
    KeyValue("瑞丝馆", "http://www.quantuwang.co/meinv/ruisg/"),
    KeyValue("星颜社", "http://www.quantuwang.co/meinv/xingyan/"),
    KeyValue("模特联盟", "http://www.quantuwang.co/meinv/mtmeng/"),
    KeyValue("花漾show", "http://www.quantuwang.co/meinv/huayang/"),
    KeyValue("语画界", "http://www.quantuwang.co/meinv/xiaoyu/"),
    KeyValue("波萝社", "http://www.quantuwang.co/meinv/bololi/"),
    KeyValue("激萌文化", "http://www.quantuwang.co/meinv/kimoe/"),
    KeyValue("村长的宝物", "http://www.quantuwang.co/meinv/cuz/"),
    KeyValue("萌缚", "http://www.quantuwang.co/meinv/mf/"),
    KeyValue("尤果网", "http://www.quantuwang.co/meinv/ugirls/"),
    KeyValue("爱尤物", "http://www.quantuwang.co/meinv/ugirlsapp/"),
    KeyValue("轰趴猫", "http://www.quantuwang.co/meinv/partycat/"),
    KeyValue("潘多拉", "http://www.quantuwang.co/meinv/pdlone/"),
    KeyValue("雅拉伊", "http://www.quantuwang.co/meinv/yalayi/"),
    KeyValue("猎女神", "http://www.quantuwang.co/meinv/slady/"),
    KeyValue("尤美网", "http://www.quantuwang.co/meinv/youmei/"),
    KeyValue("阳光宝贝", "http://www.quantuwang.co/meinv/sungirl/"),
    KeyValue("果团网", "http://www.quantuwang.co/meinv/girlt/"),
    KeyValue("风之领域", "http://www.quantuwang.co/meinv/fzly/"),
    KeyValue("MT蜜团", "http://www.quantuwang.co/meinv/mtgirl/"),
    KeyValue("青豆客", "http://www.quantuwang.co/meinv/qingdouke/"),
    KeyValue("推女神", "http://www.quantuwang.co/meinv/tgod/"),
    KeyValue("头条女神", "http://www.quantuwang.co/meinv/toutiaogirls/"),
    KeyValue("ROSI", "http://www.quantuwang.co/meinv/rosi/"),
    KeyValue("ROSI口罩", "http://www.quantuwang.co/meinv/rosikz/"),
    KeyValue("ROSI情趣", "http://www.quantuwang.co/meinv/rosiqq/"),
    KeyValue("ROSI艺学妹", "http://www.quantuwang.co/meinv/rosiyxm/")
  ];

  List<Widget> categoryWidget = new List();
  var data = new List<ListViewItem>();

  @override
  Future initState() {
    super.initState();

    List<Widget> l = new List();
    for (var item in category) {
      l.add(RaisedButton(
        padding: EdgeInsets.all(0),
        child: Text(item.key),
        onPressed: () {
          urlChange(item.key, item.value);
        },
      ));
    }
    _url = category[0].value;
    getData();
    setState(() {
      categoryWidget = l;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, //每行2列
                childAspectRatio: 0.6 //显示区域宽高比
                ),
            padding: const EdgeInsets.all(10.0),
            itemCount: data.length,
            itemBuilder: (context, index) {
              //如果显示到最后一个并且Icon总数小于200时继续获取数据
              if (index > data.length - 3) {
                getData();
              }
              return data[index];
            }),
        Offstage(
          offstage: !this._showMore,
          child: Container(
              // width: 50,
              // height: 50,
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(color: Colors.lightBlue),

              // child: Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  alignment: WrapAlignment.center, //主轴方向上的对齐方式，默认为start。
                  spacing: 0,
                  runSpacing: 0,
                  children: categoryWidget,
                  //children: categoryWidget,
                ),
              )
              //   child: Text('测试'),
              //   // child: Stack(
              //   //   children: <Widget>[
              //   //     Text('测试')
              //   //   ],
              //   //   //children: categoryWidget,
              //   // ),
              // ),
              ),
        ),
      ],
    );
    //return
  }

  init() async {}

  coverClick(url) async {
    if(_loading){
      return;
    }
    _loading=true;
    List<String> imageList;
    try {
      
      String baseUrl = _doman + url;

      var response = await http.get(baseUrl);
      var decode = new Utf8Decoder();
      var html = decode.convert(response.bodyBytes);
      var doms = dom.Document.html(html);
      var page = doms.getElementsByClassName('c_page');
      var list = page[0].getElementsByTagName('a');
      int total = list.length + 1;

      //查询数据库
      var dblist = await ImageListDb.getListByBaseUrl(baseUrl);
      if (dblist.length == total) {
        imageList = dblist;
        print('加载数据库数据成功,数量' + imageList.length.toString());
      } else {
        imageList = new List();

        int count = 1;
        imageList.add(this.getDetailImage(doms)); //第一张图片

        //获取所有页数

        if (page.length > 0) {
          Toast.toast(context, msg: '已解析第 $count/$total 张图片');
          for (var item in list) {
            response = await http.get(_doman + item.attributes['href']);

            var rep = decode.convert(response.bodyBytes);
            var rep_doms = dom.Document.html(rep);
            imageList.add(getDetailImage(rep_doms));
            count++;
            Toast.toast(context, msg: '已解析第 $count/$total 张图片');
          }
          await ImageListDb.addListByBaseUrl(baseUrl, imageList);
        }
      }
    } catch (e) {

    }finally{
      _loading=false;
    }
    MyRouter.pushBuilder(
        context,
        PhotoList(
          list: imageList,
        ));
    // for (var item in imageList) {
    //   print(item);
    // }
  }

  getDetailImage(dom.Document doc) {
    var d = doc.getElementsByClassName('index_left');
    if (d.length > 0) {
      var left = d[0];
      var img_div = left.getElementsByClassName('c_img');
      if (img_div.length > 0) {
        var i_div = img_div[0];
        var img = i_div.getElementsByTagName('img')[0]?.attributes['src'];
        return img;
      }
    }
    return '';
  }

  urlChange(name, url) {
    _url = url;
    finish = false;
    index = 1;
    text = name;

    setState(() {
      _showMore = false;
      data = new List<ListViewItem>();
    });
    this.getData();
  }

  getData() async {
    String url = _url;

    //index_2.html
    if (index > 1) {
      url += 'index_$index.html';
    }
    print(url);
    var response = await http.get(url);
    var decode = new Utf8Decoder();
    var html = decode.convert(response.bodyBytes);
    if (html == '404') {
      this.finish = true;
      print('数据已加载完毕');
      return;
    }
    var doms = dom.Document.html(html);
    var div = doms.getElementsByClassName('index_left')[0];
    print(div.innerHtml);
    var list = div.getElementsByTagName('li');

    var imgs = new List<ListViewItem>();
    for (int i = 0; i < list.length; i++) {
      var item = list[i];
      String id = '';
      String userImg = item.getElementsByTagName('img')[0]?.attributes['src'];
      String cover = item.getElementsByTagName('img')[0]?.attributes['src'];

      String url = item.getElementsByTagName('a')[0]?.attributes['href'];

      String userName = item.getElementsByTagName('a')[0]?.attributes['title'];
      print(url);
      imgs.add(new ListViewItem(
        id,
        userImg,
        userName,
        cover,
        url,
        coverClick,
      ));
    }
    setState(() {
      data.addAll(imgs);
    });
    index++;
    print('数据数量：' + data.length.toString());
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  showMore() {
    setState(() {
      this._showMore = !this._showMore;
    });
  }
}

class ListViewItem extends Container {
  String id;
  String _url;
  ListViewItem(String id, String userImg, String userName, String cover,
      String url, Function(String) onTap)
      : super(
          //child:Image.network(cover)
          child: Card(
            elevation: 4.0,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  child: CachedNetworkImage(
                    imageUrl: cover,
                    placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                  onTap: () {
                    onTap(url);
                    // Navigator.push(context, MaterialPageRoute(
                    //   builder: (context)=>BcyDetail(url)
                    // ));
                  },
                ),
                Text(
                  userName,
                  style:
                      TextStyle(fontSize: 10.0, fontWeight: FontWeight.normal),
                ),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: <Widget>[
                //     Text(
                //       userName,
                //       style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.normal),
                //       maxLines: 3,
                //       //overflow: TextOverflow.ellipsis,
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ) {
    this.id = id;
    _url = url;
  }
}
