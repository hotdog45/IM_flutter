import 'package:flutter/material.dart';
import 'package:flutter_module/item/recommend_item.dart';
import 'package:flutter_module/page/other/base_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class RecommendPage extends StatefulWidget {
  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends BaseState<RecommendPage> {
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: StaggeredGridView.countBuilder(
            controller: _scrollController,
            crossAxisCount: 4,
            padding: EdgeInsets.only(bottom: 50),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) => RecommendItem(
                  index: index,
                ),
            staggeredTileBuilder: (int index) => StaggeredTile.fit(2)));
  }

}
