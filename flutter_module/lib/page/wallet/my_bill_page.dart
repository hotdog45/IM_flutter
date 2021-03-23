import 'package:flutter/material.dart';
import 'package:flutter_module/common/model/bill_model.dart';
import 'package:flutter_module/common/net/rok_dao.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/date_time_utils.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: my_bill_page
 * Author: lishunfeng
 * Date: 2/13/21 7:57 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

class MyBillPage extends StatefulWidget {
  @override
  _MyBillPageState createState() => _MyBillPageState();
}

class _MyBillPageState extends State<MyBillPage> {
  BillModel billModel;

  @override
  void initState() {
    super.initState();
    getBill();
  }

  getBill() async {
    billModel = await reqAccountBill();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: YPAppBar("我的账单").build(context),
      body: billModel == null
          ? Container()
          : ListView.builder(
              itemBuilder: (context, index) {
                return _itemWidget(billModel.list[index]);
              },
              itemCount: billModel.list != null ? billModel.list.length : 0,
              padding: EdgeInsets.all(0)),
    );
  }

  _itemWidget(ListElement item) {
    return MySuperWidget(
      onTap: () {},
      child: Column(
        children: [
          MySuperWidget(
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            height: 164.w,
            bgColor: Colors.white,
            child: Row(
              children: [
                MyImage(
                  item.fromAvatar,
                  width: 88.w,
                  height: 88.w,
                  isOval: true,
                  margin: EdgeInsets.only(right: 24.w),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MySuperWidget(
                        text: item.title,
                        fontSize: 32.sp,
                        maxLines: 1,
                        alignment: Alignment.centerLeft,
                        textColor: kAppTextColor,
                      ),
                      MySuperWidget(
                        text: item.tradeTime,
                        fontSize: 28.sp,
                        maxLines: 1,
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 16.w),
                        textColor: kAppColor("#B7B7BB"),
                      ),
                    ],
                  ),
                ),
                MySuperWidget(
                  text: (item.inOutFlag == 1 ? "-":"+") +item.amount,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.sp,
                  margin: EdgeInsets.only(bottom: 60.w),
                  textColor: kAppColor("#FFA640"),
                ),
              ],
            ),
          ),
          MySuperWidget(
            margin: EdgeInsets.only(left: 104.w, right: 30.w),
            bgColor: kAppColor("#F0F0F0"),
            height: 0.5,
          )
        ],
      ),
    );
  }
}
