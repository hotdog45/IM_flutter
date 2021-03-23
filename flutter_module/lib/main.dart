import 'package:bot_toast/bot_toast.dart';
import 'package:dokit/dokit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/page/common/main_page.dart';
import 'package:flutter_module/page/user/mine_page.dart';
import 'package:flutter_module/page/user/login_page.dart';
import 'package:flutter_module/page/user/my_qr_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'common/native/hi_flutter_bridge.dart';
import 'common/unils/user_service.dart';
import 'page/chat/chat_messages_page.dart';
import 'page/common/welcome_page.dart';
import 'page/contacts/contacts_page.dart';
import 'page/group/group_data_page.dart';
import 'page/group/group_manage_page.dart';
import 'page/group/group_members_page.dart';
import 'page/notice/announcement_page.dart';
import 'page/other/favorite_page.dart';
import 'dart:ui';

import 'page/red_envelope/envelope_detail_page.dart';
import 'page/red_envelope/red_envelope_page.dart';
import 'page/red_envelope/red_pop.dart';
import 'page/transfer/transfer_page.dart';
import 'page/user/advice_page.dart';
import 'page/user/native_page.dart';
import 'page/user/user_info_page.dart';
import 'page/wallet/wallet_page.dart';

//至少要有主入口
void main() {
  DoKit.runApp(
      app: DoKitApp(MyApp()),
      // 是否在release包内使用，默认release包会禁用
      useInRelease: true,
      releaseAction: () => {
            // release模式下执行该函数，一些用到runZone之类实现的可以放到这里，该值为空则会直接调用系统的runApp(MyApp())，
          }); //runApp(MyApp()
}

//注册多个dart module
@pragma('vm:entry-point')
void mine() => runApp(MyApp(page: MinePage()));
//注册多个dart module
@pragma('vm:entry-point')
void contacts() => runApp(MyApp(page: ContactsPage()));
//注册多个dart module
@pragma('vm:entry-point')
void favorite() => runApp(MyApp(page: FavoritePage()));

class MyApp extends StatefulWidget {
  final Widget page;
  const MyApp({Key key, this.page}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var routeName = "";
  var params = Map();
  Widget page = MainPage();
  @override
  void initState() {
    super.initState();
    routeName = window.defaultRouteName;
    if (routeName.isNotEmpty) {
      Uri uri = Uri.parse("my//:" + routeName);
      params = uri.queryParameters;
    }

    initPage();
  }

  initPage() {
    if (routeName == "MinePage") {
      page = MinePage();
    } else if (routeName == "ContactsPage") {
      page = ContactsPage();
    } else if (routeName == "LoginPage") {
      page = LoginPage();
    } else if (routeName == "AnnouncementPage") {
      page = AnnouncementPage();
    } else if (routeName == "UserInfoPage") {
      page = UserInfoPage();
    } else if (routeName.startsWith("RedEnvelopePage")) {
      page = RedEnvelopePage(
          type: int.parse(params["type"]) ?? 0,
          id: params["id"].toString() ?? "0");
    } else if (routeName.startsWith("TransferPage")) {
      page = TransferPage(uid: params["id"].toString() ?? "0");
    } else if (routeName.startsWith("EnvelopeDetailPage")) {
      page = EnvelopeDetailPage(redId: params["redId"].toString() ?? "0");
    } else if (routeName.startsWith("RedPop")) {
      page = RedPop(redId: params["redId"].toString() ?? "0");
    } else if (routeName == "WalletPage") {
      page = WalletPage();
    } else if (routeName.startsWith("GroupDataPage")) {
      page = GroupDataPage(gid: params["gid"].toString() ?? "");
    } else if (routeName.startsWith("GroupManagePage")) {
      page = GroupManagePage(gid: params["gid"].toString() ?? "");
    } else if (routeName.startsWith("GroupMembersPage")) {
      page = GroupMembersPage(id: params["id"].toString() ?? "0");
    } else if (routeName.startsWith("MainPage")) {
      page = MainPage();
    } else if (routeName.startsWith("ChatMessagesPage")) {
      page = ChatMessagesPage(uid: params["id"].toString() ?? "0");
    } else if (routeName.startsWith("NativePage")) {
      page = NativePage();
    } else {
      page = MainPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        // ignore: missing_return
        builder: (_, BoxConstraints constraints) {
      if (constraints.maxWidth != 0) {
        ScreenUtil.init(
          constraints,
          designSize: Size(750, 1334),
          allowFontScaling: false,
        );
        return GetMaterialApp(
            showSemanticsDebugger: false,
            debugShowCheckedModeBanner: false,
            // popGesture: true,
            // defaultGlobalState: true,

            builder: BotToastInit(), //1.调用BotToastInit
            navigatorObservers: [BotToastNavigatorObserver()], //2.注册路由观察者
            home: page);
      }
    });
  }
}
