import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/toast_utils.dart';
import 'package:flutter_module/config/config.dart';
import 'package:flutter_module/page/other/success_page.dart';
import 'package:flutter_module/page/user/reset_pwd_page.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class RealNameAuthPage extends StatefulWidget {
  final int type; //1设置身份 2验证身份证

  const RealNameAuthPage({Key key, this.type}) : super(key: key);
  @override
  _RealNameAuthPageState createState() => _RealNameAuthPageState();
}

class _RealNameAuthPageState extends State<RealNameAuthPage> {
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController numController = new TextEditingController();
  var selXy = false;
// 响应空白处的焦点的Node
  FocusNode blankNode = FocusNode();

  var title = "实名认证";
  var subTitle = "实名认证可保障您的合法权益并提升账号安全性；实名认证通过后不可修改";
  var btnTitle = "立即认证";
  @override
  void initState() {
    super.initState();
    if (widget.type == 2) {
      title = "忘记密码";
      subTitle = "请输入身份证号，验证本人身份";
      btnTitle = "重新设置密码";
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: FlutterEasyLoading(
        child: Scaffold(
            appBar: YPAppBar("").build(context),
            body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(blankNode);
                },
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    height: 1.sh,
                    width: 1.sw,
                    color: Colors.white,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          MySuperWidget(
                            text: title,
                            fontSize: 50.sp,
                            textColor: kAppColor("#0D0E15"),
                            fontWeight: FontWeight.bold,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(top: 107.w, left: 75.w),
                          ),
                          MySuperWidget(
                            text: subTitle,
                            fontSize: 32.sp,
                            textColor: kAppColor("#B7B7BB"),
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(
                                top: 16.w, left: 75.w, right: 70.w),
                          ),
                          _loginView(),
                          Visibility(
                            visible: widget.type == 1,
                            replacement: Container(height: 100.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // icon_xy_no
                                MySuperWidget(
                                  onTap: () {
                                    setState(() {
                                      selXy = !selXy;
                                    });
                                  },
                                  padding: EdgeInsets.only(
                                      left: 75.w, right: 16.w, top: 82.w),
                                  child: Image.asset(
                                    Config.KEY_IMAGE_PATH +
                                        (selXy
                                            ? "icon_xy_sel.png"
                                            : "icon_xy_no.png"),
                                    width: 35.w,
                                    height: 35.w,
                                  ),
                                ),
                                MySuperWidget(
                                  text: "已阅读并同意《用户协议》",
                                  fontSize: 28.sp,
                                  textColor: kAppColor("#363638"),
                                  radius: 12.w,
                                  onTap: () {
                                    // Fluttertoast.showToast(msg: "点击了用户协议");
                                    MyToast.show("点击了协议");

                                  },
                                ),
                              ],
                            ),
                          ),
                          MySuperWidget(
                            text: btnTitle,
                            onTap: () {
                              if (nameController.text.length < 2) {
                                // Fluttertoast.showToast(msg: "请输入姓名");
                                MyToast.show("请输入姓名");

                                return;
                              }
                              if (numController.text.length < 6) {
                                MyToast.show("请输入身份证号码");
                                return;
                              }

                              if (!selXy) {
                                MyToast.show( "请同意协议");
                                return;
                              }
                              if (widget.type == 1){
                                Get.off(SuccessPage(type: 3, title: "实名认证成功"));
                              }else{
                              }
                            },
                            fontSize: 32.sp,
                            textColor: Colors.white,
                            bgColor: kAppThemeColor,
                            height: 88.w,
                            radius: 12.w,
                            margin: EdgeInsets.only(
                                top: 34.w, left: 60.w, right: 60.w),
                          ),
                        ]),
                  ),
                ))),
      ),
    );
  }

  Widget _loginView() {
    return Container(
        padding: EdgeInsets.only(left: 60.w, right: 60.w, top: 90.w),
        child: Column(children: <Widget>[
          MySuperWidget(
            bgColor: kAppWhiteColor,
            radius: 4,
            height: 88.w,
            hasBorder: true,
            borderColor: kAppColor("#D6D6D6"),
            child: Row(
              children: [
                MySuperWidget(
                  text: "真实姓名",
                  fontSize: 32.sp,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 30.w),
                  textColor: kAppTextColor,
                ),
                Expanded(
                  child: TextField(
                    controller: nameController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 25.w),
                      hintText: '请输入', //（18758586900）
                      hintStyle: TextStyle(color: Color(0xffB7B7BB)), //修改颜色
                      border: InputBorder.none,
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(18),
                    ],
                    onChanged: (v) {},
                    style: TextStyle(fontSize: 32.sp, color: kAppTextColor),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          MySuperWidget(
            bgColor: kAppWhiteColor,
            radius: 4,
            height: 88.w,
            hasBorder: true,
            borderColor: kAppColor("#D6D6D6"),
            margin: EdgeInsets.only(top: 30.w, bottom: 30.w),
            child: Row(
              children: [
                MySuperWidget(
                  text: "身份证号",
                  fontSize: 32.sp,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 30.w),
                  textColor: kAppTextColor,
                ),
                Expanded(
                  child: TextField(
                    controller: numController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 25.w),
                      hintText: '请输入', //（18758586900）
                      hintStyle: TextStyle(color: Color(0xffB7B7BB)), //修改颜色
                      border: InputBorder.none,
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(18),
                    ],
                    onChanged: (v) {},
                    style: TextStyle(fontSize: 32.sp, color: kAppTextColor),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
        ]));
  }
}
