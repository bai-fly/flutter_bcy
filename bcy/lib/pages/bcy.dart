import 'package:flutter/material.dart';
import '../widgets/MyAppBar.dart';
import 'bcy/hot.dart';
import 'bcy/hotweek.dart';
import 'bcy/hottoday.dart';
import 'bcy/news.dart';
import 'bcy/newscos.dart';
class Bcy extends StatefulWidget{
  @override
  _Bcy createState() {
    return _Bcy();
  }

}
class _Bcy extends State<Bcy>{
  int _bootomIndex=0;
    List _titles=["热门推荐","本周热门","今日热门","新人榜","最新COS"];
 List<Widget> _bodys=[
   HotBCY(),
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
      body: _bodys[_bootomIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.hot_tub), title: Text(_titles[0]),backgroundColor: Colors.lightBlue),
          BottomNavigationBarItem(icon: Icon(Icons.border_top), title: Text(_titles[1]),backgroundColor: Colors.lightBlue),
          BottomNavigationBarItem(icon: Icon(Icons.school), title: Text(_titles[2]),backgroundColor: Colors.lightBlue),
          BottomNavigationBarItem(icon: Icon(Icons.new_releases), title: Text(_titles[3]),backgroundColor: Colors.lightBlue),
          BottomNavigationBarItem(icon: Icon(Icons.school), title: Text(_titles[4]),backgroundColor: Colors.lightBlue),
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