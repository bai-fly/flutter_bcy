import 'package:flutter/material.dart';
class NewsCOSBCY extends StatefulWidget{
  @override
  _NewsCOSBCY createState() {
    // TODO: implement createState
    return _NewsCOSBCY();
  }

}
class _NewsCOSBCY extends State<NewsCOSBCY> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: <Widget>[
        Text('最新cos')
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}