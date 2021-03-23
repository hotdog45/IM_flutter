import 'package:flutter/material.dart';
import 'package:flutter_module/common/getx/UserInfoController.dart';
import 'package:flutter_module/common/model/user_info_model.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_module/widget/my_item_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'head_portrait_page.dart';
import 'my_photo_page.dart';
import 'my_voice_page.dart';
import 'setting_gender_page.dart';
import 'setting_name_page.dart';
import 'setting_pwd_page.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: user_info_page
 * Author: lishunfeng
 * Date: 3/10/21 9:15 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  final UserInfoModel userInfoModel =
      Get.put(UserController()).userInfoModel.value;

  final _user = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: YPAppBar("个人信息").build(context),
        body: Container(
          child: ListView(
            children: [
              getIconWidget(),
              Obx(() => MyItemWidget(
                    title: "昵称",
                    subTitle: _user.nickname.value,
                    onTap: () {
                      Get.to(SettingNamePage(
                        name: userInfoModel.nickname,
                      ));
                    },
                  )),
              MyItemWidget(
                title: "账号",
                subTitle: userInfoModel.userId.toString(),
                onTap: () {
                  // Get.to(SettingNamePage(
                  //   type: 2,
                  // ));
                },
              ),
              MyItemWidget(
                title: "密码",
                subTitle: "修改",
                onTap: () {
                  Get.to(SettingPwdPage(
                    type: 1,
                  ));
                },
              ),
              MySuperWidget(
                height: 20.w,
              ),
              MyItemWidget(
                title: "个人相册",
                subTitle: "",
                onTap: () {
                  Get.to(MyPhotoPage());
                },
              ),
              MyItemWidget(
                title: "语音介绍",
                subTitle: "",
                onTap: () {
                  Get.to(MyVoicePage());
                },
              ),
              MySuperWidget(
                height: 20.w,
              ),
          Obx(()=> MyItemWidget(
                title: "性别",
                subTitle: _user.man.value ? "男" : "女",
                onTap: () {
                  Get.to(SettingGenderPage(type: 1));
                },
              )),
              MyItemWidget(
                title: "E-mail",
                subTitle: userInfoModel.userMail,
                onTap: () {},
              ),
              MySuperWidget(
                height: 20.w,
              ),
             Obx(()=> MyItemWidget(
                title: "个性签名",
                subTitle: _user.whatsUp.value,
                onTap: () {
                  Get.to(SettingNamePage(
                    type: 4,
                    name: _user.whatsUp.value,
                  ));
                },
              )),
          Obx(()=>MyItemWidget(
                title: "其它说明",
                subTitle: _user.userDesc.value,
                onTap: () {
                  Get.to(SettingNamePage(
                    type: 3,
                    name: _user.userDesc.value,
                  ));
                },
              ))
            ],
          ),
        ));
  }

  getIconWidget() {
    return Column(
      children: [
        MySuperWidget(
          onTap: () {
            Get.to(HeadPortraitPage(url: userInfoModel.userAvatarFileName));
          },
          height: 107.w,
          bgColor: Colors.white,
          padding: EdgeInsets.only(left: 30.w, right: 24.w),
          child: Row(
            children: [
              MySuperWidget(
                text: "头像",
                fontSize: 32.sp,
                textColor: kAppColor("#0D0E15"),
              ),
              Expanded(child: Container()),
              MyImage(
                userInfoModel.userAvatarFileName,
                width: 80.w,
                height: 80.w,
                isOval: true,
              ),
              MyImage(
                "icon_right_b.png",
                width: 24.w,
                height: 24.w,
                isAssetImage: true,
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
    );
  }
}
