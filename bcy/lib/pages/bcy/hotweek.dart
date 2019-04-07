import 'package:flutter/material.dart';
class HotWeekBCY extends StatefulWidget{
  @override
  _HotWeekBCY createState() {
    // TODO: implement createState
    return _HotWeekBCY();
  }

}
class _HotWeekBCY extends State<HotWeekBCY> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: <Widget>[
        Text('本周热门')
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}