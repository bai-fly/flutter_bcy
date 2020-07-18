import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class IndexListViewItem extends Container {
  String id;
  String _url;
  IndexListViewItem(String id, String userImg, String userName, String cover,
      String url, Function(String) onTap)
      : super(
          //child:Image.network(cover)
          child: Card(
            elevation: 4.0,
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                GestureDetector(
                  child: CachedNetworkImage(
                    imageUrl: cover,
                    placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
                  ),
                  onTap: () {
                    onTap(url);
                    // Navigator.push(context, MaterialPageRoute(
                    //   builder: (context)=>BcyDetail(url)
                    // ));
                  },
                ),
                Expanded(
                    child: Center(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text(
                      userName,
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                )),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: <Widget>[
                //     Text(
                //       userName,
                //       style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.normal),
                //       maxLines: 3,
                //       //overflow: TextOverflow.ellipsis,
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ) {
    this.id = id;
    _url = url;
  }
}
