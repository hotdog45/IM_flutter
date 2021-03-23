import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/common/native/hi_flutter_bridge.dart';
import 'package:flutter_module/item/farovite_item.dart';
import 'package:flutter_module/page/other/base_page.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends BaseState<FavoritePage>
    with AutomaticKeepAliveClientMixin {

  ScrollController _scrollController = ScrollController();

  var desc;
  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _content;
  }



  @override
  bool get wantKeepAlive => true;

  Widget get _content {
    return ListView.builder(
      controller: _scrollController,
      itemCount: 20,
      padding: EdgeInsets.all(0),
      itemBuilder: (BuildContext context, int index) => FavoriteItem(
        index: index,
      ),
    );
  }
}
