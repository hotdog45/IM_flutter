import 'dart:async';

import 'package:azlistview/azlistview.dart';
import 'package:flutter_module/common/model/buddy_model.dart';
import 'package:flutter_module/common/net/old_dao.dart';
import 'package:lpinyin/lpinyin.dart';

// 处理通讯录相关的逻辑
class ContactsService {
  // 如果一个函数的构造方法并不总是返回一个新的对象的时候，可以使用factory，
  // 比如从缓存中获取一个实例并返回或者返回一个子类型的实例

  // 工厂方法构造函数
  factory ContactsService() => _getInstance();

  // instance的getter方法，通过ContactsService.instance获取对象
  static ContactsService get sharedInstance => _getInstance();

  // 静态变量_instance，存储唯一对象
  static ContactsService _instance;

  // 私有的命名式构造方法，通过它可以实现一个类可以有多个构造函数，
  // 子类不能继承internal不是关键字，可定义其他名字
  ContactsService._internal() {
    // 异步初始化
    _initAsync();
    // 同步初始化
    _init();
  }

  // 获取对象
  static ContactsService _getInstance() {
    if (_instance == null) {
      // 使用私有的构造方法来创建对象
      _instance = new ContactsService._internal();
    }
    return _instance;
  }

  /// 异步初始化
  Future _initAsync() async {
    // 请求数据
    // fetchContacts();
  }

  // 获取联系人列表
  Future fetchContacts(String uid) async {
    // 先清除掉数据
    _contactsList.clear();
    _contactsMap.clear();

    if (uid.isEmpty){
      return;
    }

    // 获取用户信息列表
    List<BuddyModel> _list = await reqBuddyList(uid);
    _contactsList = _list;
    // 遍历
    _list.forEach((user) {
      _contactsMap[user.userUid] = user;
    });

    for (int i = 0, length = _contactsList.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(_contactsList[i].nickname);
      String tag = pinyin.substring(0, 1).toUpperCase();
      _contactsList[i].screenNamePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        _contactsList[i].tagIndex = tag;
      } else {
        _contactsList[i].tagIndex = "#";
      }
    }
    // 根据A-Z排序
    SuspensionUtil.sortListBySuspensionTag(_contactsList);

    // 返回数据
    return _contactsList;
  }

  /// 同步初始化
  void _init() {}

  /// 通讯录列表
  List<BuddyModel> _contactsList = List();

  /// 通讯录Map
  Map<String, BuddyModel> _contactsMap = Map();
  List<BuddyModel> get contactsList => _contactsList;
  Map<String, BuddyModel> get contactsMap => _contactsMap;
}
