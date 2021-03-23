import 'dart:convert';
import 'dart:io';

import 'package:azlistview/azlistview.dart';
import 'package:dio_log/dio_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/common/constant/app_constant.dart';
import 'package:flutter_module/common/event/index.dart';
import 'package:flutter_module/common/model/buddy_model.dart';
import 'package:flutter_module/common/native/hi_flutter_bridge.dart';
import 'package:flutter_module/common/style/style.dart';
import 'package:flutter_module/common/unils/local_storage.dart';
import 'package:flutter_module/config/config.dart';
import 'package:flutter_module/page/group/group_list_page.dart';
import 'package:flutter_module/widget/common/my_image.dart';
import 'package:flutter_module/widget/common/my_super_widget.dart';
import 'package:flutter_module/widget/common/pop_up_menu.dart';
import 'package:flutter_module/widget/dialog/add_friend_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'contacts_service.dart';
import 'mh_index_bar.dart';
import 'new_friend_page.dart';
import 'search_friend_page.dart';

const List<String> INDEX_DATA_0 = ['★', '#', '↑', '@', 'A', 'B', 'C', 'D'];
const List<String> INDEX_DATA_1 = ['E', 'F', 'G', 'H', 'I', 'J', 'K', 'L'];
const List<String> INDEX_DATA_2 = ['M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T'];
const List<String> INDEX_DATA_3 = ['U', 'V', 'W', 'X', 'Y', 'Z', '#', '↓'];

