import 'package:flutter/material.dart';
import 'package:flutter_module/common/constant/app_constant.dart';
import 'package:flutter_module/common/event/index.dart';
import 'package:flutter_module/common/unils/toast_utils.dart';

import 'local_storage.dart';
/**
 * Copyright (C), 2015-2021, 谊品生鲜
 * FileName: user_service
 * Author: lishunfeng
 * Date: 2/19/21 5:15 PM
 * Description:
 * History:
 * <author> <time> <version> <desc>
 * 作者姓名 修改时间 版本号 描述
 */

// 处理通讯录相关的逻辑
class UserService {
  // 如果一个函数的构造方法并不总是返回一个新的对象的时候，可以使用factory，
  // 比如从缓存中获取一个实例并返回或者返回一个子类型的实例

  // 工厂方法构造函数
  factory UserService() => _getInstance();

  // instance的getter方法，通过ContactsService.instance获取对象
  static UserService get sharedInstance => _getInstance();

  // 静态变量_instance，存储唯一对象
  static UserService _instance;

  // 私有的命名式构造方法，通过它可以实现一个类可以有多个构造函数，
  // 子类不能继承internal不是关键字，可定义其他名字
  UserService._internal() {
    // 异步初始化
    _initAsync();
    // 同步初始化
    _init();
  }

  // 获取对象
  static UserService _getInstance() {
    if (_instance == null) {
      // 使用私有的构造方法来创建对象
      _instance = new UserService._internal();
    }
    return _instance;
  }
  Future _initAsync()  async{
    // 请求数据
    getLocalData();
  }
  /// 异步初始化
   getLocalData() async {
    // 请求数据
    _token = await LocalStorage.get(AppConstant.USER_TOKEN);
    _uid = await LocalStorage.get(AppConstant.USER_ID);
    _name = await LocalStorage.get(AppConstant.USER_NICKNAME);
    _sex = await LocalStorage.get(AppConstant.USER_SEX);
    _userAvatarFileName = await LocalStorage.get(AppConstant.USER_AVATAR_PATH);
  }


  /// 同步初始化
  void _init() {
    eventBus.on<LoginEvent>().listen((LoginEvent event) {
      _uid = event.jsonData["user_id"];
      _name = event.jsonData["nickname"];
      _userAvatarFileName = event.jsonData["userAvatarFileName"];
      _token = event.jsonData["token"];
      _sex = event.jsonData["user_sex"];
      _userData =  event.jsonData;
      MyToast.show("内存缓存数据");
    });
  }

  String _token = "";
  String _uid = "";
  String _name = "";
  String _userAvatarFileName = "";
  int _sex = 0;
  String get token => _token;
  String get uid => _uid;
  String get name => _name;
  String get userAvatarFileName => _userAvatarFileName;
  int get sex => _sex;


  Map<String,dynamic> _userData = Map();

  Map<String, dynamic> get userData => _userData;
}