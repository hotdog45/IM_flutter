import 'package:flutter_module/config/config.dart';
////////////////////// -start - api -start///////////////////////////
///host1 验证码
const String securityCode = "app/security_code";

//账号 密码登陆
const String accountLogin = "account/signin";
//账号 注册
const String accountNew = "account/new";
//修改密码
const String accountPasswordSet = "account/password/set";
//反查accId
const String accountAccId = "account/acc_id";
/// 领红包
const String accountRedPay = "account/red/pay";
/// 红包记录
const String accountRedGet = "account/red/get";
//通知
const String appNotice = "app/notice";
// 账单列表
const String accountBill = "account/bill";
//  设置管理员
const String groupLevelSet = "account/group/level/set";
// 获取禁言列表
const String groupBanUserList = "account/group/ban/user/list";
// 禁言用户
const String groupBanUser = "account/group/ban/user";
// 禁言 整个群
const String groupBan = "account/group/ban";


//////////////////////host2 发红包/////////////////////////////////////
const String tradingGiveRedPacket = "trading/v1/giveRedPacket";
//转账
const String tradingTransfer = "trading/v1/transfer";
//查询账户信息
const String accountQueryAccount = "accountQuery/v1/queryAccount";
//设置交易密码
const String operateSetTradePwd = "operate/v1/setTradePwd";
// 查询账单 分页
const String tradeQueryBill = "tradeQuery/v1/queryBill";

//bindInfoQuery/v1/queryBindCardList 银行卡
const String bindInfoQueryBindCardList = "bindInfoQuery/v1/queryBindCardList";


//////////////////////////end - api -end/////////////////////////////////
/// host0 老的
const String BASE_HOST_RELEASE = "http://dimweb.yuanxu.co/rest_post";
/// host1
const String BASE_URL_RELEASE = "http://dweb.yuanxu.co/v1/"; //线上
const String BASE_URL_DEV = "http://dweb.yuanxu.co/v1/"; //开发

/// host2
const String BASE_URL2_RELEASE = "http://dtrace.yuanxu.co/"; //线上
const String BASE_URL2_DEV = "http://dtrace.yuanxu.co/"; //开发

/// 网页h5
const String BASE_URL_H5_RELEASE = "https://h5.ypshengxian.com"; //线上
const String BASE_URL_H5_DEV = "https://dev-h5.ypshengxian.com"; //开发

/// 图片服务器
const String BASE_URL_IMAGE_RELEASE = "http://image.hhsas.com/"; //线上
const String BASE_URL_IMAGE_DEV = "http://image.hhsas.com/"; //开发

/// Url
getHostAddress(num, type) {
  if (type == 1) {
    switch (num) {
      case Config.KEY_API_HOST_RELEASE:
        return BASE_URL_RELEASE;
      default:
        return BASE_URL_DEV;
    }
  } else if (type == 3) {
    switch (num) {
      case Config.KEY_API_HOST_RELEASE:
        return BASE_HOST_RELEASE;
      default:
        return BASE_HOST_RELEASE;
    }
  } else {
    switch (num) {
      case Config.KEY_API_HOST_RELEASE:
        return BASE_URL2_RELEASE;
      default:
        return BASE_URL2_DEV;
    }
  }
}

/// 获取不同环境的网页
getBaseH5Url(apiNum) {
  switch (apiNum) {
    case Config.KEY_API_HOST_RELEASE:
      return BASE_URL_H5_RELEASE;
    default:
      return BASE_URL_H5_DEV;
  }
}

///获取不同环境的图片服务器
getBaseIMAGEUrl(apiNum) {
  switch (apiNum) {
    case Config.KEY_API_HOST_RELEASE:
      return BASE_URL_IMAGE_RELEASE;
    default:
      return BASE_URL_IMAGE_DEV;
  }
}
