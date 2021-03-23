import 'package:flutter/material.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/config/config.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'common/my_image.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: my_item_widget
 * Author: lishunfeng
 * Date: 3/6/21 12:13 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

class MyItemWidget extends StatelessWidget {
  final bool isSwitch;
  final bool hasLine;
  final bool switchOpen;
  final String title;
  final String subTitle;
  final String desc;
  final onChanged;
  final onTap;

  const MyItemWidget(
      {Key key,
      this.isSwitch = false,
      this.hasLine = true,
      this.title,
      this.subTitle,
      this.switchOpen = true,
      this.onChanged,
      this.desc = "",
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MySuperWidget(
          onTap: onTap,
          height: 107.w,
          bgColor: Colors.white,
          padding: EdgeInsets.only(left: 30.w, right: 24.w),
          child: Row(
            children: [
              MySuperWidget(
                text: title,
                fontSize: 32.sp,
                textColor: kAppColor("#0D0E15"),
              ),
              Expanded(child: Container()),
              MySuperWidget(
                text: subTitle ?? "",
                fontSize: 28.sp,
                textColor: kAppColor("#78787C"),
              ),
              isSwitch
                  ? Switch(
                      activeColor: kAppThemeColor,
                      value: switchOpen,
                      onChanged: (val) {
                        onChanged(val);
                      })
                  : MyImage(
                      "icon_right_b.png",
                      width: 24.w,
                      height: 24.w,
                      isAssetImage: true,
                    ),
            ],
          ),
        ),
        hasLine && desc.length == 0
            ? MySuperWidget(
                margin: EdgeInsets.only(left: 104.w, right: 30.w),
                bgColor: kAppColor("#F0F0F0"),
                height: 0.5,
              )
            : Container(),
        desc.length > 0
            ? MySuperWidget(
                bgColor: Colors.white,
                padding:
                    EdgeInsets.only(bottom: 20.w, left: 30.w, right: 30.w),
                margin: EdgeInsets.only(bottom: 20.w),
                alignment: Alignment.centerLeft,
                child: Text(
                  desc,
                  textAlign: TextAlign.left,
                  style:
                      TextStyle(color: kAppColor("#B7B7BB"), fontSize: 26.w),
                ))
            : Container(),
      ],
    );
  }
}
