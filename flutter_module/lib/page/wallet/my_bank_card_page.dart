import 'package:flutter/material.dart';
import 'package:flutter_module/common/model/bank_model.dart';
import 'package:flutter_module/common/net/rok_dao.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'add_bank_page.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: MyBankCard_page
 * Author: lishunfeng
 * Date: 2/13/21 7:57 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

class MyBankCardPage extends StatefulWidget {
  @override
  _MyBankCardPageState createState() => _MyBankCardPageState();
}

class _MyBankCardPageState extends State<MyBankCardPage> {
  List<BankModel> list = [];

  @override
  void initState() {
    super.initState();
    getList();
  }

  getList() async {
    list = await reqBindInfoQueryBindCardList();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: YPAppBar("我的银行卡").build(context),
      body: ListView.builder(
          itemBuilder: (context, index) {
            if (index == list.length){
              return MySuperWidget(
                onTap: (){
                  Get.to(AddBankPage());
                },
                bgColor: kAppColor("#F5F5F5"),
                width: 690.w,
                height: 88.w,
                radius: 10.w,
                hasBorder: true,
                borderColor: kAppColor("#D6D6D6"),
                margin: EdgeInsets.all(30.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyImage(
                      "icon_add_1.png",
                      width: 31.w,
                      height: 31.w,
                      isAssetImage:true ,
                      margin: EdgeInsets.only(right: 20.w),
                    ),
                    MySuperWidget(
                      text: "添加银行卡",
                      fontSize: 32.sp,
                      textColor: kAppTextColor,
                    ),
                  ],
                ),
              );
            }
            return _itemWidget(list[index]);

          },
          itemCount: list.length+1,
          padding: EdgeInsets.all(0)),
    );
  }

  _itemWidget(BankModel model) {
    return MyImage(
      "bg_bank_b.png",
      width: 690.w,
      height: 240.w,
      fit: BoxFit.fill,
      isAssetImage: true,
      margin: EdgeInsets.only(left: 30.w, right: 30.w, top: 30.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyImage(
            "icon_bank.png",
            width: 67.w,
            height: 67.w,
            isAssetImage: true,
            margin: EdgeInsets.only(left: 30.w,top: 30.w,right: 20.w),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MySuperWidget(
                text: model.bankName,
                fontSize: 32.sp,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 40.w),
                textColor: kAppWhiteColor,
              ),
              Row(
                children: [
                  // MySuperWidget(
                  //   text: "**** **** **** ",
                  //   fontSize: 40.sp,
                  //   alignment: Alignment.bottomLeft,
                  //   margin: EdgeInsets.only(top: 60.w),
                  //   textColor: kAppWhiteColor,
                  // ),
                  MySuperWidget(
                    text: model.cardNo,
                    fontSize: 40.sp,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 45.w),
                    textColor: kAppWhiteColor,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
