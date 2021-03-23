import 'dart:convert' as convert;

import 'package:dio/dio.dart';
import 'package:dio_log/dio_log.dart';
import 'package:flutter_module/common/model/base/base_model.dart';
import 'package:flutter_module/common/model/base/old_base_model.dart';
import 'package:flutter_module/common/unils/toast_utils.dart';
import 'package:flutter_module/config/config.dart';

import 'address.dart';
import 'code.dart';
import 'interceptors/header_interceptor.dart';
import 'interceptors/log_interceptor.dart';
import 'interceptors/response_interceptor.dart';

///http请求
class HttpManager {
  Dio _dio = Dio(); // 使用默认配置

  HttpManager() {
    // _dio.interceptors.add(CookieManager(CookieJar()));
    _dio.interceptors.add(HeaderInterceptors());
    _dio.interceptors.add(LogsInterceptors());
    _dio.interceptors.add(DioLogInterceptor());
    // _dio.interceptors.add(ErrorInterceptors(_dio));
    _dio.interceptors.add(ResponseInterceptors());
  }

  ///发起网络请求
  ///[ url] 请求url
  ///[ params] 请求参数
  netFetch(String api, body,
      {noTip = false,
      method = "post",
      useBaseModel = true,
      hostType = 1}) async {
    String apiNum = "1"; //
    resultError(DioError e) {
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = Response(statusCode: 999);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorResponse.statusCode = Code.NETWORK_TIMEOUT;
      }
      if (!noTip) MyToast.show(Config.ERR_MSG1);
      return null;
    }

    resultOk(Response response) async {
      if (hostType == 3){
        Map<String, dynamic> map = convert.jsonDecode(response.data);
        OldBaseModel oldBaseModel = OldBaseModel.fromJson(map);
        if (!useBaseModel) {
          return oldBaseModel;
        }
        if (oldBaseModel.success){
          return oldBaseModel.returnValue;
        }

        //网络报错
        if (!noTip)  MyToast.show(Config.ERR_MSG2);
        return null;
      }
      if (response.data.runtimeType == String) return null;

      BaseModel baseModel = BaseModel.fromJson(response.data);
      if (response == null ||
          response.data == null ||
          response.data.length == 0) {
        //网络报错
        if (!noTip) MyToast.show(Config.ERR_MSG2);
      } else {
        if (!useBaseModel) {
          return baseModel;
        }
        switch (baseModel.code.toString()) {
          case Code.SUCCESS:
            return baseModel.body;
          case Code.INVALID_TOKEN_ERROR: //token失效
            // await LocalStorage.remove(AppConstant.USER_COOKIE);
            // SaveLoginUser.clearUser();//清空登陆数据
            return response.data;
          default:
            if (baseModel.message != null &&
                baseModel.message.length > 1 &&
                !noTip) {
              MyToast.show(baseModel.message ?? "");
            }
            break;
        }
      }
      return response.data;
    }

    Response response;
    try {

        response = await _dio.request(getHostAddress(apiNum, hostType) + api,
            data: body, options: Options(method: method));


    } on DioError catch (e) {
      return resultError(e);
    }
    if (response.data is DioError) {
      return resultError(response.data);
    }
    return resultOk(response);
  }
}

final HttpManager httpManager = HttpManager();
