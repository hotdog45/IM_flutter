import 'package:flutter/material.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/widget/common/line_widget.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: bank_card_list
 * Author: lishunfeng
 * Date: 2/13/21 5:02 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

class BankCardDialog extends StatelessWidget {
  final onDone;

  List _list = [
    "中国工商银行储蓄卡（3819）",
    "中国建设银行储蓄卡（8291）",
    "招商银行储蓄卡（8593）",
    "中国工商银行储蓄卡（3819）",
    "中国建设银行储蓄卡（8291）",
    "招商银行储蓄卡（8593）",
  ];

  BankCardDialog({Key key, this.onDone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Column(
          children: [
            Expanded(child: Container()),
            MySuperWidget(
              bgColor: Colors.white,
              radius: 30.w,
              child: Column(
                children: [
                  MySuperWidget(
                    text: "选择充值银行卡",
                    height: 120.w,
                    fontSize: 32.w,
                    radius: 30.w,
                    bgColor: kAppWhiteColor,
                    textColor: kAppTextColor,
                  ),
                  LineWidget(),
                  Container(
                    constraints: BoxConstraints(
                        maxHeight: 108.w * 4.5, minHeight: 108.w * 2),
                    child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                        return _itemWidget("", _list[index], onTap: (){
                          onDone(index);
                        });
                      },
                      itemCount: _list.length,
                    ),
                  ),
                  _itemWidget("", "新增银行卡充值")
                ],
              ),
            ),
          ],
        ));
  }

  _itemWidget(icon, title, {bool hasLine = true, onTap, rightIcon}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MySuperWidget(
          onTap: onTap,
          height: 108.w,
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
    );
  }
}
