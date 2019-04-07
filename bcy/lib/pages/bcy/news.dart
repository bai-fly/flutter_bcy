import 'package:flutter/material.dart';
class NewsBCY extends StatefulWidget{
  @override
  _NewsBCY createState() {
    // TODO: implement createState
    return _NewsBCY();
  }

}
class _NewsBCY extends State<NewsBCY> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: <Widget>[
        Text('新人榜')
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}