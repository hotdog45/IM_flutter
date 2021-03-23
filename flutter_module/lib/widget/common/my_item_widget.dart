import 'package:flutter/material.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/config/config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'my_image.dart';
import 'my_super_widget.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: MyItemWidget
 * Author: lishunfeng
 * Date: 2/13/21 5:09 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

class MyItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  _itemWidget(icon, title, {bool hasLine = false, onTap, rightIcon}) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MySuperWidget(
            onTap: onTap,
            height: 80.w,
            bgColor: Colors.white,
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Row(
              children: [
                MyImage(
                  icon,
                  width: 48.w,
                  height: 48.w,
                  fit: BoxFit.fill,
                ),
                MySuperWidget(
                  text: title,
                  fontSize: 32.sp,
                  padding: EdgeInsets.only(left: 20.w),
                  textColor: kAppTextColor,
                ),
                Expanded(child: Container()),
                MyImage(
                  rightIcon ?? "icon_right_b.png",
                  width: 34.w,
                  height: 34.w,
                  isAssetImage: true,
                ),
              ],
            ),
          ),
          hasLine
              ? MySuperWidget(
                  margin: EdgeInsets.only(left: 104.w, right: 30.w),
                  bgColor: kAppColor("#F0F0F0"),
                  height: 0.5,
                )
              : Container()
        ],
      ),
    );
  }
}
