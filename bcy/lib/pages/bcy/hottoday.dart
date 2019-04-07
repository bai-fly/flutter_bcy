import 'package:flutter/material.dart';
class HotTodayBCY extends StatefulWidget{
  @override
  _HotTodayBCY createState() {
    // TODO: implement createState
    return _HotTodayBCY();
  }

}
class _HotTodayBCY extends State<HotTodayBCY> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: <Widget>[
        Text('今日热门')
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}