class ContactsPage extends StatefulWidget {
  ContactsPage({Key key}) : super(key: key);

  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage>
    with AutomaticKeepAliveClientMixin {
  /// 联系人列表
  List<BuddyModel> _contactsList = [];

  /// 标签名
  String _suspensionTag = "";

  /// 联系人总数
  String _contactsCount = '';

  /// 最后一个联系人
  BuddyModel _lastContact;
  @override
  bool get wantKeepAlive => true;

  var uid = "";
  @override
  void initState() {
    super.initState();
    showDebugBtn(context);

    HiFlutterBridge.getInstance().register("loginAfter", (MethodCall call) {
      _fetchContacts();
    });
    _fetchContacts();
  }

  /// 请求联系人列表
  void _fetchContacts() async {
    uid = await LocalStorage.get(AppConstant.USER_ID);
    List<BuddyModel> list = [];
      list = await ContactsService.sharedInstance.fetchContacts(uid);
    setState(() {
      _contactsList = list;
      _lastContact = list.last;
      _contactsCount = "${list.length}位联系人";
      _suspensionTag = '#';
    });
  }

  /// 索引标签被点击
  void _onSusTagChanged(String tag) {
    setState(() {
      _suspensionTag = tag;
    });
  }

  /// 构建悬浮部件
  /// [susTag] 标签名称
  /// [isFloat] 是否悬浮
  Widget _buildSusWidget(String susTag, {bool isFloat = false}) {
    return Container(
      height: 40.w,
      padding: EdgeInsets.only(left: 30.w),
      decoration: BoxDecoration(
        color: kAppColor("#F8F9FB"),
        border: isFloat
            ? Border(bottom: BorderSide(color: Color(0xFFE6E6E6), width: 0.5))
            : null,
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        '$susTag',
        softWrap: false,
        style: TextStyle(
          fontSize: 28.w,
          color: kAppColor("#78787C"),
        ),
      ),
    );
  }

  /// 构建列表项
  Widget _buildListItem(BuddyModel user) {
    String susTag = user.getSuspensionTag();
    return Column(
      children: <Widget>[
        Offstage(
          offstage: user.isShowSuspension != true,
          child: _buildSusWidget(susTag),
        ),
        _itemTopWidget(user.userAvatarFileName, user.nickname, onTap: () {
          HiFlutterBridge.getInstance().goToNative(
              {"action": "createChat", "uid": user.userUid , "nickname": user.nickname ?? ""});
        }),
        // 底部显示共有多人
        Offstage(
          offstage: _lastContact.userUid != user.userUid,
          child: MySuperWidget(
            textColor: kAppTextColor,
            text: _contactsCount,
            fontSize: 32.sp,
            margin: EdgeInsets.only(top: 30.w, bottom: 30.w),
          ),
        ),
      ],
    );
  }

  _itemTopWidget(icon, title,
      {bool hasLine = true, bool hasRight = false, onTap}) {
    return Column(
      children: [
        MySuperWidget(
          onTap: onTap,
          height: 140.w,
          bgColor: Colors.white,
          padding: EdgeInsets.only(left: 30.w, right: 66.w),
          child: Row(
            children: [
              MyImage(
                icon ?? testImage,
                width: 88.w,
                height: 88.w,
                fit: BoxFit.cover,
                isOval: true,
              ),
              MySuperWidget(
                text: title,
                fontSize: 30.sp,
                padding: EdgeInsets.only(left: 30.w),
                textColor: kAppColor("#0D0E15"),
              ),
              Expanded(child: Container()),
              hasRight
                  ? Image.asset(
                      Config.KEY_IMAGE_PATH + "icon_right_b.png",
                      width: 34.w,
                      height: 34.w,
                    )
                  : Container(),
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: Container(
      constraints: BoxConstraints.expand(),
      color: kAppBcgColor,
      child: Column(
        children: <Widget>[
          MySuperWidget(
            height: kToolbarHeight +  ScreenUtil().statusBarHeight,
            bgColor: Colors.white,
            padding: EdgeInsets.only(top: 50, left: 15, right: 4),
            child: Row(
              children: [
                MySuperWidget(
                  text: "联系",
                  fontSize: 50.sp,
                  textColor: kAppColor("#0D0E15"),
                  fontWeight: FontWeight.bold,
                  padding: EdgeInsets.only(top: 1),
                ),
                Expanded(child: Container()),
                // MyPopupMenuBtn(type: 2)
                MyImage(
                  "icon_add_fri.png",
                  isAssetImage: true,
                  width: 40.w,
                  height: 40.w,
                  padding: EdgeInsets.only(right: 30.w,left: 30.w),
                  onTap: () => Get.to(SearchFriendPage()),
                )
              ],
            ),
          ),
          Expanded(child: _buildCustomIndexBarList()),
        ],
      ),
    ));
  }

  // 构建自定义索引条的
  Widget _buildCustomIndexBarList() {
    return AzListView(
      data: _contactsList,
      itemBuilder: (context, model) => _buildListItem(model),
      suspensionWidget: _buildSusWidget(_suspensionTag, isFloat: true),
      isUseRealIndex: true,
      itemHeight: 142.w.toInt(),
      suspensionHeight: 40.w.ceil(),
      onSusTagChanged: _onSusTagChanged,
      header: AzListViewHeader(
        tag: "↑",
        height: 2 * 142.w.toInt(),
        builder: (context) {
          return Column(
            children: [
              _itemTopWidget(testImage, "新朋友",hasRight: true,onTap: (){

                Get.to(NewFriendPage());
              }),
              _itemTopWidget(testImage, "群组",hasRight: true,onTap: (){
                // HiFlutterBridge.getInstance().goToNative(
                //     {"action": "qunChat"});
                Get.to(GroupListPage());
              })
            ],
          );
        },
      ),
      // 隐藏默认提供的
      showIndexHint: false,
      indexBarBuilder: _buildCustomIndexBarByBuilder,
    );
  }

  /// 🔥🔥🔥 构建自定义IndexBar by builder  使用Builder的形式控件 更加强大 更高定制度
  Widget _buildCustomIndexBarByBuilder(BuildContext context,
      List<String> tagList, IndexBarTouchCallback onTouch) {
    return Padding(
      padding: EdgeInsets.only(right: 20.w),
      child: MHIndexBar(
        data: tagList,
        tag: _suspensionTag,
        itemHeight: 44.w.toInt(),
        onTouch: onTouch,
        indexBarTagBuilder: (context, tag, indexModel) {
          return _buildIndexBarTagWidget(context, tag, indexModel);
        },
        indexBarHintBuilder: (context, tag, indexModel) {
          return _buildIndexBarHintWidget(context, tag, indexModel);
        },
      ),
    );
  }

  /// 构建tag
  Widget _buildIndexBarTagWidget(
      BuildContext context, String tag, IndexBarDetails indexModel) {
    return MySuperWidget(
      bgColor:
          indexModel.tag == tag ? kAppColor("#C1342D") : Colors.transparent,
      radius: 21.w,
      text: tag,
      fontSize: 26.sp,
      textColor: indexModel.tag != tag ? kAppColor("#363638") : Colors.white,
      width: 42.w,
      height: 42.w,
    );
  }

  /// 构建Hint
  Widget _buildIndexBarHintWidget(
      BuildContext context, String tag, IndexBarDetails indexModel) {
    return Positioned(
      left: -80.w,
      top: -5.w,
      child: Offstage(
        offstage: indexModel.tag == tag ? !indexModel.isTouchDown : true,
        child: Container(
          width: 86.w,
          height: 47.w,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('static/images/icon_qp.png'),
              fit: BoxFit.contain,
            ),
          ),
          alignment: Alignment(-0.12, 0.0),
          child: Text(
            tag,
            style: TextStyle(color: Colors.white, fontSize: 34.w),
          ),
        ),
      ),
    );
  }
}
