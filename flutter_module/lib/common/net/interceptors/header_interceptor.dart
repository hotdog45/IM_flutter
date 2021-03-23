import 'dart:collection';
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter_module/common/constant/app_constant.dart';
import 'package:flutter_module/common/unils/local_storage.dart';
import 'package:flutter_module/config/config.dart';


class HeaderInterceptors extends InterceptorsWrapper {
  static const CONTENT_TYPE_FORM = "application/json";

  static String getCookies(List<Cookie> cookies) {
    return cookies.map((cookie) => "${cookie.name}=${cookie.value}").join('; ');
  }
  @override
  onRequest(RequestOptions options) async {
    Map<String, dynamic> headers = HashMap();
    // PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // String token = await LocalStorage.get(AppConstant.USER_TOKEN) ?? "";

    // var cookies = CookieJar().loadForRequest(options.uri);
    // cookies.removeWhere((cookie) {
    //   if (cookie.expires != null) {
    //     return cookie.expires.isBefore(DateTime.now());
    //   }
    //   return false;
    // });
    // String cookie = getCookies(cookies);
    // if (cookie.isNotEmpty){
    //   await LocalStorage.save(AppConstant.USER_COOKIE,cookie);
    // }else{
    //    cookie = await LocalStorage.get(AppConstant.USER_COOKIE) ?? "";
    // }
    // headers["Cookie"] = cookie ?? "";
    // headers["fgim_token_id"] = "account_d71c5fb6-9045-46b3-97ac-c35e3452849b"  ;

    String token = await LocalStorage.get(AppConstant.USER_TOKEN) ?? "";
    headers["fgim-token-id"] = token;

    headers["app-platform"] = Platform.isIOS ? "ios" : "android";
    headers["api-version"] = "1.0";
    headers["APP-ID"] = "8b7ab03aa38c4e7599611aa80df54a12";
    headers["content-type"] = CONTENT_TYPE_FORM;

    options.headers = headers;
    options.connectTimeout = 30000; // 服务器链接超时，毫秒
    options.receiveTimeout = 10000; // 响应流上前后两次接受到数据的间隔，毫秒

    return options;
  }
}
