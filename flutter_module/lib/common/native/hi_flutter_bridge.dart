import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_module/common/model/alarm_model.dart';
import 'package:flutter_module/common/unils/toast_utils.dart';
import 'package:get/get.dart';

///Flutter通信框架
class HiFlutterBridge {
  static HiFlutterBridge _instance = new HiFlutterBridge._();
  MethodChannel _bridge = const MethodChannel('HiFlutterBridge');
  var _listeners = {};
  var header;

  HiFlutterBridge._() {
    _bridge.setMethodCallHandler((MethodCall call) {
      String method = call.method;
      if (_listeners[method] != null) {
        return _listeners[method](call);
      }
      return null;
    });
  }

  static HiFlutterBridge getInstance() {
    return _instance;
  }

  register(String method, Function(MethodCall) callBack) {
    _listeners[method] = callBack;
  }

  unRegister(String method) {
    _listeners.remove(method);
  }

  goToNative(Map prams) {
    _bridge.invokeMethod("goToNative", prams);
  }

  showToast(String msg) {
    _bridge.invokeMethod("goToNative", {"msg": msg, "action": "showToast"});
  }

  save(String key, String val) async {
    _bridge.invokeMethod(
        "goToNative", {"key": key, "val": val, "action": "saveVal"});
  }

  Future<List<AlarmModel>> getMsgList() async {
    var string =
        await _bridge.invokeMethod("goToNative", {"action": "msgList"});
    List<dynamic> jsonList = jsonDecode(string) as List<dynamic>;
    List<AlarmModel> _list = List<AlarmModel>();
    jsonList.forEach((v) => _list.add(AlarmModel.fromJson(v)));
    MyToast.show(
        "消息个数:" + _list.length.toString() + "消息内容:" + _list[0].alarmContent);
    return _list;
  }

  onBack(Map prams) {
    _bridge.invokeMethod("onBack", prams);
  }

  dismiss() {
    if (Platform.isAndroid) {
      _bridge.invokeMethod("dismiss");
    } else {
      _bridge.invokeMethod("onBack");
    }
  }

  Future<dynamic> getVal(String key) async {
    var string = await _bridge.invokeMethod("getVal", {"key": key});
    return string;
  }

  Future<Map<String, String>> getHeaderParams() async {
    Map header = await _bridge.invokeMethod('getHeaderParams', {});
    return this.header = Map<String, String>.from(header);
  }

  MethodChannel bridge() {
    return _bridge;
  }
}
