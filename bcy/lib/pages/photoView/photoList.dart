import 'dart:io';
import 'dart:typed_data';

import 'package:bcy/utils/router.dart';
import 'package:bcy/utils/toast.dart';
import 'package:bcy/widgets/MyAppBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:http/http.dart' as http;
//import 'package:photo_view/photo_view.dart';
//import 'package:demo/pages/CRM/PhotoGalleryPage.dart'; //放大页面
class PhotoList  extends StatefulWidget{
  List<String> _list;
  PhotoList({List<String> list}){
    if(list!=null){
      this._list=list;  
    }else{
      this._list=new List();
      this._list.add('https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2174909441,2495215020&fm=26&gp=0.jpg');
      this._list.add('https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3987907653,720009510&fm=26&gp=0.jpg');
      this._list.add('https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3357786243,3135716437&fm=26&gp=0.jpg');
    }
    
  }


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PhotoList(_list);
  }
  
}

class _PhotoList extends State<PhotoList> {
  String _title;
  int _total;
  List<String> _list;
  List<ImageProvider> _imgProvider= new List();
  int _index=0;
  _PhotoList(List<String> list){
    _list=list;
    for(var item in _list){
        _imgProvider.add(new CachedNetworkImageProvider(item));
    }
    _total=list.length;
    _title='1/$_total';

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
          appBar: MyAppBar( 
            IconButton(icon: Icon(Icons.arrow_back),
                onPressed: (){
                  MyRouter.pop(context);
                },),
              _title,
            FlatButton(
              child: Icon(Icons.file_download,color: Colors.white,),
              onPressed: () async {
                 
                 PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
                 if (permission == PermissionStatus.granted) {
                   print(_list[_index]); 

                    var img = await http.get(_list[_index]);
                                  
                
                    
                    var time = DateTime.now().millisecondsSinceEpoch.toInt();
                    //var filePath = '/bcy/$time'+_list[_index].substring(_list[_index].lastIndexOf('.'));


                    var bytes = img.bodyBytes;


                    // Uint8List bytes = 
                    final result = await ImageGallerySaver.saveImage(bytes);
                    
                    if(result!=null){
                        Toast.toast(context,msg:'保存成功:$result');
                    }else{
                        Toast.toast(context,msg:'保存失败');
                    }
                  } else {

                      Toast.toast(context,msg:'暂无储权限');
                  }
              },
            )
            ),
          body: PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider:  _imgProvider[index],
                    //imageProvider:NetworkImage(_list[index]),
                    initialScale: PhotoViewComputedScale.contained * 1,
                    minScale: PhotoViewComputedScale.contained * 1,
                    maxScale: PhotoViewComputedScale.covered * 10,
                    heroAttributes: PhotoViewHeroAttributes(tag: index),
                  );
                },
                itemCount: _list.length,
            //loadingChild: widget.loadingChild,
            backgroundDecoration: BoxDecoration(
              color: Colors.black,
            ),
            //pageController: pageController,
            onPageChanged: (index){
              _index=index;
              index++;
              setState(() {
                        _title='$index/$_total';
              });
            },
          )
        );
  }

  
}