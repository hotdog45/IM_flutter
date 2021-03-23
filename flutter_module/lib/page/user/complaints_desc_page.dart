import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/toast_utils.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

class ComplaintsDescPage extends StatefulWidget {
  final String title;

  const ComplaintsDescPage({Key key, this.title}) : super(key: key);
  @override
  _ComplaintsDescPageState createState() => _ComplaintsDescPageState();
}

class _ComplaintsDescPageState extends State<ComplaintsDescPage> {
  final TextEditingController titleController = new TextEditingController();
  final TextEditingController descController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: YPAppBar("投诉", actions: [
        MySuperWidget(
          text: "提交",
          width: 100.w,
          height: 56.w,
          radius: 4,
          textColor: Colors.white,
          margin: EdgeInsets.symmetric(vertical: 23.w, horizontal: 30.w),
          bgColor: kAppThemeColor,
          onTap: () {
            MyToast.show("text");
          },
        )
      ]).build(context),
      body: Container(
        child: Column(
          children: [
            MySuperWidget(
              bgColor: kAppWhiteColor,
              radius: 4,
              height: 90.w,
              margin: EdgeInsets.only(top: 20.w, bottom: 1),
              child: TextField(
                controller: titleController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 25.w),
                  hintText: "请输入账新号",
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
            MySuperWidget(
              bgColor: kAppWhiteColor,
              radius: 4,
              alignment: Alignment.topLeft,
              height: 400.w,
              padding: EdgeInsets.only(top: 20.w),
              child: TextField(
                controller: descController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 25.w),
                  hintText: "投诉内容描述（必填）",
                  hintStyle: TextStyle(color: Color(0xffB7B7BB)), //修改颜色
                  border: InputBorder.none,
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(200),
                ],
                onChanged: (v) {},
                style: TextStyle(fontSize: 32.sp, color: kAppTextColor),
                textAlign: TextAlign.left,
                maxLines: 3,
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
                itemCount: 8,
                padding: EdgeInsets.all(30.w),
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
                  if (index == 7){
                    return MySuperWidget(
                      hasBorder: true,
                      borderColor: kAppColor("#B7B7BB"),
                      radius: 10,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(),
                          MyImage("icon_add_p.png", isAssetImage: true,width: 70.w,),
                          Positioned(bottom: 20.w,child: MySuperWidget(
                            text: "1/9",
                            textColor: kAppColor("#B7B7BB"),
                            fontSize: 28.w,
                            alignment: Alignment.bottomRight,
                          ))
                        ],
                      ),
                    );
                  }

                  return _imageWidget() ;
                })
          ],
        ),
      ),
    );
  }

  _imageWidget() {
    return Stack(
      children: [
        MyImage(""),
        Positioned(right: 4,top:4,child: MyImage("icon_close_x.png", isAssetImage: true,width: 34.w,))
      ],
    );
  }
}
