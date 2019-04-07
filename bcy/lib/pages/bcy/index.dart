import 'package:flutter/material.dart';
import '../../widgets/MyAppBar.dart';
import 'hot.dart';
import 'hotweek.dart';
import 'hottoday.dart';
import 'news.dart';
import 'newscos.dart';
class Index extends StatefulWidget{
  @override
  _Bcy createState() {
    return _Bcy();
  }

}
class _Bcy extends State<Index>{
  int _bootomIndex=0;
    List _titles=["热门推荐","本周热门","今日热门","新人榜","最新COS"];
    List<Widget> _bodys=[
      HotBCY(key: ObjectKey('1'),),
      HotWeekBCY(),
      HotTodayBCY(),
      NewsBCY(),
      NewsCOSBCY()
    ];
  @override
  Widget build(BuildContext context) {
    //_showBody=_bodys[0];
    return Scaffold(
      appBar: MyAppBar(
        null,
        "半次元",
        //FlatButton(child: Text('半次元',style: TextStyle(color: Colors.white),),onPressed: (){

        //},)
        null
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
          BottomNavigationBarItem(icon: Icon(Icons.new_releases), title: Text(_titles[3])),
          BottomNavigationBarItem(icon: Icon(Icons.school), title: Text(_titles[4])),
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