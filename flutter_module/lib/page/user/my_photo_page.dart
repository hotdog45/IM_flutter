import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_module/common/net/old_dao.dart';
import 'package:flutter_module/common/net/rok_dao.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/toast_utils.dart';
import 'package:flutter_module/page/other/photo_preview_page.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'setting_gender_page.dart';

class MyPhotoPage extends StatefulWidget {
  @override
  _MyPhotoPageState createState() => _MyPhotoPageState();
}

class _MyPhotoPageState extends State<MyPhotoPage> {
  List _list = [];
  @override
  void initState() {
    super.initState();
    getList();
  }

  getList() async {
    _list = await reqUserPhoto();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: FlutterEasyLoading(
        child: Scaffold(
            appBar: YPAppBar("").build(context),
            body: ListView(children: <Widget>[
              MySuperWidget(
                text: "相册",
                fontSize: 50.sp,
                textColor: kAppColor("#0D0E15"),
                fontWeight: FontWeight.bold,
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 107.w, left: 75.w),
              ),
              MySuperWidget(
                text: "上传图片到这里，留存更多美好回忆",
                fontSize: 32.sp,
                textColor: kAppColor("#B7B7BB"),
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 16.w, left: 75.w, right: 60.w),
              ),
              GridView.builder(
                  shrinkWrap: true,
                  itemCount: _list.length + 1,
                  padding: EdgeInsets.only(left: 75.w, right: 75.w, top: 60.w),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      //横轴元素个数
                      crossAxisCount: 3,
                      //纵轴间距
                      mainAxisSpacing: 30.w,
                      //横轴间距
                      crossAxisSpacing: 30.w,
                      //子组件宽高长度比例
                      childAspectRatio: 1.0),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return MySuperWidget(
                        hasBorder: true,
                        borderColor: kAppColor("#B7B7BB"),
                        radius: 10,
                        child: MyImage(
                          "icon_add_p.png",
                          isAssetImage: true,
                          width: 70.w,
                        ),
                      );
                    }
                    List data = _list[index - 1];
                    // "http://dimweb.yuanxu.co/BinaryDownloader?action=photo_d&user_uid=400148&file_name=8f55bbe63b802b4e52119d3b9bf7aea6.jpg"
                    String host =
                        "http://dimweb.yuanxu.co/BinaryDownloader?action=photo_d&user_uid=" +
                            userInfoModel.userId.toString() +
                            "&file_name=";

                    return _imageWidget(
                      host + data[1],
                      data[4],
                      onTap: () {
                        Get.to(PhotoPreviewPage(
                            title: data[5],
                            imagePath: data[1],
                            resourceId: data[0]));
                      },
                    );
                  })
            ])),
      ),
    );
  }

  _imageWidget(img, num, {onTap}) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          MyImage(
            img,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            radius: 10.w,
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Color(0x30000000),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MyImage(
                      "icon_eye.png",
                      isAssetImage: true,
                      width: 34.w,
                    ),
                    MySuperWidget(
                      text: num,
                      fontSize: 24.w,
                      textColor: Colors.white,
                      margin: EdgeInsets.only(right: 20.w, left: 10.w),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
