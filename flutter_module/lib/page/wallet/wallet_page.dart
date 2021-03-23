import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/common/native/hi_flutter_bridge.dart';
import 'package:flutter_module/common/net/rok_dao.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/config/config.dart';
import 'package:flutter_module/page/top_up/top_up_page.dart';
import 'package:flutter_module/page/transfer/transfer_page.dart';
import 'package:flutter_module/page/user/advice_page.dart';
import 'package:flutter_module/page/user/login_page.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'change_detail_page.dart';
import 'my_bank_card_page.dart';
import 'my_bill_page.dart';
import 'pay_pwd1_page.dart';
import 'real_name_auth_page.dart';
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

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {

  var availableBal = 0.00;
  // var accId = "";
  bool isZy = true;

  @override
  void initState() {
    super.initState();
    getAccount();

    HiFlutterBridge.getInstance().register("onBack", (MethodCall call) {
      if (Navigator.canPop(context)){
        Navigator.pop(context);
      }else{
        HiFlutterBridge.getInstance().onBack({});
      }
    });

  }

  getAccount() async {
    //   {
    //     "accBal": 1000000,
    // "availableBal": 1000000,
    // "freezeAmt": 0,
    // "accId": 7368881529466880
    // }
    var json = await reqAccountQueryAccount();

    if (json !=null){
      availableBal = json["available_bal"];
      // accId = json["accId"].toString();
      setState(() {

      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: YPAppBar("我的钱包").build(context),
        backgroundColor: kAppColor("#F8F9FB"),
        body: ListView(
          children: [
            _headerView(),
            // _itemWidget("icon_zhuanz.png", "转账", onTap: () {
            //   Get.to(TransferPage( ));
            // }),
            _itemWidget("icon_my_zd.png", "我的账单", onTap: () {
              Get.to(MyBillPage());
            }),
            // _itemWidget("icon_lqmx.png", "零钱明细", onTap: () {
            //   Get.to(ChangeDetailPage());
            // }),
            _itemWidget("icon_my_card.png", "我的银行卡", onTap: () {
              Get.to(MyBankCardPage());
            }),
            Container(
              height: 20.w,
            ),

            _itemWidget("icon_smxx.png", "实名信息", onTap: () {
              Get.to(RealNameAuthPage());
            }),
            _itemWidget("icon_zfmm.png", "支付密码", onTap: () {
              Get.to(PayPwd1Page());
            }),
          ],
        ));
  }

  _itemWidget(icon, title,
      {bool isSwitch = false,
      bool isTop = false,
      bool hasLine = true,
      switchIcon,
      onTap}) {
    return Column(
      children: [
        MySuperWidget(
          onTap: onTap,
          bgColor: Colors.white,
          height: isTop ? 160.w : 124.w,
          padding: EdgeInsets.only(left: 30.w, right: 24.w),
          child: Row(
            children: [
              Image.asset(
                Config.KEY_IMAGE_PATH + icon ?? "icon_right.png",
                width: 44.w,
                height: 44.w,
              ),
              MySuperWidget(
                text: title,
                fontSize: 30.sp,
                padding: EdgeInsets.only(left: 30.w),
                textColor: kAppColor("#0D0E15"),
              ),
              Expanded(child: Container()),
              Image.asset(
                Config.KEY_IMAGE_PATH +
                    (isSwitch ? switchIcon : "icon_right_b.png"),
                width: isSwitch ? 104.w : 34.w,
                height: isSwitch ? 52.w : 34.w,
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

  _headerView() {
    return Stack(
      children: [
        Container(
            child: Image.asset(
          Config.KEY_IMAGE_PATH + "bg_qb_header.png",
          height: 330.w,
          width: 750.w,
        )),
        Column(
          children: [
            MySuperWidget(
                text: "总金额（元）",
                textColor: Colors.white,
                margin: EdgeInsets.only(left: 30.w, top: 30.w),
                alignment: Alignment.centerLeft),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MySuperWidget(
                  text: isZy ? (availableBal ?? 0).toStringAsFixed(2) : "***.**",
                  fontSize: 66.sp,
                  margin: EdgeInsets.only(bottom: 50.w, top: 40.w, right: 20.w),
                  textColor: Colors.white,
                  alignment: Alignment.centerLeft,
                ),
                InkWell(
                  onTap: () {
                    isZy = !isZy;
                    setState(() {

                    });
                  },
                  child: Image.asset(
                    Config.KEY_IMAGE_PATH + "icon_zy.png",
                    width: 36.w,
                    height: 28.w,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MySuperWidget(
                  text: "充值",
                  onTap: () {
                    Get.to(TopUpPage());
                  },
                  fontSize: 34.sp,
                  textColor: Colors.white,
                  bgColor: kAppColor("#FF685F"),
                  height: 72.w,
                  width: 290.w,
                  radius: 8.w,
                ),
                Container(
                  width: 20.w,
                ),
                MySuperWidget(
                  text: "提现",
                  onTap: () {
                    Get.to(TopUpPage(isTopUp: false));
                  },
                  fontSize: 34.sp,
                  textColor: Colors.white,
                  bgColor: kAppColor("#FF685F"),
                  height: 72.w,
                  width: 290.w,
                  radius: 8.w,
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
