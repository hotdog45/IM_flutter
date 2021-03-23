import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_module/common/net/rok_dao.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/toast_utils.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'setting_gender_page.dart';
import 'package:flutter_module/common/net/old_dao.dart';

class SettingNamePage extends StatefulWidget {
  final int type; // -1设置群昵称 0设置群名称  //1 昵称 2 设置账户 3设置其他 4设置签名
  final String name;
  final String gid;

  const SettingNamePage({Key key, this.type=1, this.name, this.gid}) : super(key: key);




  @override
  _SettingNamePageState createState() => _SettingNamePageState();
}

class _SettingNamePageState extends State<SettingNamePage> {
  final TextEditingController pwdController = new TextEditingController();

// 响应空白处的焦点的Node
  FocusNode blankNode = FocusNode();

  var _title = "";
  var _subTitle = "";
  var _hint = "";

  @override
  void initState() {
    super.initState();
    pwdController.text = widget.name;
    if (widget.type == -1) {
      _title = "修改我的群昵称";
      _subTitle = "昵称修改后，只会在此群内显示，群内成员都可以看见";
      _hint = "请输入群昵称";
    } else if (widget.type == 0) {
      _title = "修改群聊名称";
      _subTitle = "修改群聊名称，将在群内通知其他成员";
      _hint = "请输入群聊名称";
    } else if (widget.type == 1) {
      _title = "设置昵称";
      _subTitle = "设置个性的昵称，展示独一无二的你";
      _hint = "请输入昵称";
    } else if (widget.type == 2) {
      _title = "设置账户";
      _subTitle = "账号只能修改一次，可与数字、字母结合";
      _hint = "请输入账号";
    } else if (widget.type == 3) {
      _title = "设置其他说明";
      _subTitle = "设置个性的昵称，展示独一无二的你";
      _hint = "请输入昵称";
    } else if (widget.type == 4) {
      _title = "设置个性签名";
      _subTitle = "设置个性的签名，展示独一无二的你";
      _hint = "请输入个性签名";
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
                  // 点击空白页面关闭键盘
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
                            text: _title,
                            fontSize: 50.sp,
                            textColor: kAppColor("#0D0E15"),
                            fontWeight: FontWeight.bold,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(top: 107.w, left: 75.w),
                          ),
                          MySuperWidget(
                            text: _subTitle,
                            fontSize: 32.sp,
                            textColor: kAppColor("#B7B7BB"),
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(
                                top: 16.w, left: 75.w, right: 60.w),
                          ),
                          MySuperWidget(
                            bgColor: kAppColor("#F8F9FB"),
                            radius: 4,
                            alignment: widget.type > 2
                                ? Alignment.topLeft
                                : Alignment.centerLeft,
                            height: widget.type > 2 ? 234.w : 90.w,
                            padding: EdgeInsets.only(
                                top: widget.type > 2 ? 20.w : 0),
                            margin: EdgeInsets.only(
                                left: 60.w,
                                right: 60.w,
                                bottom: 200.w,
                                top: 130.w),
                            child: TextField(
                              controller: pwdController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 25.w),
                                hintText: _hint,
                                hintStyle:
                                    TextStyle(color: Color(0xffB7B7BB)), //修改颜色
                                border: InputBorder.none,
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(
                                    widget.type > 2 ? 120 : 18),
                              ],
                              onChanged: (v) {},
                              style: TextStyle(
                                  fontSize: 32.sp, color: kAppTextColor),
                              textAlign: TextAlign.left,
                              maxLines: widget.type > 2 ? 3 : 1,
                            ),
                          ),
                          MySuperWidget(
                            text: "确定",
                            onTap: () {
                              if (pwdController.text.length < 1) {
                                MyToast.show(_hint);
                                return;
                              }
                              FocusScope.of(context).requestFocus(blankNode);
                              if (widget.type == 1) {
                                reqModifyName(pwdController.text);
                              }else if (widget.type == 4){
                                reqModifyWhatsUp(pwdController.text);
                              }else if (widget.type == 3){
                                reqModifyDesc(pwdController.text);
                              }else if (widget.type == 0){
                                reqModifyGroupName(pwdController.text,widget.gid);
                              }else if (widget.type == -1){
                                reqModifyGroupNickname(pwdController.text,widget.gid);
                              }
                            },
                            fontSize: 32.sp,
                            textColor: Colors.white,
                            bgColor: kAppThemeColor,
                            height: 88.w,
                            radius: 8.w,
                            margin: EdgeInsets.only(left: 60.w, right: 60.w),
                          ),
                        ]),
                  ),
                ))),
      ),
    );
  }
}
