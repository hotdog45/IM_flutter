import 'dart:async';

// import 'package:connectivity/connectivity.dart';
import 'package:dio_log/overlay_draggable_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/common/constant/app_constant.dart';
import 'package:flutter_module/common/event/index.dart';
import 'package:flutter_module/common/native/hi_flutter_bridge.dart';
import 'package:flutter_module/common/net/rok_dao.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/i18n_utils.dart';
import 'package:flutter_module/common/unils/local_storage.dart';
import 'package:flutter_module/common/unils/toast_utils.dart';

import 'package:flutter_module/config/config.dart';
import 'package:flutter_module/page/contacts/contacts_page.dart';
import 'package:flutter_module/page/common/friend_page.dart';
import 'package:flutter_module/page/chat/message_page.dart';
import 'package:flutter_module/page/user/mine_page.dart';
import 'package:flutter_module/page/user/login_page.dart';
import 'package:get/get.dart';





class MainPage extends StatefulWidget {
  static final String sName = "main";
  final int selIndex;


  const MainPage({Key key, this.selIndex}) : super(key: key);
  @override
  _MainPageState createState() => _MainPageState();


}

class _MainPageState extends State<MainPage> {
  List<Widget> tabBodies ;

  int currentIndex = 0;
  var currentPage;
  int badgeValue = 0;
  String _apiType = "";

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    super.initState();
    _autoLogin();
    tabBodies = [
      MessagePage(),
      ContactsPage(),
      FriendPage(),
      MinePage(),
    ];
    currentIndex = widget.selIndex ?? 0;
    currentPage = tabBodies[currentIndex];

    // eventBus.on<SelTabEvent>().listen((SelTabEvent event) {
    //   currentIndex = event.indexSel;
    //   setState(() {});
    // });
    showDebugBtn(context);

    // _connectivitySubscription =
    //     _connectivity.onConnectivityChanged.listen(initConnectivity);
    HiFlutterBridge.getInstance().register("onLoginAfter", (MethodCall call) {
      // eventBus.fire(LoginEvent(call.arguments));
      // MyToast.show("登录成功----");
    });
    HiFlutterBridge.getInstance().register("onBack", (MethodCall call) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    });
    HiFlutterBridge.getInstance().register("getRedPkg", (MethodCall call) {
      reqAccountRedPay(call.arguments);
    });
  }

  _autoLogin() async {
    String uid = await LocalStorage.get(AppConstant.USER_ID) ?? "";
    String autoLogin = await LocalStorage.get("AutoLogin") ?? "0";
    String pwd = await LocalStorage.get("pwd") ?? "";
    if (uid.isNotEmpty && autoLogin == "1") {
      reqAccountLogin(uid, pwd, isAuto: true);
    }else{
      Get.off(LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
      child: Scaffold(
        bottomNavigationBar: CupertinoTabBar(
          items: _getBottomList(),
          currentIndex: currentIndex,
          activeColor: kAppThemeColor,
          inactiveColor: kAppColor("#999999"),
          backgroundColor: Colors.white,
          onTap: (index) {

            setState(() {
              currentIndex = index;
              currentPage = tabBodies[index];
            });
          },
        ),
        body: WillPopScope(
          onWillPop: doubleClickBack,
          child: IndexedStack(
            index: currentIndex,
            children: tabBodies,
          ),
        ),

        // floatingActionButton: !Config.DEBUG
        //     ? Container()
        //     : InkWell(
        //         child: Icon(
        //           Icons.build,
        //           size: 50,
        //         ),
        //         onTap: () {
        //
        //         },
        //       ),
      ),
    );
  }

  List<BottomNavigationBarItem> _getBottomList() {
    List<BottomNavigationBarItem> bottomTabs = [
      _getBottomNavigationBarItem("icon_message_no.png", "icon_msg_sel.png",
          "消息"),
      _getBottomNavigationBarItem("icon_friend_no.png",
          "icon_friend_sel.png",  "联系"),

      _getBottomNavigationBarItem("icon_find_no.png", "icon_find_sel.png",
          "发现"),
      _getBottomNavigationBarItem("icon_mine_no.png", "icon_mine_sel.png",
         "我的"),
    ];

    return bottomTabs;
  }

  BottomNavigationBarItem _getBottomNavigationBarItem(image, imageSel, title) {
    return BottomNavigationBarItem(
        icon: Image.asset(
          Config.KEY_IMAGE_PATH + image,
          width: iconSize,
        ),
        activeIcon: Image.asset(
          Config.KEY_IMAGE_PATH + imageSel,
          width: iconSize,
        ),
        title: Text("$title$_apiType", style: bottomNavTextStyle()));
  }

//底部导航栏的样式
  TextStyle bottomNavTextStyle() => TextStyle(fontSize: 11);
  double iconSize = 22;
  int last = 0;
  Future<bool> doubleClickBack() {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now - last > 1000) {
      last = DateTime.now().millisecondsSinceEpoch;
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  // final Connectivity _connectivity = Connectivity();
  // StreamSubscription<ConnectivityResult> _connectivitySubscription;
  //
  // initConnectivity(ConnectivityResult connectivityResult) {
  //   eventBus.fire(NoNet(connectivityResult == ConnectivityResult.none));
  //   print("connectivityResult" + connectivityResult.toString());
  // }

  // 释放掉Timer
  @override
  void dispose() {
    // _connectivitySubscription.cancel();
    super.dispose();
  }
}
