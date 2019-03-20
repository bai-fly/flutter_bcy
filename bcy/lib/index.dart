import 'package:flutter/material.dart';
import 'widgets/MyAppBar.dart';
class Index extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    int _bootomIndex=0;
    
    return Scaffold(
      appBar: MyAppBar(
        null,
        "标题",
        FlatButton(child: Text('测试',style: TextStyle(color: Colors.white),),onPressed: (){

        },)
      ),
      body: Text('data'),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.business), title: Text('Business')),
          BottomNavigationBarItem(icon: Icon(Icons.school), title: Text('School')),
        ],
        currentIndex: _bootomIndex,
        fixedColor: Colors.deepPurple,
        onTap: (int index){

        },
      ),
    );
  }

}