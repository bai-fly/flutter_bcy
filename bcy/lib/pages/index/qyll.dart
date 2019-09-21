import 'package:flutter/material.dart';

import 'index.dart';
class Qyll extends ShowMoreWidget{
  @override
  _Qyll createState() {
    // TODO: implement createState
    return _Qyll();
  }

  @override
  showMore() {
    // TODO: implement showMore
    return null;
  }

}
class _Qyll extends State<Qyll> with AutomaticKeepAliveClientMixin{
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