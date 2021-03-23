import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/toast_utils.dart';
import 'package:flutter_module/widget/common/line_widget.dart';
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

class NoticeDescPage extends StatefulWidget {
  final String title;

  const NoticeDescPage({Key key, this.title}) : super(key: key);
  @override
  _NoticeDescPageState createState() => _NoticeDescPageState();
}

class _NoticeDescPageState extends State<NoticeDescPage> {
  final TextEditingController descController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: YPAppBar("群公告", actions: [
        MySuperWidget(
          text: "编辑",
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
        color: kAppColor("#F8F9FB"),
        child: _itemWidget()
      ),
    );
  }

  Widget _itemWidget() {
    return MySuperWidget(
      bgColor: Colors.white,
      radius: 12.w,
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(left: 30.w,top: 30.w),
            child: Row(
              children: [
                MyImage(
                  "",
                  width: 76.w,
                  height: 76.w,
                  margin: EdgeInsets.only(right: 30.w),

                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MySuperWidget(
                      textColor: kAppColor("#0D0E15"),
                      text: "王小丫",
                      fontSize: 32.sp,
                    ),
                    MySuperWidget(
                      textColor: kAppColor("#B7B7BB"),
                      text: "2021-11-12 12:01:21",
                      fontSize: 26.sp,
                    ),
                  ],
                ),
                MyExpanded(),
                MySuperWidget(
                  textColor: kAppColor("#C1342D"),
                  text: "置顶",
                  fontSize: 26.sp,
                  width: 82.w,
                  height: 44.w,
                  bgColor: kAppColor("#FFF6F6"),
                  hasBorder: true,
                  borderColor: kAppThemeColor,
                  radius: 5,
                  margin: EdgeInsets.only(right: 30.w),
                ),
                MySuperWidget(
                  textColor: kAppColor("#0D0E15"),
                  text: "取消置顶",
                  fontSize: 26.sp,
                  width: 140.w,
                  height: 60.w,
                  bgColor: kAppColor("#F8F9FB"),
                  hasBorder: true,
                  radius: 5,
                  borderColor: kAppColor("#B7B7BB"),
                  margin: EdgeInsets.only(right: 30.w),
                ),
              ],
            ),
          ),
          LineWidget(top: 30.w,),
          MySuperWidget(
            textColor: kAppColor("#363638"),
            text: "&#91重要通知]本周日本群所有人集体团建，可带家属，家属人数不限，参与的请前往行政处登记；请行政处做好安全工作，安排好明天一天行程，祝大家玩的开心！！！",
            fontSize: 32.sp,
            margin: EdgeInsets.all(30.w),
          ),
        ],
      ),
    );
  }
}
