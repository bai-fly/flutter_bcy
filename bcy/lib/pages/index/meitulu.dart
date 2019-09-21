import 'dart:convert';

import 'package:bcy/entity/KeyValue.dart';
import 'package:bcy/pages/photoView/photoList.dart';
import 'package:bcy/utils/database/imageListDb.dart';
import 'package:bcy/utils/router.dart';
import 'package:bcy/utils/toast.dart';
import 'package:bcy/widgets/IndexListViewItem.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

import 'index.dart';
//import 'detail.dart';

class MeiTuLu extends ShowMoreWidget {
  _MeiTuLu _meiTuLu;

  @override
  _MeiTuLu createState() {
    // TODO: implement createState
    this._meiTuLu = _MeiTuLu();
    return _meiTuLu;
  }

  @override
  showMore() {
    _meiTuLu.showMore();
  }
}

class _MeiTuLu extends State<MeiTuLu> with AutomaticKeepAliveClientMixin {
  String text = "";
  int index = 1;
  bool finish = false;
  bool _showMore = false;
  String _url = '';
  String _doman = 'https://www.meitulu.com';
  bool _loading=false;//加载状态
  List<KeyValue> category = //new List();
  [
    KeyValue('女神', 'https://www.meitulu.com/t/nvshen/'),
    KeyValue('极品', 'https://www.meitulu.com/t/jipin/'),
    KeyValue('嫩模', 'https://www.meitulu.com/t/nenmo/'),
    KeyValue('网红', 'https://www.meitulu.com/t/wangluohongren/'),
    KeyValue('风俗娘', 'https://www.meitulu.com/t/fengsuniang/'),
    KeyValue('气质', 'https://www.meitulu.com/t/qizhi/'),
    KeyValue('尤物', 'https://www.meitulu.com/t/youwu/'),
    KeyValue('爆乳', 'https://www.meitulu.com/t/baoru/'),
    KeyValue('性感', 'https://www.meitulu.com/t/xinggan/'),
    KeyValue('诱惑', 'https://www.meitulu.com/t/youhuo/'),
    KeyValue('美胸', 'https://www.meitulu.com/t/meixiong/'),
    KeyValue('少妇', 'https://www.meitulu.com/t/shaofu/'),
    KeyValue('长腿', 'https://www.meitulu.com/t/changtui/'),
    KeyValue('萌妹子', 'https://www.meitulu.com/t/mengmeizi/'),
    KeyValue('萝莉', 'https://www.meitulu.com/t/loli/'),
    KeyValue('可爱', 'https://www.meitulu.com/t/keai/'),
    KeyValue('户外', 'https://www.meitulu.com/t/huwai/'),
    KeyValue('比基尼', 'https://www.meitulu.com/t/bijini/'),
    KeyValue('清纯', 'https://www.meitulu.com/t/qingchun/'),
    KeyValue('唯美', 'https://www.meitulu.com/t/weimei/'),
    KeyValue('清新', 'https://www.meitulu.com/t/qingxin/'),
  ];

  List<Widget> categoryWidget = new List();
  var data = new List<IndexListViewItem>();

  @override
  initState() {
    super.initState();

    
    // var response = await http.get(_doman);
    //   var decode = new Utf8Decoder();
    //   var html = decode.convert(response.bodyBytes);
    //   var doms = dom.Document.html(html);
    //   var ul = doms.getElementsByClassName('tag_ul');
    //   var list = ul[0].getElementsByTagName('a');
    //   for (var item in list) {
    //     category.add(KeyValue(item.text,item.attributes['href']));
    //   }
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
  //@override
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
        print('美图网加载数据库数据成功,数量' + imageList.length.toString());
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
      data = new List<IndexListViewItem>();
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
    var div = doms.getElementsByClassName('boxs')[0];
   
    var list = div.getElementsByTagName('li');

    var imgs = new List<IndexListViewItem>();
    for (int i = 0; i < list.length; i++) {
      var item = list[i];
      String id = '';
      String userImg = item.getElementsByTagName('img')[0]?.attributes['src'];
      String cover = userImg;

      String url = item.getElementsByTagName('a')[0]?.attributes['href'];

      String userName = item.getElementsByTagName('img')[0]?.attributes['alt'];
      
      imgs.add(new IndexListViewItem(
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
