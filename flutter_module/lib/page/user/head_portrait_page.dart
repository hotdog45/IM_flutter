import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/toast_utils.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

class HeadPortraitPage extends StatefulWidget {
  final String url;

  const HeadPortraitPage({Key key, this.url}) : super(key: key);
  @override
  _HeadPortraitPageState createState() => _HeadPortraitPageState();
}

class _HeadPortraitPageState extends State<HeadPortraitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: YPAppBar("头像", actions: [
        MySuperWidget(
          child: Icon(
            Icons.more_horiz_outlined,
            size: 50.w,
            color: Colors.black,
          ),
          padding: EdgeInsets.only(left: 20, right: 30.w),
          onTap: () {
            MyToast.show("text");
          },
        )
      ]).build(context),
      body: Center(
          child: MyImage(
        widget.url,
        width: 1.sw,
        height: 1.sw,
        fit: BoxFit.cover,
        padding: EdgeInsets.only(bottom: 160.w),
      )),
    );
  }
}
