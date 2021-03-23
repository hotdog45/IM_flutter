import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/toast_utils.dart';
import 'package:flutter_module/widget/common/my_expanded.dart';
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

class PublishNoticePage extends StatefulWidget {
  final String title;

  const PublishNoticePage({Key key, this.title}) : super(key: key);
  @override
  _PublishNoticePageState createState() => _PublishNoticePageState();
}

class _PublishNoticePageState extends State<PublishNoticePage> {
  final TextEditingController descController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: YPAppBar("发布公告", actions: [
        MySuperWidget(
          text: "完成",
          width: 100.w,
          height: 56.w,
          radius: 4,
          textColor: Colors.white,
          margin: EdgeInsets.symmetric(vertical: 23.w, horizontal: 30.w),
          bgColor: kAppThemeColor,
          onTap: () {
            MyToast.show("text");
          },
        )
      ]).build(context),
      body: Container(
        child: Column(
          children: [
            MySuperWidget(
              bgColor: kAppWhiteColor,
              alignment: Alignment.topLeft,
              height: 500.w,
              padding: EdgeInsets.only(top: 20.w),
              child: TextField(
                controller: descController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 25.w),
                  hintText: "请输入公告内容",
                  hintStyle: TextStyle(color: Color(0xffB7B7BB)), //修改颜色
                  border: InputBorder.none,
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1000),
                ],
                onChanged: (v) {},
                style: TextStyle(fontSize: 32.sp, color: kAppTextColor),
                textAlign: TextAlign.left,
                maxLines: 3,
              ),
            ),
            MySuperWidget(
              bgColor: Colors.white,
              padding: EdgeInsets.all(30.w),
              child: Row(
                children: [
                  MyImage(selXy
                      ? "icon_xy_sel.png"
                      : "icon_xy_no.png", isAssetImage: true,width: 34.w,),
                  MySuperWidget(
                    textColor: kAppColor("#363638"),
                    text: "置顶",
                    fontSize: 30.sp,
                  ),
                  MyExpanded(),
                  MySuperWidget(
                    textColor: kAppColor("#B7B7BB"),
                    text: "0/1000",
                    fontSize: 30.sp,
                  ),
                ],
              ),
            )


          ],
        ),
      ),
    );
  }

  var selXy = false;


}
