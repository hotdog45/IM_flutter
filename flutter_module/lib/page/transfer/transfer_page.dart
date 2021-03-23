import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/common/native/hi_flutter_bridge.dart';
import 'package:flutter_module/common/net/rok_dao.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/current_limiting_util.dart';
import 'package:flutter_module/common/unils/toast_utils.dart';
import 'package:flutter_module/widget/amount/amount_keyboard_dialog.dart';
import 'package:flutter_module/widget/common/line_widget.dart';
import 'package:flutter_module/widget/common/my_expanded.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_module/widget/pwd/pwd_keyboard_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: transfer_page
 * Author: lishunfeng
 * Date: 2/13/21 5:54 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

class TransferPage extends StatefulWidget {
  final String uid;

  const TransferPage({Key key, this.uid = "400150"}) : super(key: key);
  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final TextEditingController _noteController = new TextEditingController();

  var num = "";

  var accId = "";
  var name = "";
  var icon = "";

  // 弹出对话框
  Future<bool> showPwdDialog() {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return PwdKeyboardDialog(
            pwdChange: (val) {
              if (val.toString().length == 6) {
                CurrentLimitingUtil.debounce(() {
                  send(val.toString());
                });
              }
            },
          );
        });
  }

  @override
  void initState() {
    super.initState();
    HiFlutterBridge.getInstance().register("onBack", (MethodCall call) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      } else {
        HiFlutterBridge.getInstance().onBack({});
      }
    });
    getAccId();
  }

  getAccId() async {
    var json = await reqAccountAccId(int.parse(widget.uid ?? "0"));
    if (json != null) {
      accId = json[widget.uid]["acc_id"].toString();
      name = json[widget.uid]["nickname"];
      icon = json[widget.uid]["avatar"];
      setState(() {});
    }
  }

  send(pwd) async {
    double sum = double.parse(num);
    var json = await reqTradingTransfer(sum, accId, _noteController.text, pwd);
    if (json != null) {
      FocusScope.of(context).requestFocus(FocusNode());
      MyToast.show("转账成功~");
      Get.back();
      HiFlutterBridge.getInstance().goToNative({
        "action": "sendTransfer",
        "sum": sum.toStringAsFixed(2),
        "desc": _noteController.text,
        "uid": widget.uid
      });
      FocusScope.of(context).requestFocus(FocusNode());
      HiFlutterBridge.getInstance().onBack({});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: YPAppBar("转账").build(context),
      backgroundColor: kAppColor("#F8F9FB"),
      body: MySuperWidget(
        width: 690.w,
        height: 620.w,
        radius: 20.w,
        bgColor: Colors.white,
        margin: EdgeInsets.all(30.w),
        child: Column(
          children: [
            MyImage(icon,
                width: 88.w,
                height: 88.w,
                isOval: true,
                margin: EdgeInsets.only(top: 30.w)),
            MySuperWidget(
              text: name,
              textColor: kAppColor("#363638"),
              margin: EdgeInsets.only(top: 10.w),
              fontSize: 34.sp,
            ),
            MySuperWidget(
              text: "ID：" + widget.uid,
              textColor: kAppColor("#B7B7BB"),
              margin: EdgeInsets.only(top: 1.w),
              fontSize: 30.sp,
            ),
            MyExpanded(),
            LineWidget(),
            MySuperWidget(
              text: "转账金额",
              textColor: kAppColor("#363638"),
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 30.w, top: 30.w),
              fontSize: 30.sp,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.w, top: 80.w),
              child: Row(children: [
                MyImage("icon_money.png",
                    width: 35.w,
                    height: 45.w,
                    isAssetImage: true,
                    padding: EdgeInsets.only(top: 20.w)),
                Expanded(
                  child: MySuperWidget(
                    text: num,
                    height: 100.w,
                    alignment: Alignment.centerLeft,
                    fontSize: 90.sp,
                    textColor: kAppTextColor,
                    fontWeight: FontWeight.bold,
                    padding: EdgeInsets.only(left: 16.w),
                    onTap: () {
                      showDialog<bool>(
                          context: context,
                          barrierColor: Colors.transparent,
                          // barrierDismissible: false,
                          builder: (context) {
                            return AmountKeyboardDialog(
                              onChanged: (val) {
                                num = val;
                                setState(() {});
                              },
                              type: 2,
                              onDone: (val) {
                                if (num.length == 0) {
                                  MyToast.show("请输入金额");
                                  return;
                                }
                                double sum = double.parse(num);
                                if (sum == 0) {
                                  MyToast.show("请输入金额");
                                  return;
                                }
                                Get.back();
                                showPwdDialog();
                              },
                            );
                          });

                      // Get.to(AmountKeyboardDialog());
                    },
                  ),
                )
                // Expanded(
                //     child: TextField(
                //   controller: _controller,
                //   onTap: () {
                //     showDialog<bool>(
                //         context: context,
                //         barrierColor: Colors.transparent,
                //         // barrierDismissible: false,
                //         builder: (context) {
                //           return AmountKeyboardDialog(
                //             onChanged: (val) {
                //               _controller.text = val;
                //               setState(() {});
                //             },
                //             type: 2,
                //             onDone: (val) {
                //               Get.back();
                //             },
                //           );
                //         });
                //
                //     // Get.to(AmountKeyboardDialog());
                //   },
                //   onChanged: (val) {},
                //   decoration: InputDecoration.collapsed(
                //       hintText: "请输入充值金额",
                //       hintStyle:
                //           TextStyle(fontSize: 32.sp, color: kAppSub2TextColor)),
                //   style: TextStyle(fontSize: 80.sp, color: kAppTextColor),
                // ))
              ]),
            ),
            MySuperWidget(
              height: 1.w,
              bgColor: kAppColor("#D6D6D6"),
              margin: EdgeInsets.only(left: 108.w, right: 30.w),
            ),
            MySuperWidget(
              height: 80.w,
              bgColor: kAppColor("#F0F0F0"),
              radius: 12.w,
              margin: EdgeInsets.all(30.w),
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              child: TextField(
                  controller: _noteController,
                  decoration: InputDecoration.collapsed(
                      hintText: "添加备注(50字以内)",
                      hintStyle: TextStyle(
                          color: kAppColor("#B7B7BB"), fontSize: 32.w)),
                  style: TextStyle(fontSize: 32.w, color: kAppTextColor)),
            )
          ],
        ),
      ),
    );
  }
}
