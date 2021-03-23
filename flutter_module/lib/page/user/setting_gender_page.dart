import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_module/common/getx/UserInfoController.dart';
import 'package:flutter_module/common/net/old_dao.dart';
import 'package:flutter_module/common/net/rok_dao.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/toast_utils.dart';
import 'package:flutter_module/config/config.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingGenderPage extends StatefulWidget {
  final String name;
  final String num;
  final String code;
  final String pwd;
  final int type; //1单独改性别  2注册

  const SettingGenderPage(
      {Key key, this.type = 2, this.name, this.num, this.code, this.pwd})
      : super(key: key);
  @override
  _SettingGenderPageState createState() => _SettingGenderPageState();
}

class _SettingGenderPageState extends State<SettingGenderPage> {
  int selIndex = -1;

  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
      child: Scaffold(
          appBar: YPAppBar("",
                  actions: widget.type == 1
                      ? null
                      : [
                          MySuperWidget(
                            text: "登录",
                            fontSize: 28.sp,
                            textColor: kAppColor("#363638"),
                            padding: EdgeInsets.only(right: 30.w),
                          ),
                        ])
              .build(context),
          body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                MySuperWidget(
                  text: "设置性别",
                  fontSize: 50.sp,
                  textColor: kAppColor("#0D0E15"),
                  fontWeight: FontWeight.bold,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 107.w, left: 75.w),
                ),
                MySuperWidget(
                  text: "设置你的性别，让我们更懂你",
                  fontSize: 32.sp,
                  textColor: kAppColor("#B7B7BB"),
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                      top: 16.w, left: 75.w, right: 60.w, bottom: 75.w),
                ),
                _getGenderItem(1, "icon_man.png", "BOY"),
                _getGenderItem(0, "icon_nv.png", "GIRL"),
                _getGenderItem(3, "icon_wz.png", "不告诉你"),
                MySuperWidget(
                  text: "完成",
                  onTap: () {
                    if (selIndex == -1) {
                      MyToast.show("请选择性别~");
                      return;
                    }
                    if (widget.type == 1){
                      reqModifyName(Get.put(UserController()).nickname.value,sex:selIndex.toString());
                    }else{
                      reqAccountNew(widget.num, widget.name, widget.code,
                          widget.pwd, selIndex);
                    }
                  },
                  fontSize: 32.sp,
                  textColor: Colors.white,
                  bgColor: kAppThemeColor,
                  height: 88.w,
                  radius: 8.w,
                  margin: EdgeInsets.only(top: 50.w, left: 60.w, right: 60.w),
                ),
              ])),
    );
  }

  _getGenderItem(int type, icon, title) {
    return MySuperWidget(
      bgColor: Colors.white,
      onTap: () {
        setState(() {
          selIndex = type;
        });
      },
      height: 170.w,
      radius: 6,
      margin: EdgeInsets.only(left: 60.w, right: 60.w, bottom: 40.w),
      padding: EdgeInsets.only(left: 40.w, right: 40.w),
      alignment: Alignment.center,
      child: Row(
        children: [
          Image.asset(
            Config.KEY_IMAGE_PATH + icon ?? "icon_nv.png",
            width: 120.w,
            height: 120.w,
          ),
          Expanded(child: Container()),
          Text(
            title ?? "",
            style: TextStyle(
                color: selIndex == type
                    ? kAppColor("#0D0E15")
                    : kAppColor("#B7B7BB"),
                fontWeight: type == 3 ? FontWeight.normal : FontWeight.bold,
                fontSize: type == 3 ? 32.w : 40.sp),
          )
        ],
      ),
    );
  }
}
