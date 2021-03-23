import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/toast_utils.dart';
import 'package:flutter_module/widget/common/line_widget.dart';
import 'package:flutter_module/widget/common/my_expanded.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/yp_app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


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

class SearchResultsPage extends StatefulWidget {
  final String title;

  const SearchResultsPage({Key key, this.title}) : super(key: key);
  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  final TextEditingController descController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: YPAppBar("查找结果",actions: [

        MySuperWidget(
          text: "换一换",
          width: 100.w,
          height: 56.w,
          radius: 4,
          fontSize: 32.w,
          textColor: kAppColor("#0D0E15"),
          margin: EdgeInsets.symmetric(vertical: 23.w, horizontal: 30.w),
          onTap: () {
            MyToast.show("text");
          },
        )
      ]).build(context),
      body: Container(
        color: kAppColor("#F8F9FB"),
        child: ListView.builder(
            itemBuilder: (context, index) {
              return _itemWidget();
            },
            itemCount: 10),
      ),
    );
  }

  Widget _itemWidget() {
    return MySuperWidget(
      onTap: (){


      },
      bgColor: Colors.white,
      radius: 12.w,
      // margin: EdgeInsets.only(left: 30.w,right: 30.w,top: 30.w),
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(left: 30.w,top: 30.w),
            child: Row(
              children: [
                MyImage(
                  "",
                  width: 106.w,
                  height: 106.w,
                  margin: EdgeInsets.only(right: 30.w),

                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MySuperWidget(
                        textColor: kAppColor("#0D0E15"),
                        text: "王小丫",
                        fontSize: 34.sp,
                        alignment: Alignment.centerLeft,
                      ),
                      Row(
                        children: [
                          MySuperWidget(
                            textColor: kAppColor("#B7B7BB"),
                            text: "ID:MY3819103",
                            maxLines: 1,
                            fontSize: 28.sp,
                            alignment: Alignment.centerLeft,
                          ),

                          _getTag(type: 0),
                          _getTag(type: 1),
                          _getTag(type: 2),
                          _getTag(type: 3),
                        ],
                      ),
                    ],
                  ),
                ),

                MyImage(
                  "icon_right_b.png",
                  width: 30.w,
                  height: 30.w,
                  isAssetImage: true,
                  margin: EdgeInsets.only(right: 30.w),
                ),
              ],
            ),
          ),
          LineWidget(top: 30.w,),

        ],
      ),
    );
  }

  _getTag({type=0}){
    if (type == 0){
      return MySuperWidget(
        textColor: kAppColor("#C1342D"),
        text: "在线",
        fontSize: 20.sp,
        width: 56.w,
        height: 30.w,
        radius: 5,
        hasBorder: true,
        borderColor: kAppColor("#E3E3E3"),
      );
    }else if (type == 1){
      return MySuperWidget(
        textColor: kAppColor("#B7B7BB"),
        text: "离线",
        fontSize: 20.sp,
        width: 56.w,
        height: 30.w,
        radius: 5,
        hasBorder: true,
        borderColor: kAppColor("#E3E3E3"),
      );
    }else if (type == 2){
      return MySuperWidget(
        textColor: kAppColor("#C1342D"),
       child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyImage(
              "icon_nv_s.png",
              isAssetImage: true,
              width: 18.w,
            ),
            Text("女",style: TextStyle(color: kAppColor("#FF6452"),fontSize: 20.w),)

          ],
        ),
        width: 56.w,
        height: 30.w,
        radius: 5,
        hasBorder: true,
        borderColor: kAppColor("#FF6452"),
      );
    }else if (type == 3){
      return MySuperWidget(
        textColor: kAppColor("#C1342D"),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyImage(
              "icon_nan_s.png",
              isAssetImage: true,
              width: 18.w,
            ),
            Text("男",style: TextStyle(color: kAppColor("#00B4FF"),fontSize: 20.w),)

          ],
        ),
        width: 56.w,
        height: 30.w,
        radius: 5,
        hasBorder: true,
        borderColor: kAppColor("#00B4FF"),
      );
    }

  }

}
