import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_module/common/constant/app_constant.dart';
import 'package:flutter_module/common/event/index.dart';
import 'package:flutter_module/common/getx/UserInfoController.dart';
import 'package:flutter_module/common/net/rok_dao.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/local_storage.dart';
import 'package:flutter_module/common/unils/toast_utils.dart';
import 'package:flutter_module/config/config.dart';
import 'package:flutter_module/page/other/photo_preview_page.dart';
import 'package:flutter_module/page/user/complaints_desc_page.dart';
import 'package:flutter_module/page/user/my_qr_page.dart';
import 'package:flutter_module/page/wallet/wallet_page.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_qr_widget.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'setting_page.dart';
import 'user_info_page.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  var uid = "";
  var name = "";
  var avatar = "";
  final _user = Get.put(UserController());

  // var stH = 20;
  @override
  void initState() {
    super.initState();
    // showDebugBtn(context);

    // HiFlutterBridge.getInstance().register("loginAfter", (MethodCall call) {
    //   test();
    // });
    eventBus.on<LoginEvent>().listen((LoginEvent event) {
      getUserInfo();
    });


  }

  getAccId() async {
    var json = await reqAccountAccId(int.parse(uid ?? "0"));
    if (json !=null){
      name = json[uid]["nickname"];
      avatar = json[uid]["avatar"];
      setState(() {

      });
    }
  }

  getUserInfo() async {
    uid = await LocalStorage.get(AppConstant.USER_ID) ?? "";
    name = await LocalStorage.get(AppConstant.USER_NICKNAME) ?? "";
    getAccId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          _headerView(),
          MySuperWidget(
              bgColor: Colors.white,
              width: 690.w,
              radius: 12.w,
              margin: EdgeInsets.only(top: 20.w, left: 15, right: 15),
              child: Column(
                children: [
                  _itemWidget("icon_jianyi.png", "投诉建议", onTap: () {
                    Get.to(ComplaintsDescPage());
                  }),
                  _itemWidget("icon_kf.png", "联系客服", onTap: () {
                    MyToast.show("暂无UI");

                  }),
                  _itemWidget("icon_setting.png", "设置", onTap: () {
                    Get.to(SettingPage());
                  }),
                  _itemWidget("icon_help.png", "帮助", onTap: () {
                    // MyToast.show("暂无UI");
                    Get.to(PhotoPreviewPage(title: "行行行",imagePath: "https://user-gold-cdn.xitu.io/2019/10/28/16e128373660d84d?imageView2/0/w/1280/h/960/format/webp/ignore-error/1",));
                  }),
                  // _itemWidget("icon_msg.png", "消息通知", onTap: () {
                  //   // Get.to(AnnouncementPage());
                  //   // HiFlutterBridge.getInstance().goToNative(
                  //   //     {"action": "pushPage", "page": "AnnouncementPage"});
                  // }),
                ],
              )),

        ],
      )),
    );
  }

  _headerView() {
    return Stack(
      children: [
        Container(
            child: Image.asset(
          Config.KEY_IMAGE_PATH + "bg_mine.png",
        )),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top:  ScreenUtil().statusBarHeight + 40.w, left: 15, right: 24),
              child: Row(
                children: [
                  MySuperWidget(
                    text: "我的",
                    fontSize: 50.sp,
                    textColor: Colors.white,
                    fontWeight: FontWeight.bold,
                    padding: EdgeInsets.only(top: 1),
                  ),
                  Expanded(child: Container()),
                  InkWell(
                    onTap: () {
                      Get.to(MyQrPage());
                    },
                    child: Image.asset(
                      Config.KEY_IMAGE_PATH + "icon_code.png",
                      width: 32,
                    ),
                  )
                ],
              ),
            ),
            MySuperWidget(
              onTap: () {
                Get.to(UserInfoPage());
              },
              padding: EdgeInsets.only(top: 36, left: 15, right: 24),
              child: Row(
                children: [
                  MyImage(_user.userAvatarFileName.value,
                      width: 140.w,
                      height: 140.w,
                      isOval: true,
                      margin: EdgeInsets.only(right: 36.w)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     Obx(()=>  MySuperWidget(
                        text: _user.nickname.value ?? "",
                        fontSize: 44.sp,
                        textColor: kAppColor("#FFFFFF"),
                        fontWeight: FontWeight.bold,
                      )),
                      MySuperWidget(
                        text: "飞鸽ID：" + _user.userId.value.toString() ?? "",
                        fontSize: 30.sp,
                        textColor: Color(0x99FFFFFF),
                      ),
                    ],
                  ),
                  Expanded(child: Container()),
                  Image.asset(
                    Config.KEY_IMAGE_PATH + "icon_right.png",
                    width: 31.w,
                  )
                ],
              ),
            ),
            MySuperWidget(
              bgColor: Colors.white,
              width: 690.w,
              height: 160.w,
              radius: 12.w,
              margin: EdgeInsets.only(top: 69.w),
              child: _itemWidget("icon_qian.png", "我的钱包",
                  isTop: true, hasLine: false, onTap: () {
                // HiFlutterBridge.getInstance()
                //     .goToNative({"action": "pushPage", "page": "WalletPage"});
                    Get.to(WalletPage());
              }),
            )
          ],
        ),
      ],
    );
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
}
