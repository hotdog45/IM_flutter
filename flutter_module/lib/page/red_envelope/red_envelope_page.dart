import 'package:dio_log/dio_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/common/native/hi_flutter_bridge.dart';
import 'package:flutter_module/common/net/rok_dao.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/current_limiting_util.dart';
import 'package:flutter_module/common/unils/toast_utils.dart';
import 'package:flutter_module/widget/common/line_widget.dart';
import 'package:flutter_module/widget/common/my_expanded.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/pwd/pwd_keyboard_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: red_envelope_page
 * Author: lishunfeng
 * Date: 2/14/21 10:30 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

class RedEnvelopePage extends StatefulWidget {
  final int type; //0 个人  1 群红包 2群随机
  final String id;

  const RedEnvelopePage({Key key, this.type, this.id}) : super(key: key);


  @override
  RedEnvelopePageState createState() => RedEnvelopePageState();
}

class RedEnvelopePageState extends State<RedEnvelopePage> {
  final TextEditingController _numController = new TextEditingController();
  final TextEditingController _sumController = new TextEditingController();
  final TextEditingController _descController = new TextEditingController();


  var type = 0;

  @override
  void initState() {

    super.initState();
    HiFlutterBridge.getInstance().register("onBack", (MethodCall call) {
      if (Navigator.canPop(context)){
        Navigator.pop(context);
      }else{
        HiFlutterBridge.getInstance().onBack({});
      }
    });
    type = widget.type;
    showDebugBtn(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(60.w),
              bottomRight: Radius.circular(60.w)),
          child: MyImage(
            "bg_qb_header.png",
            isAssetImage: true,
            height: 387.w,
            width: 750.w,
            fit: BoxFit.fill,
          ),
        ),
        MySuperWidget(
          margin: EdgeInsets.only(top: 20.w + ScreenUtil().statusBarHeight),
          child: Column(
            children: [
              widget.type == 0
                  ? MySuperWidget(
                      text: "发红包" ,
                      fontSize: 32.sp,
                      margin: EdgeInsets.only(bottom: 8.w),
                      textColor: Colors.white,
                      padding: EdgeInsets.only(bottom: 50.w),
                    )
                  : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      _tabWidget("普通红包" ,sel: 1),
                      MySuperWidget(width: 48.w),
                      _tabWidget("拼手气红包",sel: 2),
                    ]),
              _contentWidget(),
              Padding(
                padding: EdgeInsets.only(top: 80.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyImage("icon_money.png",
                        width: 30.w,
                        height: 38.w,
                        isAssetImage: true,
                        margin: EdgeInsets.only(right: 10.w, top: 10.w)),
                    MySuperWidget(
                      text: _sumController.text ?? "0",
                      fontSize: 80.sp,
                      textColor: kAppTextColor,
                      fontWeight: FontWeight.bold,
                    )
                  ],
                ),
              ),
              widget.type == 0
                  ? MySuperWidget(
                      text: "红包单个金额不超过200元",
                      fontSize: 30.sp,
                      textColor: kAppColor("#B7B7BB"),
                      margin: EdgeInsets.only(
                        bottom: 20.w,
                        top: 80.w,
                      ),
                    )
                  : Container(),
              MySuperWidget(
                text: "塞进红包",
                onTap: () {
                  if (widget.type > 0) {
                    if (_numController.text.length == 0) {
                      MyToast.show("请输入红包个数");
                      return;
                    }
                    int num = int.parse(_numController.text);
                    if (num <= 0) {
                      MyToast.show("请输入红包个数");
                      return;
                    }
                  }
                  if (_sumController.text.length == 0) {
                    MyToast.show("请输入红包金额");
                    return;
                  }
                  double sum = double.parse(_sumController.text);
                  if (sum <= 0) {
                    MyToast.show("请输入红包金额");
                    return;
                  }

                  showPwdDialog();
                },
                fontSize: 32.sp,
                textColor: Colors.white,
                bgColor: kAppColor("#F35F4D"),
                height: 88.w,
                radius: 8.w,
                margin: EdgeInsets.only(
                    top: widget.type == 0 ? 0 : 80.w, left: 30.w, right: 30.w),
              ),
              MyExpanded(),
              MySuperWidget(
                text: "红包24小时内未领取将按原路径返回",
                fontSize: 30.sp,
                textColor: kAppColor("#B7B7BB"),
                margin: EdgeInsets.only(bottom: 40.w),
              ),
            ],
          ),
        ),
        Positioned(
            child: MyImage(
              "icon_left_back.png",
              isAssetImage: true,
              width: 20,
              height: 20,
              padding: EdgeInsets.only(right: 50, bottom: 50),
              onTap: () {
                Get.back();
                HiFlutterBridge.getInstance().onBack(null);
              },
            ),
            left: 30.w,
            top: 25.w + ScreenUtil().statusBarHeight),
      ],
    ));
  }

  _contentWidget() {
    return MySuperWidget(
      height: widget.type == 0 ? 324.w : 484.w,
      width: 690.w,
      radius: 12.w,
      bgColor: Colors.white,
      margin: EdgeInsets.only(left: 30.w, right: 30.w),
      child: Column(
        children: [
          widget.type == 0
              ? Container()
              : MySuperWidget(
                  height: 160.w,
                  width: 690.w,
                  padding: EdgeInsets.only(left: 30.w, right: 30.w),
                  child: Row(
                    children: [
                      MySuperWidget(
                          text: "红包个数",
                          textColor: kAppTextColor,
                          fontSize: 32.sp),
                      // MySuperWidget(
                      //     text: "(本群88人）",
                      //     textColor: kAppColor("#B7B7BB"),
                      //     fontSize: 32.sp),
                      Expanded(
                          child: TextField(
                        controller: _numController,
                        decoration: InputDecoration(
                          hintText: '输入个数',
                          hintStyle: TextStyle(color: Color(0xffB7B7BB)),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 32.sp,
                          color: kAppTextColor,
                        ),
                        textAlign: TextAlign.right,
                        onChanged: (val) {
                          setState(() {});
                        },
                      )),
                      MySuperWidget(
                        text: " 个",
                        alignment: Alignment.centerLeft,
                        textColor: kAppTextColor,
                        fontSize: 32.sp,
                      ),
                    ],
                  ),
                ),
          widget.type == 0 ? Container() : LineWidget(left: 30.w, right: 30.w),
          MySuperWidget(
            height: 160.w,
            width: 690.w,
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Row(
              children: [
                MySuperWidget(
                    text: "单个金额", textColor: kAppTextColor, fontSize: 32.sp),
                Expanded(
                    child: TextField(
                  controller: _sumController,
                  decoration: InputDecoration(
                    hintText: '输入金额',
                    hintStyle: TextStyle(color: Color(0xffB7B7BB)),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: 32.sp,
                    color: kAppTextColor,
                  ),
                  textAlign: TextAlign.right,
                  onChanged: (val) {
                    setState(() {});
                  },
                )),
                MySuperWidget(
                  text: " 元",
                  alignment: Alignment.centerLeft,
                  textColor: kAppTextColor,
                  fontSize: 32.sp,
                ),
              ],
            ),
          ),
          LineWidget(left: 30.w, right: 30.w),
          MySuperWidget(
            height: 160.w,
            width: 690.w,
            padding: EdgeInsets.only(left: 30.w, right: 30.w),
            child: Row(
              children: [
                MySuperWidget(
                    text: "添加祝福", textColor: kAppTextColor, fontSize: 32.sp),
                Expanded(
                    child: TextField(
                        controller: _descController,
                        decoration: InputDecoration(
                          hintText: '恭喜发财，大吉大利',
                          hintStyle: TextStyle(color: Color(0xffB7B7BB)),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontSize: 32.sp,
                          color: kAppTextColor,
                        ),
                        textAlign: TextAlign.right))
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 弹出对话框
  Future<bool> showPwdDialog() {
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return PwdKeyboardDialog(
            pwdChange: (val) {
              if (val.toString().length == 6) {
                CurrentLimitingUtil.debounce((){
                  send(val.toString());
                });

              }
            },
          );
        });
  }

  send(pwd) async {
    double sum = double.parse(_sumController.text);
    String desc =
        _descController.text.length == 0 ? "恭喜发财, 大吉大利" : _descController.text;
    var count = 1;
    if (type > 0){
      if (_numController.text.length == 0){
        MyToast.show("请输入个数");
        return;
      }
      count = int.parse(_numController.text) ?? 1;
    }
    var json = await reqTradingGiveRedPacket(sum, widget.id, desc, pwd,
        type: type,total:count);

    if (json != null) {
      MyToast.show("红包发送成功~");
      HiFlutterBridge.getInstance()
          .goToNative({"action": "sendRedPkg", "red_id": json["red_packet_id"],
        "sum": sum.toStringAsFixed(2),"desc": desc,"uid":widget.id
      });
      FocusScope.of(context).requestFocus(FocusNode());
      Get.back();
      HiFlutterBridge.getInstance().onBack({});
    }
  }

  _tabWidget(title, {sel = 1}) {
    return MySuperWidget(
      onTap: (){
        type = sel;
        setState(() {

        });
      },
      height: 100.w,
      child: Column(
        children: [
          MySuperWidget(
            text: title,
            fontSize: 32.sp,
            margin: EdgeInsets.only(bottom: 8.w),
            textColor: type == sel ? Colors.white : Color(0x99FFFFFF),
          ),
          MySuperWidget(
              height: 2,
              width: 50.w,
              radius: 1,
              bgColor: type == sel ? Colors.white : Colors.transparent)
        ],
      ),
    );
  }
}
