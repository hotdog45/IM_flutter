import 'package:flutter/material.dart';
import 'package:flutter_module/common/native/hi_flutter_bridge.dart';
import 'package:flutter_module/common/model/goods_model.dart';
import 'package:transparent_image/transparent_image.dart';

class RecommendItem extends StatelessWidget {
  // final GoodsModel item;
  final int index;

  const RecommendItem({Key key,  this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HiFlutterBridge.getInstance()
            .goToNative({"action": "goToDetail", "goodsId": "1222222222222"});
      },
      child: Card(
        child: PhysicalModel(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _itemImage(context),
              Container(
                padding: EdgeInsets.all(4),
                child: Text(
                  "商品名称商品名称商品名称商品名称",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
              _infoText()
            ],
          ),
        ),
      ),
    );
  }

  _itemImage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      //设置最小初始高度，防止动态图片高度时的抖动
      constraints: BoxConstraints(minHeight: size.width / 2),
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: "https://www.devio.org/img/beauty_camera/beauty_camera6.jpg",
        fit: BoxFit.cover,
      ),
    );
  }

  _infoText() {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 0, 6, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Text(
              "七天无理由",
              style: TextStyle(fontSize: 11, color: Colors.deepOrangeAccent),
            ),
          ),
          Row(
            children: <Widget>[
              Text(
                "￥",
                style: TextStyle(fontSize: 10, color: Colors.redAccent),
              ),
              Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Text(
                    "992.22",
                    style: TextStyle(fontSize: 18, color: Colors.redAccent),
                  )),
              Text(
                "2255",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              )
            ],
          ),
        ],
      ),
    );
  }
}
