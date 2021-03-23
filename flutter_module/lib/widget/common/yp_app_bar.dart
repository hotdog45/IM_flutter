import 'package:flutter_module/common/native/hi_flutter_bridge.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_module/config/config.dart';
import 'package:get/get.dart';

class YPAppBar {
  final String title;
  final bool hasBackBtn;
  final bool centerTitle;
  final List<Widget> actions;
  final Widget titleWidget;

  YPAppBar(this.title,
      {this.hasBackBtn = true,
      this.centerTitle = true,
      this.titleWidget,
      this.actions});

  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      brightness: Brightness.light,
      centerTitle: centerTitle,
      title: titleWidget ??
          Text(
            title,
            style: TextStyle(color: kAppTextColor, fontSize: 17),
          ),
      automaticallyImplyLeading: hasBackBtn,
      leading: hasBackBtn
          ? IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              icon: Image.asset(
                Config.KEY_IMAGE_PATH + "icon_left.png",
                width: 20,
                height: 20,
              ),
              onPressed: () {
                if (Navigator.canPop(context)){
                  Navigator.pop(context);
                }else{
                  HiFlutterBridge.getInstance().onBack({});
                }

              })
          : Container(),
      actions: actions,
    );
  }
}
