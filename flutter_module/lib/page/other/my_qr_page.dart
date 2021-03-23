import 'package:flutter/material.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/widget/common/my_qr_widget.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_qr_reader/qrcode_reader_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: my_qr_page
 * Author: lishunfeng
 * Date: 3/22/21 7:18 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */


class QrCodePage extends StatefulWidget {
  @override
  _QrCodePageState createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
  GlobalKey<QrcodeReaderViewState> qrViewKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: YPAppBar("扫码登录").build(context),
      body: MyQrcodeReaderView(key: qrViewKey, onScan: reqAppLogin,hasPhoto: false,),
    );
  }
  //扫描二维码登陆
  Future reqAppLogin(String string) async {
    Get.defaultDialog(
      title: string
    );

  }
}