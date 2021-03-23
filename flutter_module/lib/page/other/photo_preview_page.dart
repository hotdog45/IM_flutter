import 'package:flutter/material.dart';
import 'package:flutter_module/common/net/old_dao.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/toast_utils.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:math' as math;

/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: message_page
 * Author: lishunfeng
 * Date: 2/4/21 9:08 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

class PhotoPreviewPage extends StatefulWidget {
  final String imagePath;
  final String title;
  final String resourceId;

  const PhotoPreviewPage({Key key, this.imagePath, this.title, this.resourceId}) : super(key: key);




  @override
  _PhotoPreviewPageState createState() => _PhotoPreviewPageState();
}

class _PhotoPreviewPageState extends State<PhotoPreviewPage> {
  var angle = 0.0;
  String host =
      "http://dimweb.yuanxu.co/BinaryDownloader?action=photo_d&user_uid=" +
          userInfoModel.userId.toString() +
          "&file_name=";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: YPAppBar(widget.title ?? " ").build(context),
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.black),
                child: Transform.rotate(
                  //旋转90度
                  angle: angle,
                  child:
                      PhotoView(imageProvider: NetworkImage(host +widget.imagePath)),
                ),
              )),
          Positioned(
            left: 60.w,
            bottom: 60.w,
            child: MyImage(
              "icon_photo_del.png",
              width: 100.w,
              height: 100.w,
              isAssetImage: true,
              onTap: () {
                MyToast.show("删除22");
                reqDelImage(widget.resourceId, widget.imagePath);
              },
            ),
          ),
          Positioned(
            right: 60.w,
            bottom: 60.w,
            child: MyImage(
              "icon_photo_xz.png",
              width: 100.w,
              height: 100.w,
              isAssetImage: true,
              onTap: () {
                angle = angle + math.pi / 2;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
