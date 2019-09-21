import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../widgets/MyAppBar.dart';
import 'quantuwang.dart';
import 'meitulu.dart';
import 'qyll.dart';
abstract class ShowMoreWidget extends StatefulWidget{
  showMore();
}
class Index extends StatefulWidget{
  @override
  _Bcy createState() {
    return _Bcy();
  }

}
class _Bcy extends State<Index>{
  int _bootomIndex=0;
    List _titles=["全图网","美图录","7106"];
    List<ShowMoreWidget> _bodys=[
      QuanTuWang(),
      MeiTuLu(),
      Qyll(),
    ];
@override
void initState() {
    // TODO: implement initState
    super.initState();
    var permission =  PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
    if (permission != PermissionStatus.granted) {
      PermissionHandler().requestPermissions(<PermissionGroup>[
        PermissionGroup.storage, // 在这里添加需要的权限
      ]);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    //_showBody=_bodys[0];
    return Scaffold(
      appBar: MyAppBar(
        null,
        _titles[_bootomIndex],
        //FlatButton(child: Text('半次元',style: TextStyle(color: Colors.white),),onPressed: (){

        //},)
        FlatButton(child: Icon(Icons.more_horiz,color: Colors.white,),onPressed: (){
            _bodys[_bootomIndex].showMore();
        })
      ),
      //body: _bodys[_bootomIndex],
      body:IndexedStack(
        children: _bodys,
        index: _bootomIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        key: ObjectKey('$_bootomIndex'),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.hot_tub), title: Text(_titles[0])),
          BottomNavigationBarItem(icon: Icon(Icons.border_top), title: Text(_titles[1])),
          BottomNavigationBarItem(icon: Icon(Icons.school), title: Text(_titles[2])),
          // BottomNavigationBarItem(icon: Icon(Icons.new_releases), title: Text(_titles[3])),
          // BottomNavigationBarItem(icon: Icon(Icons.school), title: Text(_titles[4])),
        ],
        currentIndex: _bootomIndex,
        //fixedColor: Colors.deepPurple,
        onTap: (index){
          setState(() {
            _bootomIndex=index;
          });
        },
      ),
    );
  }
}