import 'package:flutter_module/common/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_module/config/config.dart';
import 'package:get/get.dart';

import 'my_super_widget.dart';

class MyAppBar {
  final String title;
  final Widget rightIcon;
  final bool isTransparent;

  MyAppBar(this.title, {this.isTransparent = false, this.rightIcon});

  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      backgroundColor: isTransparent ? Colors.transparent : Colors.white,
      elevation: 0,
      brightness: Brightness.light,
      centerTitle: true,
      title: null,
      automaticallyImplyLeading: true,
      leading: MySuperWidget(
        text: title,
        margin:  EdgeInsets.only(left:5),
        fontSize: 25,
        textColor: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: rightIcon,
        )
      ],
    );
  }
}
