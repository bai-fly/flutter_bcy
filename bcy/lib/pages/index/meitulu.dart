import 'package:flutter/material.dart';
class MeiTuLu extends StatefulWidget{
  @override
  _MeiTuLu createState() {
    // TODO: implement createState
    return _MeiTuLu();
  }

}
class _MeiTuLu extends State<MeiTuLu> with AutomaticKeepAliveClientMixin{
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